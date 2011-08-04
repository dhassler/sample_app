class WelcomeController < ApplicationController
  def index
  end
  
  def search
    @query_string = params[:query]
    @restaurants = Restaurant.near(@query_string, 100)
    if @restaurants.empty?
      @restaurants = Restaurant.all[0..4]
    end
    flash[:notice] = "No results found, returning 5 other results"
    render :results
  end

end
