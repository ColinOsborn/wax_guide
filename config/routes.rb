Rails.application.routes.draw do

  root to: 'home#index'
  resources :home, only: [:index]

  post "zipcode" => "home#zipcode"
  post "location" => "home#location"

end
