class Micropost < ApplicationRecord
  belongs_to       :user
  has_many :comments, dependent: :destroy
  has_many :favorite_relationships, dependent: :destroy
  has_many :liked_by, through: :favorite_relationships, source: :user
  has_many :notifications, dependent: :destroy
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  scope :search_by_keyword, -> (keyword) {
    where("microposts.content LIKE :keyword", keyword: "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
  validates :user_id, presence:true
  validates :content, presence:true, length: {maximum: 140 }
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                                      message: "must be a valid image format" },
                      size:         { less_than: 5.megabytes,
                                      message: "should be less than 5MB" }
                                      
  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_fill: [250, 250])
  end
  
  # いいね通知
  def create_notification_like!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and micropost_id = ? and action = ? ",
                                  current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        micropost_id: id,
        visited_id: user_id,
        action: 'like'
      )

      if notification.visitor_id == notification.visited_id
         notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  # コメント通知
  def create_notification_comment!(current_user, comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = Comment.where(micropost_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct
    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    #投稿者へ通知を作成
    save_notification_comment!(current_user, comment_id, user_id)
  end
    
  def save_notification_comment!(current_user, comment_id, visited_id)
      notification = current_user.active_notifications.new(
        micropost_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
  end
end
