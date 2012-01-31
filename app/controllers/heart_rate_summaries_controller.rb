class HeartRateSummariesController < ApplicationController
  def show_user
  	@user = User.find(params[:id])
	if @user.nil?
		flash[:error] = "Unknown user"
		redirect_to users_path
	else
		@title = "User Monitor"

		period = params[:period] || "Daily"

		@heart_rate_summaries = 
			HeartRateSummary.find_user_heart_rates_by_period(
				@user.id, period)
	end
  end
end
