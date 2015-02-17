Rails.application.routes.draw do

  authenticated :user do
    root :to => "albums#index", :as => "authenticated_root"
  end

  devise_for :users

	namespace :api, defaults: {format: 'json'} do
    	namespace :v1 do
      		resources :albums
      		resources :photos
    	end
  	end

  resources :users, only: [:show]
  resources :albums 
  resources :photos do
    resources :comments
  end

  root :to => 'welcome#index'
end
