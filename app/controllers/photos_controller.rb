class PhotosController < ApplicationController

  before_action :authenticate_user!

	def index
    	@album = Album.find(params[:album_id])
    	@photos = @album.photos

	end


	def show
    	@photo = Photo.find(params[:id])

  

      if @photo.comments
        @photo.comments.each { |comment|
          user = User.find(comment.commenter)
          comment.commenter = user.username
        }
      end

      @previous_photo = @photo.previous

      if (@previous_photo == nil) 
        @previous_photo = nil
      else  
        if (@previous_photo.album_id != @photo.album_id)
          @previous_photo = nil
        end  
      end

      @next_photo = @photo.next

      if (@next_photo == nil) 
        @next_photo = nil
      else
        if (@next_photo.album_id != @photo.album_id)
          @next_photo = nil
        end  
      end

      

      respond_to do |format|
      format.html
      format.json { 
        if @previous_photo.nil?
          previous_photo = nil;
        else
          previous_photo = @previous_photo.id;  
        end

        if @next_photo.nil?
          next_id = nil;
        else
          next_id = @next_photo.id;  
        end  

        render :json => {:photo => @photo, 
          :previous_photo => previous_photo,
          :next_photo => next_id,
          :comments => @photo.comments }
        }
    end
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

    params[:photo][:user_id] = current_user.id
   	@photo = @album.photos.find(params[:id])

   	if @photo.update_attributes(photo_params)
     	redirect_to album_path(@album), notice: 'Picture was successfully updated.'
   	else
     	render action: "edit"
   	end
  end


	def destroy
    @photo = Photo.find(params[:id])
    album = @photo.album
    @photo.destroy
    redirect_to album_path(album.id)
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
    params[:photo][:user_id] = current_user.id
  	params.require(:photo).permit(:description, :album_id, :image)
  end
end
