require 'spec_helper'

describe RecoverPasswordsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get :create
      response.should be_success
    end
  end

  describe "GET 'recover_password'" do
    before(:each) do
      @recover_password = Factory(:recover_password)
    end

    it "should be successful" do
      get :edit, :id => @recover_password.token
      response.should be_success
    end
  end

end
