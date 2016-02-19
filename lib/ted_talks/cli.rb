#Our CLI Controller
class TedTalks::CLI

	def call
		puts "Today's TED ideas worth spreading. Check out the top 10 talks today!"
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
		puts "Here are 7 different categories. Enter the number or name of the category you'd like to see more videos about."
		puts " "
		puts "1. Top Talks"
		puts "2. Technology"
		puts "3. Entertainment"
		puts "4. Design"
		puts "5. Business"
		puts "6. Science"
		puts "7. Global Issues"
    	puts " "
    	puts "Or enter search if you would like to search for videos."

		input = gets.strip.downcase

		categories_hash = {
		 "top talks" => "1", 
		 "technology" => "2", 
		 "entertainment" => "3", 
		 "design" => "4",
		 "business" => "5",
		 "science" => "6",
		 "global issues" => "7"
		}

		if input.to_i == 1
			list_talks
		elsif input.to_i > 1 && input.to_i <= 7
			url_value = categories_hash.key(input)
			url = "http://www.ted.com/talks?topics%5B%5D=#{url_value}&sort=newest"
		elsif categories_hash.key?(input)
			url_value = input
			url = "http://www.ted.com/talks?topics%5B%5D=#{url_value}&sort=newest"
		elsif input == "search"
			puts "Enter your search term."
			url_value = gets.strip.downcase
			url = "http://www.ted.com/talks?q=#{url_value}&sort=newest"
		elsif input == "exit"
			exit
		end

		list_talks(url)
	end

	def menu
		input = nil

		while input != "exit"
			puts " "
			puts "Enter the number of the talk you'd like to learn more about."
			puts "Enter talks to see the talks again."
			puts "Enter categories to see the categories again."
			puts "Enter exit to end the program."

			input = gets.strip.downcase

			if input.to_i > 0
				the_talk = @talks[input.to_i - 1]
				@talk_info = TedTalks::Talk.talk_info(the_talk.url)
				display_talk_info(@talk_info)
			elsif input == "talks"
				list_talks
			elsif input == "categories"
				list_categories
			elsif input != "exit"
				puts "Invalid entry. Type a number, talks, categories, or exit."
			end
		end
	end

	def display_talk_info(talk_info)

		puts " "
		puts "------------------TED------------------------"
		puts talk_info.author
		puts talk_info.title
		puts " "
		puts "-----------------Details---------------------"
		puts talk_info.description
		puts " "
		puts "Time #{talk_info.time} " 
		puts talk_info.date
		puts " "
		puts "Total views: #{talk_info.views} "
		puts "----------------------------------------------"
	end

	def goodbye
		puts "See you tomorrow for more talks."
	end
end