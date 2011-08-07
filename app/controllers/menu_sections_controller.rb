class MenuSectionsController < ApplicationController
  def create
    @menu_section = MenuSection.new(params[:menu_section])
    @menu_section.save
    respond_to do |format|
      format.html { redirect_to @menu_section.restaurant }
      format.js
    end
  end
  
  def destroy
    menu_section = MenuSection.find(params[:id])
    menu_section.destroy if menu_section
    respond_to do |format|
      format.html { redirect_to menu_section.restaurant }
      format.js
    end
  end

end
