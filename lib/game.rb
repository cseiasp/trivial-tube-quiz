require_relative '../config/environment'


class Game < ActiveRecord::Base
#methods for questions
#array of methods 
#method called play_game
#method for game over
#methods for adding / keeping track of score
#method for saving, viewing scores


#create view map


#this is not everything by the way
def self.welcome
    puts "What is your name?"
    @user_input = gets.chomp
    puts "Hello #{@user_input}"
    @user = User.find_or_create_by(username: @user_input)

end

def self.user_choice
    puts "Play game or view Leaderboard?"
    @user_choice = gets.chomp
    if @user_choice == "game"
        @score = 0
        play
    end
end


def self.play
    question = Question.which_line_has_more_stations
    if question
        @score += 1
        p "Correct! Your score is #{@score}"
        play
    else
        puts "WRONG! Your score is #{@score}"
        Score.create(user_id: @user.id, score: @score)
        user_choice
    end
end
    
end