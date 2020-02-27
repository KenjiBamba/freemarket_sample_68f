class OrdersController < ApplicationController
  before_action  :set_item

  require 'payjp'

  def index
    card = Card.where(user_id: current_user.id).first
   
  end

  def done
    
  end

  def new
    @item = Item.find(params[:item_id])
    @user = User.find(@item.user_id)
    @order = Order.new
  end

  def create
  end


  def pay
    @item = Item.find(params[:item_id])
    @item.update(order_id: current_user.id)
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => 1000, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.order_id, #顧客ID
    :currency => 'jpy', #日本円
    
  )
  
    @order = Order.new(item_id: params[:item_id], user_id: current_user.id)   
    @order.save
    redirect_to item_orders_path
  end



  private
  def set_item
    @item = Item.find(params[:item_id])
  end

 

end
