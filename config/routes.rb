Rails.application.routes.draw do


  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  delete '/logout',  to: 'users#destroy'
  resources :reviews
  root 'users#new'


end
