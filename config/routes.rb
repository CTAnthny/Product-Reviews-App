Rails.application.routes.draw do
  root 'main_pages#home'

  devise_for :users
  resources :products do
    resources :comments, shallow: true
  end
end
