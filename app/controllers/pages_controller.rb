class PagesController < ApplicationController
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

end
