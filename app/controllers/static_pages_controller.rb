class StaticPagesController < ApplicationController
  def home
  	if logged_in?
		@entry = current_user.entries.build
		@feed_items = current_user.feed.sort_by_created.paginate(page: params[:page])
	end
  end

  def help
  end
end
