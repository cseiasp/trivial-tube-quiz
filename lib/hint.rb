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

    def self.generate_numerical_hint(answer)
        hint_array = generate_hint_array(answer)
        add_possible_hint(hint_array)
        add_possible_hint(hint_array)
        convert_hint_string_to_int(hint_array)
        hint_array.shuffle
    end

    def self.generate_hint_array(answer)
        hint_array = []
        hint_array << answer[0].to_i
    end

    def self.add_possible_hint(hint_array)
        possible_hints = [*1..6]
        hint_array << (possible_hints - hint_array).sample
    end

    def self.convert_hint_string_to_int(hint_array)
        hint_array.map{|hint| hint.to_s}
    end

end