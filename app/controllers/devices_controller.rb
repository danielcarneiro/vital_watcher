class DevicesController < ApplicationController
	before_filter :authenticate, :only => [:new, :create, :destroy]
	before_filter :authorized_user, :only => :destroy

	def new
		@device = Device.new
  		@title = "Add a new device"
	end

	def create
		@device = current_user.devices.build(params[:device])
		if @device.save
			flash[:success] = "Device created"
			redirect_to user_path(current_user)
		else
			render 'new'
		end
	end

	def destroy
		@device.destroy
		redirect_back_or user_path(current_user)
	end

	private

		def authorized_user
			@device	= current_user.devices.find_by_id(params[:id])
			redirect_to user_path(current_user) if @device.nil?
		end
end