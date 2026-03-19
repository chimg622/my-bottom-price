class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    # 統計情報を表示すると「自分のデータが貯まった感」が出てUXが向上します
    @shops_count = @user.shops.count
    @items_count = @user.items.count
    @prices_count = @user.prices.count
  end
end
