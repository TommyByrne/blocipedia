class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @wikis = @user.wikis
    @collaborators = @user.collaborators
    @wiki = Wiki.all
  end

  def toggle_role
    @user = current_user

    if @user.admin? == 'admin'
      flash[:error] = "User is an admin. No update."
    elsif @user.standard?
      @user.update_attribute(:role, 'premium')
      flash[:notice] = "User switced from from standard to premium."
    else
      @user.update_attribute(:role, 'standard')
      flash[:notice] = "User switced from premium to standard."
    end
    redirect_to users_upgrade_path
  end

  def go_premium
    @user = current_user
    @user.update_attribute(:role, 'premium')
  end

  def go_standard
    @user = current_user
    @user.update_attribute(:role, 'standard')
    flash[:notice] = "User switched from premium to standard."
    redirect_to edit_user_registration_path
  end
end