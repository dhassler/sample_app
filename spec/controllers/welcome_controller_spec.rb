require 'spec_helper'

describe WelcomeController do
  render_views
  
  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
    
    it "should say welcome" do
      get :index
      response.should have_selector("h1", :content => "Welcome")
    end
    
    it "should have a search box" do
      get :index
      response.should have_selector("input[name='query'][type='text']")
    end
  end
  
  describe "GET 'search'" do
    it "should be successful" do
      post :search, :query => "12345"
      response.should be_success
      response.should render_template("results")
    end
  end
end
