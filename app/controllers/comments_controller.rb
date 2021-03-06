class CommentsController < ApplicationController
  
  before_action :logged_in_user, only: :create

  def create 
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = params[:micropost_id]
    if @comment.save
      flash[:success] = 'コメントしました'
      #通知機能用
      @micropost=@comment.micropost
      @micropost.create_notification_comment!(current_user, @comment.id)
      #ここまで通知機能
      redirect_to @comment.micropost
    else
      @micropost = Micropost.find(params[:micropost_id])  
      @comments = @micropost.comments
      render template: 'microposts/show'
    end
  end
  
  before_action :correct_user,   only: :destroy
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to @comment.micropost
  end
  
   private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end