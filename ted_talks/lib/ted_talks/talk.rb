class TedTalks::Talk

   attr_accessor :title, :author, :date, :rating, :url, :description, :time, :date, :views

   def initialize(title=nil, author=nil, date=nil, rating=nil, url=nil)
      @title = title
      @author = author
      @date = date
      @rating = rating
      @@url = url
   end

   def self.top_talks(url='http://www.ted.com/talks')

	talk_array = []

	doc = Nokogiri::HTML(open(url))

	title = doc.css(".media__message").css("h4.h9").css("a")
	author = doc.css(".media__message").css("h4.h12")
	date = doc.css(".media__message").css(".meta").css(".meta__item").css("span.meta__val")
	rating = doc.css(".media__message").css(".meta").css(".meta__row").css(".meta__val")
	url = doc.css("h4.h9").css("a")

	(0..9).each do |i|

		talk = self.new
		talk.title = title[i].text.strip! if title[i] != nil
		talk.author = author[i].text if author[i] != nil
		talk.date = date[i].text.strip! if date[i] != nil
		talk.rating = rating[i].text.strip! if rating[i] != nil
		talk.url = "http://www.ted.com" + url[i].attr("href") if url[i] != nil

		talk_array << talk if talk.title != nil
	end

	talk_array
	
   end
end