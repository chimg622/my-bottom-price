# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    return unless user_signed_in?

    # 最近登録した「商品」を3件取得（ includes でカテゴリも取得 ）
    @recent_items = current_user.items.includes(:category).order(created_at: :desc).limit(3)
    # 最近の「価格記録」を5件取得
    @recent_prices = current_user.prices.includes(:item, :shop).order(created_at: :desc).limit(5)
  end
end
