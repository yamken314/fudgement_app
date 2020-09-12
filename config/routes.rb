Rails.application.routes.draw do
  
  get 'sessions/new'
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/about'
  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts
  resources :choices, only: [:post, :destroy] do
    resource :vote, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end


