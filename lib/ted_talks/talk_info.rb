class TedTalks::Info

    attr_accessor :title, :author, :description, :time, :date, :views

    def initialize(title=nil, author=nil, description=nil, time=nil, date=nil, views=nil)
        @title = title
        @author = author
        @description = description
        @time = time
        @date = date
        @@views = views
    end

    def self.talk_info(url='http://www.ted.com/talks')
	doc = Nokogiri::HTML(open(url))

	talk_info = self.new
	talk_info.author = doc.search("div.player-hero__speaker").search("span.player-hero__speaker__content").text
	talk_info.title = doc.search("div.player-hero__title").search("span.player-hero__title__content").text
	talk_info.description = doc.search(".talk-subsection").search(".talk-top__details").search("p.talk-description").text
	talk_info.time = doc.search("div.player-hero__meta").search("span")[0].text
	talk_info.date = doc.search("div.player-hero__meta").search("span")[1].text
	talk_info.views = doc.search("div.talk-sharing__count").search("span.talk-sharing__value").text.strip! 
	talk_info
    end
end