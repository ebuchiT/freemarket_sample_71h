class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.where("name LIKE ?", "%#{params[:name]}%")
    @item = Item.all

  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
      flash[:notice] = "出品しました"
    end
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all
    @images = Image.all
  end

  def edit
    @item = Item.find(params[:id])
    @images = Image.all.includes(:item)
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      flash[:notice] = "商品情報を更新しました"
      redirect_to root_path
    else
      flash[:notice] = "商品情報を更新に失敗しました"
      render :edit
    end
  end

  def destroy
  end

  private
  def item_params
    params.require(:item).permit(:name, :content, :price, :item_condition_id,
    :prefecture_id, :postage_payer_id, :preparation_day_id, :brand, 
    :item_situation_id, images_attributes: [:id, :src]).merge(user_id: current_user.id)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end