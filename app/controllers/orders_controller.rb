class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :new, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :prevent_url, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def prevent_url
    return unless @item.user_id == current_user.id || !@item.order.nil?

    redirect_to root_path
  end
end
