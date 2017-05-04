Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root to: 'api#root'

  resources :projects, only: [:index, :show]
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
  end

  post '/user/:id/follow' => 'user#follow'
  get '/auth/followers' => 'user#followers'
  get '/auth/following' => 'user#following'
end
