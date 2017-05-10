class Article < ApplicationRecord
  def self.news_title
    agent = Mechanize.new
    [1,11,21,31].each do |index|
      page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=멋쟁이사자처럼&start=#{index}"
      list = page.search("a._sp_each_title").map(&:text)
      list.each do |title|
        puts title
      end
    end
  end
end
