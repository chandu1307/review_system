Rails.application.routes.draw do
  root 'users#new'

  get 'auth/:provider/callback', to: 'users#create'
  get 'auth/failure', to: redirect('/')

  resources :reviews, only: [:index] do
    resource :goals, only: [:new, :edit, :show, :create, :update] do
      member do
        get 'feedback'
        post 'submit_feedback'
        put 'approve'
      end
    end
  end

  resources :users, only: [:index, :new, :create] do
    delete 'logout'
    collection do
      get 'team_members'
      get 'all_reviews'
      get 'reviews_by_quarter'
      put 'team_leads'
    end
  end
end
