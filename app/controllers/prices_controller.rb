class PricesController < ApplicationController
  def index
    if params[:item_id]
      @item = current_user.items.find(params[:item_id])
      @prices = @item.prices.includes(:shop).order(unit_price: :asc)
    else
      redirect_to root_path
    end
  end

  def new
    @price = Price.new
    set_form_collections
    @price.item_id = params[:item_id] if params[:item_id]
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      redirect_to prices_path(item_id: @price.item_id)
    else
      set_form_collections
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_form_collections
    @items = current_user.items
    @shops = current_user.shops
  end

  def price_params
    params.require(:price).permit(:item_id, :shop_id, :price, :quantity, :unit).merge(user_id: current_user.id)
  end
end
