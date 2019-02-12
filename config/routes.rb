Rails.application.routes.draw do
  get 'pages/about'

  root to: 'pages#welcome'
  resources :articles
end
