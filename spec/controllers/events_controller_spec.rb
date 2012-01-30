require 'spec_helper'

describe EventsController do

  describe "GET 'show_user'" do
    it "should be successful" do
      get :show_user, :id => 1
      response.should be_success
    end
  end

end
