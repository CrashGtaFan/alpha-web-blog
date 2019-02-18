class UsersController < ApplicationController
  before_action :user_resource, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update]
  before_action :require_admin, only: %i[destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 10).order(id: :desc)
  end

  def new
    @user = User.new
  end
  
  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 10)
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Alpha web blog, #{@user.username}"
      redirect_to user_path(@user)
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

  def destroy
    @user.destroy
    flash[:danger] = "User #{@user.username} and his articles was destroyed!"
    redirect_to users_path
  end
  
  private
  
  def user_resource
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
  
  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can edit only own your profile'
      redirect_to root_path
    end
  end
end
