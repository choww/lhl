class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  private
    def require_admin
      unless current_user.admin?
        flash[:danger] = "You don't have access to this page"
        redirect_to root_path
      end
    end
end
