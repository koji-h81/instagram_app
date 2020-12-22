class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      if params[:q]
        @feed_items = Micropost.search_by_keyword(params[:q])
                                       .paginate(page: params[:page])
      else
        @feed_items = current_user.feed.paginate(page: params[:page])
      end
    end
  end

  def search
  end

  def notice
  end

  def mypage
  end

  def upload
  end
  
  def contact
  end
end
