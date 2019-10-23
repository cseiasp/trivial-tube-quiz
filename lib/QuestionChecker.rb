require_relative '../config/environment'

class QuestionChecker

    attr_accessor :question, :answer, :hints, :user_input, :possible_typo

    def initialize(question, answer, hints=nil)
        @question = question
        @answer = answer
        @hints = hints
    end

    def compare_answers 
        output_question
        process_user_input
        downcase_comparison
        answer_correct? ? true : process_wrong_answer
    end

    def process_wrong_answer
        @possible_typo = spell_checker
        if typo_is_wrong_answer?
            return false 
        else 
            let_user_retype
        end
    end

    def process_user_input
        @user_input = STDIN.gets.chomp
        self.user_input = Hint.give_hint(self.hints) if self.user_input == "h" || self.user_input == "hint"
    end

    def output_question
        puts self.question
    end

    def answer_correct?
        self.answer.include?(self.user_input)
    end

    def typo_is_wrong_answer?
        (self.answer - self.possible_typo) == self.answer
    end

    def let_user_retype
        puts "Did you mean: #{self.possible_typo.join("").red}? Please type your answer again!"
        compare_answers
    end    

    def downcase_comparison
        self.user_input = self.user_input.downcase
        self.answer = self.answer.map{|answer| answer.downcase}
    end

    def spell_checker
        spell_checker = DidYouMean::SpellChecker.new(
            dictionary: [
                station_names = Station.all.map{|station| station.name.downcase}, 
                line_names = Line.all.map{|line| line.name.downcase}
            ].flatten
        )
        spell_checker.correct(self.user_input)
    end 
end