class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :destroy]

  def index
    @items = current_user.items.includes(:category).order(created_at: :desc)
  end

  def new
    @item = Item.new
    @categories = current_user.categories
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @categories = current_user.categories
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = current_user.categories
  end

  def update
    if @item.update(item_params)
      redirect_to items_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def set_item
    @item = current_user.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :unit, :category_id).merge(user_id: current_user.id)
  end
end
