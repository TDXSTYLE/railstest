Rails.application.routes.draw do

resources :subscriptions
  resources :videos
 #resources :subscription

  devise_for :users
  resources :projects
  #root to: 'projects#index'
  resource :config_nerd, only: [:edit, :update], path: "admin"
  root to: 'welcome#index'
end
