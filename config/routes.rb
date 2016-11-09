Rails.application.routes.draw do
  root to: 'application#root'

  resources :projects
  resources :uploads

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
end
