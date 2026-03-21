class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @shops_count = @user.shops.count
    @items_count = @user.items.count
    @prices_count = @user.prices.count
  end
end
