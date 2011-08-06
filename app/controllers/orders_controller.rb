class OrdersController < ApplicationController
  def new
    @order_items = params[:order_items]
    @order_items_formatted = Hash.new
    @order_items.each do |item_id, qty|
      @order_items_formatted[MenuItem.find(item_id)] = qty if qty.to_i > 0
    end
    @order = Order.new(:order_items => @order_items)
    render 'delivery'
  end

  def save
    @order = Order.new(params[:order])
    if @order.save
      render 'complete'
    else
      flash[:error] = "Please supply name and phone"
      render 'delivery'
    end
  end
end

