Rails.application.routes.draw do
  root 'users#new'

  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')

  delete '/logout', to: 'users#destroy'

  put 'select_team_leads', to: 'users#team_leads', as: :select_team_leads
  put '/reviews/:review_id/approve_goals_by_team_lead',
      to: 'goals#approve_goals', as: :approve_goals_by_team_lead

  resources :reviews do
    resources :goals do
      collection do
        get 'feedback'
        post 'submit_feedback'
      end
    end
  end

  resources :goals

  resources :users do
    collection do
      get 'team_members'
      get 'all_reviews'
    end
  end
end
