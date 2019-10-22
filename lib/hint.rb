require_relative '../config/environment'

class Hint

    def self.give_hint(hints)
        if (hints == nil)
            puts "Sorry, no hints for this question!"
        else 
            puts "Potential options: "
            hints.each {|hint| print "#{hint} "}     
        end

        puts "\n"
        user_input = STDIN.gets.chomp
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

    def self.generate_string_array(answer)
        hint_array = []
        hint_array << answer.sample
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