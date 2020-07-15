Rails.application.routes.draw do
  
  get 'sessions/new'
  # get 'users/new'
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  resources :users
  resources :microposts
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end

