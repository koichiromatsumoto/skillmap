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
      get '/edit_password', to: 'users#edit_password', as: 'edit_password'
      patch '/update_password', to: 'users#update_password', as: 'update_password'
      scope module: :users do
        resources :answers, only: %i[index show]
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
