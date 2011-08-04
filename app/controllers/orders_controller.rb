class OrdersController < ApplicationController
  def new
    @order = Order.new(params[:order])
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

