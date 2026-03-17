Rails.application.routes.draw do
  devise_for :users
  root to: "prices#index"
  resources :items, :prices, :shops, :categories
end
