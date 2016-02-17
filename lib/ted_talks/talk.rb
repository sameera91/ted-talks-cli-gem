class TedTalks::Talk

	attr_accessor :title, :author, :date, :rating, :url

	def self.top_talks

		talks = []

	  (0..6).each do |i|
		talks << self.scrape_talks_ted(i)
	  end

		talks
	end

	def self.scrape_talks_ted(i)
		doc = Nokogiri::HTML(open('http://www.ted.com/talks'))
		#binding.pry
		talk = self.new
		talk.title = doc.search(".media__message").search("h4.h9").search("a")[i].text.strip!
		talk.author = doc.search(".media__message").search("h4.h12")[i].text
		talk.date = doc.search(".media__message").search(".meta").search(".meta__item").search("span.meta__val")[i].text.strip!
		talk.rating = doc.search(".media__message").search(".meta").search(".meta__row").search(".meta__val")[i].text.strip!
		#talk.category.strip!
		talk.url = "http://www.ted.com" + doc.search("h4.h9").css("a")[i].attr("href")
	 	talk
	end
end