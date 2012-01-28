require 'spec_helper'

describe ActivitiesController do

  describe "GET 'show_user'" do
    it "should be successful" do
      get 'show_user'
      response.should be_success
    end
  end

end
