class OrdersController < ApplicationController  
  def new
    @order_items = params[:order_items]
    @order_items.delete_if{ |key,value| value.to_i <= 0 }
  
    @order_items_formatted = create_formatted_order_items(@order_items)
   
    @order = Order.new(params[:order])
    @order.order_items = @order_items
    
    render 'delivery'
  end

  def save
    @order = Order.new(params[:order])
    @order.order_items = eval(@order.order_items)
    @order_items_formatted = create_formatted_order_items(@order.order_items)
    if @order.save
      render 'complete'
    else
      flash.now[:error] = "Please supply name and phone"
      render 'delivery'
    end
  end  
end

