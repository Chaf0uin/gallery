Rails.application.routes.draw do

	namespace :api, defaults: {format: 'json'} do
    	namespace :v1 do
      		resources :albums
      		resources :photos
    	end
  	end

  	resources :albums 
  	resources :photos

  	root :to => 'albums#index'
end
