Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products, only: [:new, :create]
end
