# app/controllers/prices_controller.rb
class PricesController < ApplicationController
  before_action :authenticate_user!

  def new
    @price = Price.new
    # プルダウン用のデータ準備
    @items = current_user.items
    @shops = current_user.shops

    # もし「商品一覧」から遷移してきた場合、商品を選択状態にする
    @price.item_id = params[:item_id] if params[:item_id]
  end

  def create
    @price = current_user.prices.build(price_params)

    # 保存前に「単位価格(unit_price)」を計算してセットする
    if @price.price.present? && @price.quantity.present? && @price.quantity > 0
      # 100g/mlあたりの計算（単位が"個"なら1個あたり）
      base = @price.unit == 'piece' ? 1 : 100
      @price.unit_price = (@price.price.to_f / @price.quantity) * base
    end

    if @price.save
      redirect_to items_path, notice: '価格を記録しました！'
    else
      @items = current_user.items
      @shops = current_user.shops
      render :new, status: :unprocessable_entity
    end
  end

  private

  def price_params
    params.require(:price).permit(:item_id, :shop_id, :price, :quantity, :unit)
  end
end
