class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  
  
  def deny_access
    redirect_to login_path, :notice => "Please sign in to access this page"
  end
  helper_method :deny_access
  
   def create_formatted_order_items(order_items)
     order_items_formatted = Hash.new
     order_items.each do |item_id, qty|
       order_items_formatted[MenuItem.find(item_id)] = qty.to_i
     end
     order_items_formatted
   end
   helper_method :create_formatted_order_items
end
