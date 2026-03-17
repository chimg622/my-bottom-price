class ShopsController < ApplicationController
  before_action :authenticate_user!
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

  private

  def shop_params
    params.require(:shop).permit(:name, :address).merge(user_id: current_user.id)
  end
end
