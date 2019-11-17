Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  namespace :front, path: '/' do
    root 'answers#index'

    resources :answers, only: %i[index new show create edit update]
    resources :layers, only: %i[new create]
    resources :categories, only: %i[new create]
  end

  namespace :admin do
    root 'users#index'

    resources :users do
      scope module: :users do
        resources :answers, only: :index
      end
    end

    resources :categories, only: %i[index new create]
    resources :layers, only: %i[index edit new create update] do
      member do
        put :sort
        patch :accept
      end
    end
  end

  get '*anything' => 'errors#routing_error'
end
