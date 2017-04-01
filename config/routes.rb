Rails.application.routes.draw do
  root 'main_pages#home'
  
  devise_for :users
  resources :products, only: [:index, :new, :create, :show]
end
