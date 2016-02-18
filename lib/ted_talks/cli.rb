#Our CLI Controller
class TedTalks::CLI

	def call
		puts "Today's TED ideas worth spreading."
		puts " "
		list_categories
		menu
		goodbye
	end

	def list_talks(url='http://www.ted.com/talks')
		@talks = TedTalks::Talk.top_talks(url)
		@talks.each.with_index do |talk, i|
			puts "#{i+1}. #{talk.title} - #{talk.author} - Posted #{talk.date} - Rated #{talk.rating}"
			puts " "
		end
	end

	def list_categories
		puts "Here are 7 different categories. Enter the number of the category you'd like to see more videos about or enter search to search for videos."
		puts "1. Top Talks"
		puts "2. Technology"
		puts "3. Entertainment"
		puts "4. Design"
		puts "5. Business"
		puts "6. Science"
		puts "7. Global Issues"

		input = gets.strip.downcase

		if input == "top talks" || input == "1"
			list_talks
		elsif input == "technology" || input == "2"
			url = "http://www.ted.com/talks?topics%5B%5D=technology&sort=newest"
			list_talks(url)
		elsif input == "entertainment" || input == "3"
			url = 'http://www.ted.com/talks?topics%5B%5D=entertainment&sort=newest'
			list_talks(url)
		elsif input == "design" || input == "4"
			url = "http://www.ted.com/talks?topics%5B%5D=design&sort=newest"
			list_talks(url)
		elsif input == "business" || input == "5"
			url = "http://www.ted.com/talks?topics%5B%5D=business&sort=newest"
			list_talks(url)
		elsif input == "science" || input == "6"
			url = "http://www.ted.com/talks?topics%5B%5D=science&sort=newest"
			list_talks(url)
		elsif input == "global issues" || input == "7"
			url = "http://www.ted.com/talks?topics%5B%5D=global+issues&sort=newest"
			list_talks(url)
		elsif input == "search"
			puts "Enter your search term."
			search = gets.strip.downcase
			url = "http://www.ted.com/talks?q=#{search}&sort=newest"
			list_talks(url)
		end

	end

	def menu
		input = nil
		while input != "exit"
			puts " "
			puts "Enter the number of the talk you'd like to learn more about, type list to see the articles again, or type categories to see the categories." 
			puts "Type exit to quit the program."
			input = gets.strip.downcase

			if input.to_i > 0
				the_talk = @talks[input.to_i - 1]

				doc = Nokogiri::HTML(open(the_talk.url))
				#binding.pry
				#video content description from the second page
				display_talk_info(doc)
			elsif input == "list"
				list_talks
			elsif input == "categories"
				list_categories
			elsif input != "exit"
				puts "Invalid number. Type list, categories, or exit."
			end
		end
	end

	def display_talk_info(doc)

		puts "----------------------------------------------"
		puts doc.search("div.player-hero__speaker").search("span.player-hero__speaker__content").text
		puts doc.search("div.player-hero__title").search("span.player-hero__title__content").text
		puts doc.search(".talk-subsection").search(".talk-top__details").search("p.talk-description").text
		puts " "
		puts "Time " + doc.search("div.player-hero__meta").search("span")[0].text
		puts doc.search("div.player-hero__meta").search("span")[1].text
		puts " "
		puts doc.search("div.talk-sharing__count").search("span.talk-sharing__value").text.strip! + " total views"
		puts "-----------------------------------------------"
	end

	def goodbye
		puts "See you tomorrow for more talks."
	end
end