Rails.application.routes.draw do
  resources :tasks do
    resources :task_comments
  end
  resources :projects
  resources :teams
  root 'application#hello'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login',   to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :teams do
    member do
      put "add_user/:user_id", action: :add_user, as: :add_user
      put "delete_user/:user", action: :delete_user, as: :delete_user
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
