Rails.application.routes.draw do
  devise_for :users

  root 'product#index'
end
