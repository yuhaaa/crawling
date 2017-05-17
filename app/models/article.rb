class Article < ApplicationRecord
  def self.news_title(params)
    agent = Mechanize.new
    (Article.news_counter(params).to_a).each do |index|
      page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=#{params}&start=#{index}"
      list = page.search("a._sp_each_title").map(&:text)
      list.each do |title|
        Article.create(title: title)
      end
    end
  end
  
  def self.news_counter(params)
    agent = Mechanize.new
    page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=#{params}"
    number = page.search("div.title_desc span").map(&:text).to_s
    result =  number.split('/').last.delete('건').delete(',').to_i
    return (0..result/10).to_a.map { |x| 10*x + 1}
  end
  
end