class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
    @wikis = @user.wikis
  end
end