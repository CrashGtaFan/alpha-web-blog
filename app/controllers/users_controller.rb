class UsersController < ApplicationController
  before_action :user_resource, only: %i[show edit update]
  before_action :require_user, except: %i[new index show]
  before_action :require_same_user, only: %i[edit update]
  
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
  
  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can edit only own your profile'
      redirect_to root_path
    end
  end
end
