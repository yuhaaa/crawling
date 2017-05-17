class ArticlesController < ApplicationController
  def index
    # @articles = Article.all
    @articles = Article.search(params[:search])
    @hacker_sum = Article.where("title like ?", "%해커%")
    @hacker_sum_by_category = Article.where("category = ?", "hacker")
    @genius_sum_by_category = Article.where("category = ?", "genius")
  end

  def news_title
    Article.news_title(params[:query].to_s)
    redirect_to root_path
  end
end
