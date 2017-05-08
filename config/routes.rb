Rails.application.routes.draw do


  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  delete '/logout',  to: 'users#destroy'
  put 'select_team_leads', to: 'users#team_leads', as: :select_team_leads

  resources :reviews
  resources :users
  root 'users#new'


end
