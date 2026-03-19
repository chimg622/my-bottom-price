Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :items, :prices, :shops, :categories
  resource :user, romantic: :show # 単数形のリソースとして定義
end
