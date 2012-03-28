Pomhub::Application.routes.draw do
  devise_for :users

  resources :users do
    resources :pomodoros do
      collection do
        post :start
        post :stop
      end
    end
  end

  resources :organizations do
    resources :memberships do
      member do
        put :approve
        put :reject
      end
    end
  end

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure', to: 'users#index'

  root :to => 'users#index'

end
