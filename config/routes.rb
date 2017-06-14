Rails.application.routes.draw do

  root 'users#new'

  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')

  delete '/logout',  to: 'users#destroy'

  put 'select_team_leads', to: 'users#team_leads', as: :select_team_leads
  put '/reviews/:review_id/approve_goals_by_team_lead', to: 'goals#approve_goals', as: :approve_goals_by_team_lead

  #TODO use only action routes
  resources :reviews do
     resources :goals do
       member do
         get 'feedback'
         post 'submit_feedback'
       end
     end
  end

  resources :goals

  #TODO use only action routes
  resources :users do
    member do
      get 'reviews'
      get 'team_members'
    end
  end
end
