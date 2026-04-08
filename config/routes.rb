Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :items, only: [:index, :new, :create, :edit, :update]
  resources :prices, only: [:index, :new, :create, :edit, :update]
  resources :shops, only: [:index, :new, :create, :edit, :update, :destroy]
  resource :user, only: :show
end
