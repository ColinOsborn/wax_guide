Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'
  resources :home, only: [:index]
  resources :tips, only: [:index]
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]

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
