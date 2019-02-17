class PagesController < ApplicationController
  def about
  end

  def welcome
    redirect_to articles_path if logged_in?
    @last_articles = Article.last(5)
  end
end
