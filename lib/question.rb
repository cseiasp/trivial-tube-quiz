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

    def self.station_beginning_with_x
        station = Station.all.sample
        letter = station.name[0]

        puts "Name a Station beginning with #{letter}"

        user_input = gets.chomp

        answer = Station.station_names_by_letter(letter)

        answer.include?(user_input) ? win = true : win = false

        puts "#{win}"

    end

    def self.station_beginning_with_x_on_line_y
        station = Station.all.sample
        letter = station.name[0]

        answer = Station.stations_on_line_by_letter(letter)

        line = answer[1]

        puts "Name a Station beginning with #{letter} on the #{line} line."

        user_input = gets.chomp

        answer.include?(user_input) ? win = true : win = false

        puts "#{win}"

    end

    def self.which_zone_is_x_station_in

        station = Station.all.sample

        answer = Station.zone_of_station(station)

        puts "Which zone is #{station.name} in?"

        user_input = gets.chomp.to_i

        answer.include?(user_input) ? win = true : win = false

        puts "#{win}"

    end




end