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
    choices = ["Rules of The Game", "Play","View Leaderboard", "Change User", "Exit"]
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
                else
                    rules
        end
    end

    def self.view_leaderboard
        system('clear')
        puts "Checking the leaderboard...\n"
        print_leaderboard
        user_choice
    end

    def self.exit
        Train.moving_train(15, "Goodbye - please mind the gap on your way out!", 0.1)
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
        else 
            if @question == "Timer Expired"
                message = "Oh no! The train has left the station because you were too slow!"
            else 
                message = "Oh no! The train has left the station because your answer was WRONG! \nThe correct answer(s): #{@question.join(". ")}."
            end
            Train.moving_train(15, message, 0.08)
            puts "\n --- Your final score is #{@score} --- \n \n"
            Score.create(user_id: @user.id, score: @score)
            user_choice
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

    def self.rules
        system('clear')

        puts "  __  .__                            .__                   ".yellow
        puts "_/  |_|  |__   ____     _______ __ __|  |   ____   ______".green
        puts "\\   __\\  |  \\_/ __   \\  \\_  __ \\  |  \\  | _/ __ \\ /  ___/".cyan
        puts " |  | |   Y  \\  ___/     |  | \\/  |  /  |_\\  ___/ \\___ \\ ".blue
        puts " |__| |___|  /\___  >     |__|  |____/|____/\\___  >____  >".magenta
        puts "           \\/     \\/                           \\/     \\/ ".red

        puts "\n
        Do you think you know London pretty well? Fancy yourself a true Londoner?
        Well why don't you play are game and show off your knowledge! \n \n
                                         INSTRUCTIONS
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        The game is simple, answer as many questions as you can correctly, but beware:"
        puts "        YOU ONLY HAVE 15 SECONDS TO ANSWER EACH QUESTION, SO HURRY!".red
        puts "        (Pro tip - you can ask for a hint if you need one...)
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n \n \n"

       user_choice
    end

    
end