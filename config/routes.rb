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
        get 'self_rating'
        post 'submit_self_rating'
      end
    end
  end

  resources :users, only: [:index, :new, :create, :show] do
    delete 'logout'
    member do
      put :toggle_state
    end
    collection do
      get 'team_members'
      get 'all_reviews'
      get 'reviews_by_quarter'
      put 'team_leads'
      get 'team_hierarchy'
    end
  end
end
