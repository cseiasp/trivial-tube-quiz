require_relative '../config/environment'


class Game < ActiveRecord::Base  
    
    def self.welcome
        puts "\nTRIVIAL TUBE QUIZ\n\n"
        system('clear')
        Train.print_train_welcome
        prompt = TTY::Prompt.new
        @user_input = prompt.ask("Welcome to the Trivial Tube Quiz. What is your name?")
        puts "\nHello #{@user_input} \n \n"
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
        system('clear')
        puts "Checking the leaderboard...\n"
        print_leaderboard
        user_choice
    end

    def self.exit
        Train.moving_train(15, "Goodbye - please mind the gap on your way out!", 0.15)
    end

    def self.display_question
        system('clear')
        print_train
        @question = Question.ask_random_question
    end

    def self.play
        display_question
        if @question == true
            @score += 1
            p "Correct! Your score is now #{@score}"
            sleep(1)
            play
        elsif @question == false || @question == "Timer Expired"
            message = "The train has left the station because your answer was WRONG!"
            Train.moving_train(15, message, 0.08)
            puts "\n --- Your final score is #{@score} --- \n \n"
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
        
        puts "___________   _______________________________________^__        ".yellow 
        puts " ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     ".green
        puts "|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    ".cyan
        puts "|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   Don't miss the stop!".blue
        puts "           |||                    |___|___| |  |__|         )   You are currently on stop #{@score}.".magenta
        puts "___________|||______________________________|______________/    ".red
        puts "           |||                                        /-------- ".yellow
        puts "-----------'''---------------------------------------'          ".yellow
        puts " \n                                             \n"
    end
    
end