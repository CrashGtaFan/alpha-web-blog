class CategoriesController < ApplicationController
  before_action :category_resource, only: [:show, :edit, :update]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
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
  
  private
  
  def category_resource
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
end
