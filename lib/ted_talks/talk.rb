class TedTalks::Talk

	attr_accessor :title, :author, :date, :rating, :url

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

		(0..9).each do |i|

			talk = self.new
			talk.title = doc.search(".media__message").search("h4.h9").search("a")[i].text.strip! if doc.search(".media__message").search("h4.h9").search("a")[i] != nil
			talk.author = doc.search(".media__message").search("h4.h12")[i].text if doc.search(".media__message").search("h4.h12")[i] != nil
			talk.date = doc.search(".media__message").search(".meta").search(".meta__item").search("span.meta__val")[i].text.strip! if doc.search(".media__message").search(".meta").search(".meta__item").search("span.meta__val")[i] != nil
			talk.rating = doc.search(".media__message").search(".meta").search(".meta__row").search(".meta__val")[i].text.strip! if doc.search(".media__message").search(".meta").search(".meta__row").search(".meta__val")[i] != nil
			talk.url = "http://www.ted.com" + doc.search("h4.h9").css("a")[i].attr("href") if doc.search("h4.h9").css("a")[i] != nil
		 	talk

	 		talk_array << talk if talk.title != nil
	 	end

	 	talk_array
	end
end