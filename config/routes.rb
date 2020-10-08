Rails.application.routes.draw do

  root to: 'home#index'
  resources :home, only: [:index]
  resources :tips, only: [:index]
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]

  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'

  post "zipcode" => "home#zipcode"
  post "location" => "home#location"

end
