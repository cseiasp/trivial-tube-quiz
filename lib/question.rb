require_relative '../config/environment'

class Question 

    def self.which_line_is_station_on
        station = Station.all.sample

        puts "Which line is #{station.name} on?"

        user_input = gets.chomp

        answer = Line.lines_names_of_station(station.id)

        answer.include?(user_input) ? win = true : win = false

        puts "#{win}"
    end

    def self.which_line_has_more_stations
        line_1 = Line.all.sample
        line_2 = (Line.all - [line_1]).sample

        puts "Which of these two lines has the most stops? #{line_1.name} or #{line_2.name}"

        user_input = gets.chomp

        answer = Line.most_stops(line_1, line_2)
        answer == user_input ? win = true : win = false

        puts "#{win}"
    end

    def self.how_many_lines_go_through
        station = Station.all.sample

        puts "How many lines go through #{station.name}?"

        user_input = gets.chomp

        answer = station.lines.size.to_s
        answer == user_input ? win = true : win = false

        puts "#{win}"
    end




end