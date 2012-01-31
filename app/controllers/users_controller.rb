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
    @genders = Gender.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Vital Watcher"
      redirect_to @user
    else
      @title = "Sign up"
      @genders = Gender.all
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
    @genders = Gender.all
  end

  def recover_password
    @title = "Recover Password"
  end

  def recover_password_submit
    redirect_to about_path
  end

end
