class CommentsController < ApplicationController
	
	def create
		@photo = Photo.find(params[:photo_id])
	    @comment = @photo.comments.create(comment_params)
	    redirect_to photo_path(@photo)
	end

	def destroy
	    @photo = Photo.find(params[:photo_id])
	    @comment = @photo.comments.find(params[:id])
	    @comment.destroy
	    redirect_to photo_path(@photo)
	end

	private
    def comment_params
    	params[:comment][:commenter] = current_user.id
		params[:comment][:creation_date] = Time.now
    	params.require(:comment).permit(:commenter, :body)
    end  

    
end
