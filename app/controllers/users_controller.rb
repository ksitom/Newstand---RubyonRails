class UsersController < ApplicationController
  before_action :require_logout
  skip_before_action :require_logout, only: [:show, :edit, :update]
  before_action :require_user
  skip_before_action :require_user, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def show
    @user = current_user
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to '/profile'
    else
      render '/profile/edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/signup'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password)
  end
end
