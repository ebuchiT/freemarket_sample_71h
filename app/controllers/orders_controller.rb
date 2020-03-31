class OrdersController < ApplicationController
  def show
    @item = Item.find(params[:id])
  end

  def create
    @item= Item.find(params[:id])
    @item.update( buyer_id: current_user.id)
  end
  
  require 'payjp'
  def purchase
    @item = Item.find(params[:id])
    if @item.update( buyer_id: current_user.id)
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      Payjp::Charge.create(currency: 'jpy', amount:1000, card: params['payjp-token'])
      redirect_to root_path, notice: "支払いが完了しました"
    else 
      flash[:notice] = "支払いが失敗しました"
    end
  end
end