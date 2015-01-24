class PhotosController < ApplicationController

	def index

    	@album = Album.find(params[:album_id])

    	@photos = @album.photos

	end


	def show
    	@photo = Photo.find(params[:id])

	end


  	def new
    	@album = Album.find(params[:album_id])
    	@photo = @album.photo.build

	end

	def edit
  		@photo = Photo.find(params[:id])
  	end

	def create
    	@photo = Photo.new(params[:picture])

    	if @photo.save
      		respond_to do |format|
        		format.html {
          			render :json => [@picture.to_jq_upload].to_json,
          			:content_type => 'text/html',
          			:layout => false
        		}
        		format.json {
          			render :json => [@picture.to_jq_upload].to_json
        		}
      		end
    	else
      		render :json => [{:error => "custom_failure"}], :status => 304
    	end
  	end


  	def update

	    @album = Album.find(params[:album_id])

    	@photo = @album.photos.find(params[:id])

      	if @photo.update_attributes(photo_params)
        	redirect_to album_path(@album), notice: 'Picture was successfully updated.'
      	else
        	render action: "edit"
      	end
    end


	def destroy
    	@photo = Photo.find(params[:id])
    	@photo.destroy

	    edirect_to root_path 
  	end

  	def make_default
    	@photo = Photo.find(params[:id])
    	@album = Album.find(params[:album_id])

    	@album.cover = @photo.id
    	@album.save

    	respond_to do |format|
      		format.js
   		end
  	end

  	private
	def photo_params
    	params.require(:photo).permit(:description, :album_id, :image)
  	end
end
