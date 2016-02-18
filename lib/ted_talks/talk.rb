class TedTalks::Talk

	attr_accessor :title, :author, :date, :rating, :url

	def self.top_talks(url)

		talks = []

	  (0..4).each do |i|
	  	talk_object = self.scrape_talks_ted(i,url)

	  	if talk_object.title == nil
	  		break
	  	else
			talks << self.scrape_talks_ted(i, url)
		end
	  end

		talks
	end

	def self.scrape_talks_ted(i, url='http://www.ted.com/talks')

		doc = Nokogiri::HTML(open(url))
		#binding.pry
		talk = self.new
		talk.title = doc.search(".media__message").search("h4.h9").search("a")[i].text.strip! if doc.search(".media__message").search("h4.h9").search("a")[i] != nil
		talk.author = doc.search(".media__message").search("h4.h12")[i].text if doc.search(".media__message").search("h4.h12")[i] != nil
		talk.date = doc.search(".media__message").search(".meta").search(".meta__item").search("span.meta__val")[i].text.strip! if doc.search(".media__message").search(".meta").search(".meta__item").search("span.meta__val")[i] != nil
		talk.rating = doc.search(".media__message").search(".meta").search(".meta__row").search(".meta__val")[i].text.strip! if doc.search(".media__message").search(".meta").search(".meta__row").search(".meta__val")[i] != nil
		#talk.category.strip!
		talk.url = "http://www.ted.com" + doc.search("h4.h9").css("a")[i].attr("href") if doc.search("h4.h9").css("a")[i] != nil
	 	talk
	end
end