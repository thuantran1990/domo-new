class EntryCommentsController < ApplicationController
	before_action :logged_in_user, only: [:create]

	before_action :correct_user, only: [:edit, :update]
	def show

	end
	def create

	    @entry = Entry.find_by id: entrycomment_params[:entry_id]
		@entrycomment = @entry.entry_comments.build(entrycomment_params)
		@entrycomment.user = current_user
			if @entrycomment.save!
				flash[:success] = "Commnen created!"
				redirect_to request.referrer
    		end
    	end

	  def destroy
	    @entry_comment = EntryComment.find_by id: params[:id]
	    @entry_comment.destroy
	    redirect_to @entry_comment.entry
	  end
	  def edit
		@entry_comment = EntryComment.find_by id: params[:id]
	  end

	  def update
			@entry_comment = EntryComment.find_by id: params[:id]
			if @entry_comment.update(entrycomment_params)
				flash[:success] = "Profile updated"
				redirect_to @entry_comment.entry
			end
		end	
	  private
	  def entrycomment_params
	  	params.require(:entry_comment).permit(:content, :entry_id, :user_id)
	  end

	  
	  def correct_user
		@user = User.find_by(id: params[:id])
		redirect_to(root_url) unless current_user?(@user)
 	 end

end
