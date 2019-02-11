Rails.application.routes.draw do
  get 'pages/about'

  root to: 'pages#welcome'
end
