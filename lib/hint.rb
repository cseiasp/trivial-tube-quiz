require_relative '../config/environment'

class Hint

    def self.give_hint(hints)
        if (hints == nil)
            puts "Dont be silly, you aren´t getting a hint for this question!"
        else 
            puts "Potential options: "
            hints.each {|hint| print "#{hint} "}     
        end

        puts "\n"

    end

    def self.generate_line_hint(answer)
        hint_array = generate_string_array(answer)
        possible_hints = Line.all.map{|line|line.name}
        add_possible_hints(hint_array, possible_hints)
        hint_array.shuffle
    end

    def self.generate_numerical_hint(answer)
        hint_array = generate_int_array(answer)
        possible_hints = [*1..6]
        add_possible_hints(hint_array, possible_hints)
        convert_hint_string_to_int(hint_array)
        hint_array.shuffle
    end

    def self.generate_begin_with_hint(answer)
        hint_array = generate_string_array(answer)
        possible_hints = Station.station_names_by_letter(answer[0][0])
        add_possible_hints(hint_array, possible_hints)
        hint_array = first_three_letters(hint_array)
        hint_array.shuffle
    end

    def self.first_three_letters(hint_array)
        modified_array = hint_array.map{|hint| hint[0...3] + ".."}
        modified_array
    end

    def self.generate_string_array(answer)
        hint_array = []
        hint_array << answer[0]
    end

    def self.generate_int_array(answer)
        hint_array = []
        hint_array << answer[0].to_i
    end

    def self.add_possible_hints(hint_array, possible_hints)
        hint_array << (possible_hints - hint_array).sample
        hint_array << (possible_hints - hint_array).sample
    end

    def self.convert_hint_string_to_int(hint_array)
        hint_array.map{|hint| hint.to_s}
    end

end