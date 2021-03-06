Rails.application.routes.draw do
  get 'toppages/index'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  root to: 'toppages#index'
  resources :tasks
  post "/", to: "tasks#create"
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create]
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
