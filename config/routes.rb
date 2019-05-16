Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root to: 'api#root'

  resources :projects, only: [:index, :show] do
    resources :donations, only: [:new, :create] do
      collection do
        get :paypal
        get :stripe
        post :stripe_charge
        get :paypal_callback
      end
    end
  end

  resources :uploads do
    resources :comments

    member do
      post :like
      post :report
      post :pay
    end
  end

  resources :sources, only: [:index, :create]

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  resources :user do
    member do
      post :follow

      get :uploads
      get :followers
      get :following
      get :supported_projects
    end
    if Rails.env.development?
      collection do
        get :dev_sign_in
      end
    end
  end

  post '/user/:id/follow' => 'user#follow'
  get '/auth/followers' => 'user#followers'
  get '/auth/following' => 'user#following'
end
