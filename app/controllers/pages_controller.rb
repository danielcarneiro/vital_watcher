class PagesController < ApplicationController
  before_filter :authenticate, :only => :configurations
  before_filter :admin_user,  :only => :configurations
  
  def home
  	@title = "Home"
  	if signed_in?
  		redirect_to current_user
  	else
  		redirect_to signin_path
  	end
  end

  def about
  	@title = "About"
  end

  def not_enough_privileges
  	@title = "Not enough privileges"
  end

  def configurations
    @title = "Configurations"
    @heart_rate_types = HeartRateType.all
    @activity_types = ActivityType.all
  end

end
