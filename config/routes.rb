Rails.application.routes.draw do
  root "static_pages#home"
  get  "/help",    to: "static_pages#help"
  get  "/about",   to: "static_pages#about"
  get  "/contact", to: "static_pages#contact"
  get '/signup', to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :users
  resources :episodes,      only: [:index, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :tags, only: [:create, :destroy]
  get '/episodes', to: 'static_pages#home'
end
