class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @action = 'new'

    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, success: "Welcome aboard, #{@user.firstname}!"
    end
  end

  def show
    @movie = Movie.new
    @movie_action = 'new'
    @user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id])
    @action = 'edit'
  
    if @user.update_attributes(user_params)
      redirect_to user_path, success: "Profile edited!"
    end
  end

  protected
    def user_params
      params.require(:user).permit(
        :email, :firstname, :lastname,
        :password, :password_confirmation
      )
    end
end
