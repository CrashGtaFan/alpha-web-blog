Rails.application.routes.draw do
  get 'users/new'

  get 'pages/about'
  get 'signup', to: 'users#new'

  root to: 'pages#welcome'
  resources :articles
  resources :users, except: [:new]
end
