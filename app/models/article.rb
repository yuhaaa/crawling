class Article < ApplicationRecord
  def self.news_title(params)
    agent = Mechanize.new
    (Article.news_counter(params).to_a).each do |index|
      page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=#{params}&start=#{index}&field=1"
      list = page.search("a._sp_each_title").map(&:text)
      list.each do |title|

        # Article.create(title: title)

        if title.include?('해커')
          Article.create(title: title, category: 'hacker')
        elsif title.include?('하니')
          Article.create(title: title, category: 'honey')
        elsif title.include?('누구나')
          Article.create(title: title, category: 'nugu')
        elsif title.include?('홍진호')
          Article.create(title: title, category: 'kong')
        elsif title.include?('지니어스')
          Article.create(title: title, category: 'genius')
        else
          Article.create(title: title, category: 'others')
        end
      end
    end
  end

  def self.news_counter(params)
    agent = Mechanize.new
    page = agent.get"https://search.naver.com/search.naver?sm=tab_hty.top&where=news&ie=utf8&query=#{params}&field=1"
    number = page.search("div.title_desc span").map(&:text).to_s
    result =  number.split('/').last.delete('건').delete(',').to_i
    return (0..(result/10)).to_a.map { |x| 10*x + 1 }
  end


  def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
