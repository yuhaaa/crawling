class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse
  end

  def news_title
    Article.news_title(params[:query].to_s)
    redirect_to root_path
  end
end
