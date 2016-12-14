Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root to: 'api#root'

  resources :projects, only: [:index, :show]
  resources :uploads do
    resources :comments
  end

  resources :sources, only: [:index, :create]

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
end
