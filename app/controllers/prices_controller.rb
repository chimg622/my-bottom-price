class PricesController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:item_id]
      @item = current_user.items.find(params[:item_id])
      @prices = @item.prices.includes(:shop).order(unit_price: :asc)
    else
      @prices = current_user.prices.includes(:item, :shop).order(created_at: :desc)
    end
  end

  def new
    @price = Price.new
    @items = current_user.items
    @shops = current_user.shops
    @price.item_id = params[:item_id] if params[:item_id]
  end

  def create
    @price = current_user.prices.build(price_params)
    if @price.price.present? && @price.quantity.present? && @price.quantity > 0
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
