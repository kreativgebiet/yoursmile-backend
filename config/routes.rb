Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)

  root to: 'application#root'

  resources :projects
  resources :uploads

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
end
