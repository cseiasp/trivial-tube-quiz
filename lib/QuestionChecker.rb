class QuestionChecker


    

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