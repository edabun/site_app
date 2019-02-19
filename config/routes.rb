Rails.application.routes.draw do
  get 'sessions/new'
  root 'pages#home'
  get '/about',     to: 'pages#about'
  get '/signup',    to: 'users#new'
  post '/signup',   to: 'users#create'
  get '/login',     to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/sites',     to: 'sites#index'
  resources :users
  resources :sites, only: [:index, :create, :destroy, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
