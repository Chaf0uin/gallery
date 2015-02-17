module Api
	module V1
    	class AlbumsController < ApplicationController

    		respond_to :json
      
      		def index
      			@albums = Album.all
      			@albums.each do |album|
      				if album.photos.first
      					album.token = album.photos.first.image.url
      				end	
      			end	
        		respond_with @albums
      		end
      
      		def show
            respond_with Album.find(params[:id]).photos
      		end
      
      		def create
        		respond_with Album.create(params[:albums])
      		end
      
      		def update
        		respond_with Album.update(params[:id], params[:albums])
      		end
      
      		def destroy
        		respond_with Album.destroy(params[:id])
      		end
      
    	end
  	end
end