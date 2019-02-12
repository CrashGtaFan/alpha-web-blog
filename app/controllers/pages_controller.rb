class PagesController < ApplicationController
  def about
  end

  def welcome
    @last_articles = Article.last(5)
  end
end
