class ArticlesController < ApplicationController
  before_action :article_resource, only: %i[show edit update destroy]

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article #{@article.title} was successuful created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article #{@article.title} was successuful updated!"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def article_resource
    @article = Article.find(params[:id])
  end
end
