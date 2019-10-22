require_relative '../config/environment'


class Game < ActiveRecord::Base  
    
    def self.welcome
        system('clear')
        print_train
        puts "\nWELCOME TO TRIVIAL TUBE QUIZ\n\n"
        prompt = TTY::Prompt.new
        @user_input = prompt.ask("What is your name?")
        puts "Hello #{@user_input}"
        @user = User.find_or_create_by(username: @user_input)
        user_choice
    end
    
    def self.user_choice
    prompt = TTY::Prompt.new
    choices = ["Play","View Leaderboard", "Change User", "Exit"]
    @user_choice = prompt.select("What would you like to do?", choices)
        if @user_choice == "Play"
                    @score = 0
                    play
                elsif @user_choice == "View Leaderboard" 
                    view_leaderboard
                elsif @user_choice == "Change User" 
                    welcome
                elsif @user_choice == "Exit" 
                    exit
        end
    end

    def self.view_leaderboard
        puts "Checking the leaderboard...\n"
        print_leaderboard
        user_choice
    end

    def self.exit
        puts "Thank you for playing, #{@user_input}. Play again soon!"
        print_train
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
        puts "___________   _______________________________________^__ ".red
        puts " ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\ ".red
        puts "|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\ ".red
        puts "|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\ ".red
        puts "           |||                    |___|___| |  |__|         ) ".red
        puts "___________|||______________________________|______________/ ".red
        puts "           |||                                        /-------- ".red
        puts "-----------'''---------------------------------------' ".red
    
    end
   

end