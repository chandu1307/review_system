Rails.application.routes.draw do


  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')
  delete '/logout',  to: 'users#destroy'
  put 'select_team_leads', to: 'users#team_leads', as: :select_team_leads
  get 'team_hierarchy', to: 'users#team_hierarchy', as: :team_hierarchy

  resources :reviews
  resources :users
  root 'users#new'


end
