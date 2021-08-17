Rails.application.routes.draw do

resources :subscriptions
  resources :videos
 #resources :subscription

  devise_for :users
  resources :projects
  root to: 'projects#index'
end
