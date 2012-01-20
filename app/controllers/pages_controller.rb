class PagesController < ApplicationController
  def home
  	@title = "Home"
  end

  def about
  	@title = "About"
  end

  def not_enough_privileges
  	@title = "Not enough privileges"
  end

end
