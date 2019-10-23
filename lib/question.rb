require_relative '../config/environment'
require 'pry'

class Question 

    def self.rules
        puts " - - - - - - - - - - - - - - - RULES OF THE GAME - - - - - - - - - - - - - - - "
        puts "The game is simple, answer as many questions as you can correctly, but beware: \n\n"
        puts "YOU ONLY HAVE 15 SECONDS TO ANSWER THIS QUESTION, SO HURRY! ".yellow
        puts "Pro tip - you can ask for a hint if you need one... \n\n"
        puts " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
        puts "\nHERE IS YOUR QUESTION"
    end

    def self.compare_answers (question, answer, hints=nil)
        user_input = Thread.new do
            rules
            puts question
            Thread.current[:value] = STDIN.gets.chomp
        end

        timer = Thread.new {sleep 15; user_input.kill; puts}
        user_input.join
        
        if user_input[:value]
            user_input= Hint.give_hint(hints) if user_input[:value] == "h" || user_input[:value] == "hint"

            answer, user_input = downcase_comparison(user_input[:value], answer)
            answer.include?(user_input) ? win = true : win = false
            timer.kill
            return win
        else
            return "Timer Expired"
        end
    end

    def self.downcase_comparison(user_input, answer)
        user_input = user_input.downcase
        answer = answer.map{|answer| answer.downcase}
        return answer, user_input
    end

    def self.which_line_is_station_on
        station = Station.all.sample

        question = "Which line is #{station.name} on?"
        answer = Line.lines_names_of_station(station.id)
        hints = Hint.generate_line_hint(answer)

        compare_answers(question, answer, hints)
    end

    def self.which_line_has_more_stations
        line_1 = Line.all.sample
        line_2 = (Line.all - [line_1]).sample

        question = "Which of these two lines has the most stops? #{line_1.name} or #{line_2.name}"
        answer = [Line.most_stops(line_1, line_2)]
        
        compare_answers(question, answer)
    end

    def self.how_many_lines_go_through
        station = Station.all.sample

        question = "How many lines go through #{station.name}?"
        answer = [station.lines.size.to_s]
        hints = Hint.generate_numerical_hint(answer)
 
        compare_answers(question, answer, hints)
    end

    def self.station_beginning_with_x
        station = Station.all.sample
        letter = station.name[0]

        question = "Name a Station beginning with #{letter}"
        answer = Station.station_names_by_letter(letter)
        hints = Hint.generate_begin_with_hint(answer)

        compare_answers(question, answer, hints)
    end

    def self.station_beginning_with_x_on_line_y
        station = Station.all.sample
        letter = station.name[0]
        
        answer_array = Station.stations_on_line_by_letter(letter)
        answer = answer_array[0]
        line = answer_array[1]
        question = "Name a Station beginning with #{letter} on the #{line} line."
        hints = Hint.generate_begin_with_hint(answer)

        compare_answers(question, answer, hints)
    end

    def self.which_zone_is_x_station_in
        station = Station.all.sample

        question = "Which zone is #{station.name} in?"
        answer = Station.zone_of_station(station)
        hints = Hint.generate_numerical_hint(answer)

        compare_answers(question, answer, hints)
    end

    def self.what_colour_is_this_line?
        line = Line.all.sample

        question = "What colour is the #{line.name} line? "
        answer = [line.colour]
        hints = ["Black,", "Brown,", "Yellow,", "Pink,", "Grey,", "Light Blue,", "Dark Blue,", "Red,", "Green,", "Purple or", "Turquoise"]
        
        compare_answers(question, answer, hints)   
    end

    def self.ask_random_question
         questions.sample.call
    end

    def self.questions
        array = [
            method(:which_line_is_station_on),
            method(:which_line_has_more_stations),
            method(:how_many_lines_go_through),
            method(:station_beginning_with_x),
            method(:station_beginning_with_x_on_line_y),
            method(:which_zone_is_x_station_in),
            method(:what_colour_is_this_line?)
            ]
    end

end