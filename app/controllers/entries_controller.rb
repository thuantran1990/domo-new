class EntriesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,only: :destroy
	def create
		@entry = current_user.entries.build(entri_params)
		@entry.image.attach(params[:entry][:image])
		if @entry.save
			flash[:success] = "Entry created!"
			redirect_to root_url
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'static_pages/home'
		end
	end
	def destroy
		@entry.destroy
		flash[:success] = "entry deleted"
		redirect_to request.referrer || root_url
	end
	def show
		
		@entry = Entry.find_by(id: params[:id])
		@entry_comment = @entry.entry_comments.build
		@entry_comments = @entry.entry_comments.sort_by_created.paginate(page: params[:page])
	end
	private
	def entri_params
		params.require(:entry).permit(:content,:image)
	end
	def correct_user
		@entry = current_user.entries.find_by(id: params[:id])
		redirect_to root_url if @entry.nil?
	end
end
