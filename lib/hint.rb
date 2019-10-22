require_relative '../config/environment'

class Hint

    def self.give_hint(hint)
        if (hint == nil)
            puts "Sorry, no hints for this question!"
        else 
            puts "Potential options: "
            
        end
        user_input = STDIN.gets.chomp
    end


    def self.generate_numerical_hint(answer)
        hint_array = answer

        if answer[0] == 1
            hint_array << answer[0]+1
            hint_array << answer[0]+2
        else 
            hint_array << answer[0]+1
            hint_array << answer[0]-1
        end
    end
end