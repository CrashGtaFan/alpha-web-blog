class UsersController < ApplicationController
  before_action :user_resource, only: [:show, :edit, :update]
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Alpha web blog, #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile was succesifully updated!'
      redirect_to articles_path
    else
      render 'edit'
    end
  end
  
  private
  
  def user_resource
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
