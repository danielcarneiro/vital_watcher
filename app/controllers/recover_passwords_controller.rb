class RecoverPasswordsController < ApplicationController
  def new
  	@title = "Recover Password"
  	@recover_password = RecoverPassword.new
  end

  def create
  	@recover_password = RecoverPassword.new(params[:recover_password])
  	if @recover_password.save
      @recover_password.send_password_reset(edit_recover_password_url @recover_password.token)
	  	flash[:success] = "Mail sended to #{@recover_password.email}"
	  	redirect_to signin_path
  	else
  		@title = "Recover Password"
  		render :new
  	end
  end

  def edit
    @title = "Recover Password"
    @recover_password = RecoverPassword.find_by_token!(params[:id])
  end

  def update
    @recover_password = RecoverPassword.find_by_token!(params[:id])
    if @recover_password.created_at < 2.hours.ago 
      flash[:error] = "Password reset has expired."
      redirect_to new_recover_password_path 
    else
      if @recover_password.update_attributes(params[:recover_password])
        @recover_password.user.update_password(@recover_password.password)
        sign_in @recover_password.user
        flash[:success] = "Password changed!"
        redirect_to @recover_password.user
      else
        @title = "Recover Password"
        render 'edit'
      end
    end
  end
end
