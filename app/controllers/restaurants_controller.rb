require 'orders_helper'

class RestaurantsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create]
  before_filter :authenticate_restaurant_user, :only => [:orders, :upload, :import]
  
  def index
    @restaurants = Restaurant.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurants }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    
    @order = Order.new
        
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])

    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update_attributes(params[:restaurant])
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    redirect_to restaurants_url
  end
  
  def orders
    @orders = Order.find_all_by_restaurant_id(params[:id])
    @order_items = {}
    @orders.each{|o| @order_items[o.id] = []; o.order_items.each_pair{|k,v| @order_items[o.id] <<  v + " x " + MenuItem.find(k).name } }
  end
  
  def upload 
  end
  
  def import
    @restaurant = Restaurant.find(params[:id])
    file = params[:file]
    open(file.path).each { |line| process_import_line(line, @restaurant) }
    redirect_to @restaurant
  end
  
  private

   def authenticate
     deny_access unless current_user && current_user.admin
   end
   
   def authenticate_restaurant_user
     if current_user && current_user.restaurant == Restaurant.find(params[:id])
      return
    else
      authenticate
    end
   end
   
   def process_import_line(line, restaurant)
     (section, name, price) = line.split(',')
     restaurant.menu_sections.create!({:name => section}) unless restaurant.has_menu_section?(section)
     MenuSection.find_by_restaurant_id_and_name(restaurant.id, section).menu_items.create!(:name => name, :price => price)
   end
end
