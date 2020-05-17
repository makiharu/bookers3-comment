Rails.application.routes.draw do
  root 'home#top'
  get 'home/about' => "home#about"

  devise_for :users

  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    
    resource :comments, only: [:create, :edit, :update, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  

end