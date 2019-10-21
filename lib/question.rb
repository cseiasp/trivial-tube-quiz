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




end