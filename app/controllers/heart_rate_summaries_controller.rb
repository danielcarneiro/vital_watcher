class HeartRateSummariesController < ApplicationController

	respond_to :json

	def show_user
		@user = User.find(params[:id])
		if @user.nil?
			flash[:error] = "Unknown user"
			redirect_to users_path
		else
			@title = "User Monitor"

			period = params[:period] || "Daily"

			@heart_rate_summaries = 
				HeartRateSummary.find_user_heart_rates_by_period(@user.id, period)

			respond_with @heart_rate_summaries
			# respond_to do |format|
			# 	format.html
			# 	format.json { render :json => @heart_rate_summaries }
			# end			
		end
  end
end
