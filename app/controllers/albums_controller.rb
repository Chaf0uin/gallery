class AlbumsController < ApplicationController

	def index
    	@albums = Album.all
  	end

	def show
    	@album = Album.find(params[:id])
    	@photos = @album.photos
  	end

	def new
		@album = Album.new
  	end


  	def edit
  		@album = Album.find(params[:id])
	end

 	def create
  		@album = Album.new(album_params)
 
  		if @album.save

        if params[:images]
          params[:images].each { |image|
            @album.photos.create(image: image)
          }
        end

  			redirect_to @album
  		else
  			render 'new'
  		end		
  	end  	

  
	def update
  		@album = Album.find(params[:id])
 
 		if @album.update_attributes(album_params)
      		if params[:images]
        		params[:images].each { |image|
        			@album.photos.create(image: image)
        		}
        end    
    		redirect_to @album
  		else
    		render 'edit'
  		end
	end


	def destroy
    	@album = Album.find(params[:id])
    	@album.destroy
 
    	redirect_to albums_path
  	end

  	private
  	def album_params
    	params.require(:album).permit(:description, :name, :photos)
	end
end
