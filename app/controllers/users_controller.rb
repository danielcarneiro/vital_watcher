class UsersController < ApplicationController

  respond_to :html, :json

	def index
		@title = "All users"
    @users = User.all
	end

  def show
  	@user = User.find_by_id(params[:id])

    unless @user.nil?
      @devices = @user.devices
      @title = @user.display_name  
    end

    respond_to do |format|
      format.html
      format.json { respond_with @user }
    end
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
      @id = 1

      respond_to do |format|
        format.html { redirect_to @user }        
        format.json { respond_with @id}
      end
    else
      @title = "Sign up"
      @genders = Gender.all
      @id = -1
      
      respond_to do |format|
        format.html { render 'new' }
        format.json { respond_with @id }
      end
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
