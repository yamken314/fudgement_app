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
  post '/guest_sign_in', to: 'sessions#new_guest'
  get 'auth/:provider/callback', to: 'sessions#create'
  get "/auth/failure", to: "sessions#failure"
  resources :users do
    member do
      get :following, :followers
      delete :delete_profile_image, :delete_avatar
    end
  end
  resources :microposts
  resources :choices, only: [:post, :destroy, :edit, :update] do
    resource :vote, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end


