Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :items, only: [:index, :new, :create]
  resources :prices, only: [:index, :new, :create]
  resources :shops, only: [:index, :new, :create]
  resource :user, only: :show
end
