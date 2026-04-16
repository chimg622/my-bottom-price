# app/controllers/home_controller.rb
class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @recent_items = current_user.items.includes(:category).order(created_at: :desc).limit(3)
    @recent_prices = current_user.prices.includes(:item, :shop).order(created_at: :desc).limit(5)
  end
end
