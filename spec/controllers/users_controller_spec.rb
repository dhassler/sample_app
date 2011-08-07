require 'spec_helper'

describe UsersController do  
  describe "only admin user can create accounts" do
    it "should fail when not logged in" do
      get :new
      response.should redirect_to login_path
    end
    
    it "should fail when logged in as non-admin" do
      user = User.create!(:email => "foo", :password => "pass", :password_confirmation => "pass")
      test_sign_in(user)
      session[:user_id].should == user.id
      get :new
      response.should redirect_to login_path
    end
    
    it "should work when logged in as admin" do
      user = User.new(:email => "foo", :password => "pass", :password_confirmation => "pass")
      user.admin = true
      user.save
      test_sign_in(user)
      get :new
      response.should be_success
    end
  end
end
