require 'spec_helper'

describe PagesController do

  describe "GET 'home'" do
    describe "non authenticated users" do
      it "should redirect to signin" do
        get 'home'
        response.should redirect_to(signin_path)
      end
    end 

    describe "authenticated users" do
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
      end

      it "should redirect to current user page" do
        get 'home'
        response.should redirect_to(@user)
      end
    end
  end 

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

end
