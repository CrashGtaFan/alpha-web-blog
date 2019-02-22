class ArticlesController < ApplicationController
  before_action :article_resource, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 10).order(id: :desc)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
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
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def article_resource
    @article = Article.find(params[:id])
  end
  
  def require_same_user
    if current_user != @article.user && current_user.writer?
      flash[:danger] = 'You can only edit of delete only own your articles'
      redirect_to root_path
    end
  end
end
