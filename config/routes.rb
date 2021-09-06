Rails.application.routes.draw do
  devise_for :users
  
  root to: 'home#index'
  resources :home, only: [:index]
  resources :tips, only: [:index]

  resources :users do
    resources :skis
  end

  resource :dashboard, only: [:show]

  get 'login' => 'user_sessions#new'
  get 'logout' => 'user_sessions#destroy'

  post "zipcode" => "home#zipcode"
  post "search" => "home#search"
  post "location" => "home#location"
end
