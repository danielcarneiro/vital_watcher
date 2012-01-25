require 'spec_helper'

describe "LayoutLinks" do
	describe "non authenticated users" do
	  it "" do
	    get '/'
	    #response.should have_selector('title', :content => "Home")
	    response.should redirect_to(signin_path)
	  end
	end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end
end
