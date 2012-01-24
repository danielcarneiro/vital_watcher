class UsersController < ApplicationController

	def index
		@title = "All users"
    @users = User.all
	end

  def show
  	@user = User.find(params[:id])
    @devices = @user.devices
  	@title = @user.display_name
  end

  def new
    @user = User.new
  	@title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Vital Watcher"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end

end
