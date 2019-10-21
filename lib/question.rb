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
end