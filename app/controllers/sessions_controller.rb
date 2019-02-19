class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      login user
      flash[:success] = "Welcome!"
      redirect_back_or user
    else
      flash.now[:danger] = "Invalid username/password combination"
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
