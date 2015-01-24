module Api
	module V1
    	class PhotosController < ApplicationController

    		respond_to :json
      
      		def index
        		respond_with Photo.all
      		end
      
      		def show
        		respond_with Photo.find(params[:id])
      		end
      
      		def create
        		respond_with Photo.create(params[:photos])
      		end
      
      		def update
        		respond_with Photo.update(params[:id], params[:photos])
      		end
      
      		def destroy
        		respond_with Photo.destroy(params[:id])
      		end
      
    	end
  	end
end