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
    puts "Play game [play], view Leaderboard [lb], change User [change] or Exit [e]?"
    @user_choice = gets.chomp.downcase
    if @user_choice == "play"
        @score = 0
        play
    elsif @user_choice == "leaderboard" || @user_choice == "lb"
        puts "Checking the leaderboard...\n"
        print_leaderboard
        user_choice
    elsif @user_choice == "change" || @user_choice == "change user"
        welcome
    elsif @user_choice == "e" || @user_choice == "exit"
        puts "Thank you for playing, #{@user_input}. Play again soon!"
        print_train
    else
        puts "Invalid command."
        user_choice
    end
end


def self.play
    question = Question.ask_random_question
    if question
        @score += 1
        p "Correct! Your score is now #{@score}"
        play
    else
        puts "WRONG! Your final score is #{@score}"
        Score.create(user_id: @user.id, score: @score)
        return user_choice
    end
end

def self.print_leaderboard
    scores = Score.all.sort_by{|score| -score.score.to_i}[0...10]
    puts "\n"
    printf("%-20s %-20s %-20s\n\n", "Position", "Username", "Score")

    scores.each_with_index do | score, index |
        username = User.find_by(id: score.user_id).username
        printf("%-20s %-20s %-20s\n", index + 1, username, score.score)
    end
    puts "\n"
end

def self.print_train
    puts "___________   _______________________________________^__ "
    puts " ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\ "
    puts "|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\ "
    puts "|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\ "
    puts "           |||                    |___|___| |  |__|         ) "
    puts "___________|||______________________________|______________/ "
    puts "           |||                                        /-------- "
    puts "-----------'''---------------------------------------' "

end
    
end