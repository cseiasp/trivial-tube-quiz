class QuestionChecker

    def self.compare_answers (question, answer, hints=nil)
        puts question

        user_input = STDIN.gets.chomp
        user_input = Hint.give_hint(hints) if user_input == "h" || user_input == "hint"

        user_input, answer = downcase_comparison(user_input, answer)

        if answer.include?(user_input)
            return true
        else
            possible_typo = spell_checker(user_input)

            if typo_is_wrong_answer?(answer, possible_typo)
                return false 
            else 
                let_user_retype(question, answer, possible_typo, hints=nil)   
            end
        end
    end

    def self.typo_is_wrong_answer?(answer, possible_typo)
        (answer - possible_typo) == answer
    end

    def self.let_user_retype(question, answer, possible_typo, hints=nil)
        puts "Did you mean: #{possible_typo.join("")}? Please type your answer again!"
        compare_answers(question, answer, hints=nil) 
    end    

    def self.downcase_comparison(user_input, answer)
        user_input = user_input.downcase
        answer = answer.map{|answer| answer.downcase}
        return user_input, answer
    end

    def self.spell_checker(user_input)
        spell_checker = DidYouMean::SpellChecker.new(
            dictionary: [
                station_names = Station.all.map{|station| station.name.downcase}, 
                line_names = Line.all.map{|line| line.name.downcase}
            ].flatten
            )
        spell_checker.correct(user_input)
    end 

end