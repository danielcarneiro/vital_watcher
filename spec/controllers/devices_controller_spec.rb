require 'spec_helper'

describe DevicesController do
  render_views

  describe "access control" do

		it "should deny access to 'new'" do
	    post :new
	    response.should redirect_to(signin_path)
	  end

	  it "should deny access to 'create'" do
	    post :create
	    response.should redirect_to(signin_path)
	  end

	  it "should deny access to 'destroy'" do
	    delete :destroy, :id => 1
	    response.should redirect_to(signin_path)
	  end
	end

  describe "POST 'create'" do
  	before(:each) do
  		@user = test_sign_in(Factory(:user))
  	end

  	describe "failure" do
  		before(:each) do
  			@attr = { :mac_address => "" }
  		end

  		it "should not create a device" do
  			lambda do
  				post :create, :device => @attr
  			end.should_not change(Device, :count)
  		end

  		it "should render the new device page" do
  			post :create, :device => @attr
  			response.should render_template('devices/new')
  		end
  	end

  	describe "success" do
  		before(:each) do
  			@attr = { :mac_address => "12:34:56:78:90:AB" }
  		end

  		it "should create a device" do
  			lambda do
  				post :create, :device => @attr
  			end.should change(Device, :count).by(1)
  		end

  		it "should redirect to the user page" do
  			post :create, :device => @attr
        response.should redirect_to(user_path(@user))
  		end

  	end
  end

  describe "DELETE 'destroy'" do
    describe "for an unauthorized user" do
      before(:each) do
        @user = Factory(:user)
        @wrong_user = Factory(:user)
        test_sign_in(@wrong_user)
        @device = Factory(:device, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @device
        response.should redirect_to(user_path(@wrong_user))
      end
    end

    describe "for an authorized user" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @device = Factory(:device, :user => @user)
      end

      it "should destroy the device" do
        lambda do
          delete :destroy, :id => @device
        end.should change(Device, :count).by(-1)
      end
    end
  end
end