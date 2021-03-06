class HeartRateSummariesController < ApplicationController

	respond_to :html, :json

	def show_user
		@user = User.find(params[:id])
		if @user.nil?
			flash[:error] = "Unknown user"
			redirect_to users_path
		else
			@title = "User Monitor"

			period = params[:period] || "Day"

			@heart_rate_summaries = 
				HeartRateSummary.find_user_heart_rates_by_period(@user.id, period)

			@heart_rate_interval = HeartRateSummary.interval?(period)

			respond_to do |format|
				format.html
				format.json { respond_with @heart_rate_summaries }
			end
		end
  end
end
