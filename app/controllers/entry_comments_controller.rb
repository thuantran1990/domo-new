class EntryCommentsController < ApplicationController
	before_action :logged_in_user, only: [:create]
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
end
