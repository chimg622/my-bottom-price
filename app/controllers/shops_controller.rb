class ShopsController < ApplicationController
  before_action :set_shop, only: [:edit, :update, :destroy]

  def index
    @shops = current_user.shops.includes(:prices).order(created_at: :desc)
  end

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @shop.update(shop_params)
      redirect_to shops_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop.destroy
    redirect_to shops_path
  end

  private

  def set_shop
    @shop = current_user.shops.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:name, :address).merge(user_id: current_user.id)
  end
end
