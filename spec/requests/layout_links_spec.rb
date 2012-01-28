require 'spec_helper'

describe "LayoutLinks" do
	describe "non authenticated users" do
	  it "" do
	    get '/'
	    response.should redirect_to(signin_path)
	  end
	end

  it "should have an About page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  describe "user menu links" do
  	it "should have a user monitor heart rate page" do
  		get '/heart_rate_summaries/1/show_user'
  		response.should have_selector('title', :content => "User Monitor")
  	end

  	# it "should have a user activity page" do
  	# 	get '/activities/1/show_user'
  	# 	response.should have_selector('title', :content => "Activity")
  	# end
  end
end
