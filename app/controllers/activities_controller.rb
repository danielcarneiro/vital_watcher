class ActivitiesController < ApplicationController
  def show_user
  	@user = User.find(params[:id])
  	if @user.nil?
  		flash[:error] = "Unknown user"
  		redirect_to users_path
  	else
  		@title = "User Activity"
  		@activities = @user.activities
  	end
  end
end
