Rails.application.routes.draw do
  devise_for :users, path: '',  path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  root to: 'home#index'
  resources :home, only: [:index]
  resources :tips, only: [:index]
  resources :ski_brands

  resources :users do
    resources :skis
  end

  resource :dashboard, only: [:show]

  post "search" => "home#search"
  post "location" => "home#location"
end
