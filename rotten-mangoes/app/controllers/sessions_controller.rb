class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back #{user.firstname}!"
      redirect_to movies_path
    else
      flash[:danger] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Adios!"
    redirect_to movies_path
  end
end
