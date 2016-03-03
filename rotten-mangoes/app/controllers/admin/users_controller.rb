class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.page(params[:page]).per(2)
  end

  def create_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin?)
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    UserMailer.delete_email(@user).deliver_now
    @user.destroy
    redirect_to admin_users_path
  end

  private
    def require_admin
      unless current_user.admin?
        flash[:danger] = "You don't have access to this page"
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(
        :firstname, :lastname, :email, :admin?, :password
      )
    end
end
