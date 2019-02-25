Rails.application.routes.draw do
  
   root 'homepage#show'

   get '/search', to: 'search#index'
   
   resources :locations, only: [:index, :show]

end
