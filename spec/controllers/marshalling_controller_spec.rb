require 'spec_helper'

describe MarshallingController do

  describe "GET 'get_data'" do
    it "should be successful" do
      get 'get_data'
      response.should be_success
    end
  end

end
