class MenuItemsController < ApplicationController
  def create
     @menu_item = MenuItem.new(params[:menu_item])
      @menu_item.save
      respond_to do |format|
        format.html { redirect_to @menu_item.menu_section.restaurant }
        format.js
      end
  end

  def destroy
  end

end
