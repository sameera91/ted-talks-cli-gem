#Our CLI Controller
class TedTalks::CLI

	def call
		puts "Today's TED ideas worth spreading."
		puts " "
		list_talks
		menu
		goodbye
	end

	def list_talks
		@talks = TedTalks::Talk.top_talks
		@talks.each.with_index do |talk, i|
			puts "#{i+1}. #{talk.title} - #{talk.author} - Posted #{talk.date} - Rated #{talk.rating}"
			puts " "
		end
	end

	def menu
		input = nil
		while input != "exit"
			puts " "
			puts "Enter the number of the talk you'd like to learn more about or type list to see the articles again. Type exit to quit the program."
			input = gets.strip.downcase

			if input.to_i > 0
				the_talk = @talks[input.to_i - 1]

				doc = Nokogiri::HTML(open(the_talk.url))
				#binding.pry
				#video content description from the second page
				display_talk_info(doc)
			elsif input == "list"
				list_talks
			else
				puts "Invalid number. Type list or exit."
			end
		end
	end

	def display_talk_info(doc)

		puts doc.search("div.player-hero__speaker").search("span.player-hero__speaker__content").text
		puts doc.search("div.player-hero__title").search("span.player-hero__title__content").text
		puts doc.search(".talk-subsection").search(".talk-top__details").search("p.talk-description").text
		puts " "
		puts "Time " + doc.search("div.player-hero__meta").search("span")[0].text
		puts doc.search("div.player-hero__meta").search("span")[1].text
		puts " "
		puts doc.search("div.talk-sharing__count").search("span.talk-sharing__value").text.strip! + " total views"
	end

	def goodbye
		puts "See you tomorrow for more talks."
	end
end