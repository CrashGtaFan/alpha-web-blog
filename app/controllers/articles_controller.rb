class ArticlesController < ApplicationController
  before_action :article_resource, only: %i[show edit update destroy]

  def index
    @articles = Article.order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article #{@article.title} was successuful created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Article #{@article.title} was successuful updated!"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article #{@article.title} was successuful destroyed!"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def article_resource
    @article = Article.find(params[:id])
  end
end
