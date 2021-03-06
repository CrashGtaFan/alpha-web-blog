class CategoriesController < ApplicationController
  before_action :category_resource, only: [:show, :edit, :update]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.order(:id).paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 10).order(id: :desc)
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category #{@category.name} was successifally created!"
      redirect_to categories_path(@category)
    else
      render :new
    end
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Category #{@category.name} was successifally updated!"
      redirect_to categories_path(@category)
    else
      render :edit
    end
  end

  private
  
  def category_resource
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (!logged_in? && !current_user.admin?)
      flash[:danger] = 'Only administrator can perform that action'
      redirect_to categories_path
    end
  end
end
