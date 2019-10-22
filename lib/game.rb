require_relative '../config/environment'


class Game < ActiveRecord::Base  
    
    def self.welcome
        puts "\nTRIVIAL TUBE QUIZ\n\n"
        system('clear')
        print_train_welcome
        prompt = TTY::Prompt.new
        @user_input = prompt.ask("Welcome to the Trivial Tube Quiz. What is your name?")
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
        system('clear')
        puts "Checking the leaderboard...\n"
        print_leaderboard
        user_choice
    end

    def self.exit
        system('clear')
        puts "Thank you for playing, #{@user_input}. Play again soon!"
        print_train_exit
    end

    def self.play
        system('clear')
        print_train
        question = Question.ask_random_question
        if question
            @score += 1
            p "Correct! Your score is now #{@score}"

            play
        else
            puts "\n --- WRONG! Your final score is #{@score} --- \n \n"
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

    def self.random_colour
        [String.red, String.green, String.black, String.blue, String.magenta].sample
    end

    
    
    def self.print_train_exit
        
        puts "___________   _______________________________________^__        ".yellow 
        puts " ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     ".green
        puts "|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    ".cyan
        puts "|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   ".blue
        puts "           |||                    |___|___| |  |__|         )   MIND THE GAP WHILST YOU EXIT!".magenta
        puts "___________|||______________________________|______________/    ".red
        puts "           |||                                        /-------- ".yellow
        puts "-----------'''---------------------------------------'          ".yellow
        puts " \n                                             \n"
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
    
    def self.print_train_welcome
        puts "________   _______________________________________^__ ".yellow
        puts "_   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\      __      __       .__ ".green       
        puts " | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    /  \\    /  \\ ____ |  |    ____  ____   _____   ____ ".cyan
        puts "_| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   \\   \\/\\/   // __ \\|  |  _/ ___\\/  _ \\ /     \\_/ __ \\".blue
        puts "        |||                    |___|___| |  |__|         )   \\        / \\ ___/|  |_ \\  \\__(  <_> )  Y Y  \\  ___/".magenta
        puts "________|||______________________________|______________/     \\__/\\  /   \\___  >____/\\___  >____/|__|_|  /\\___  >".red
        puts "        |||                                        /-----------    \\/        \\/          \\/            \\/     \\/  ".yellow
        puts "--------'''---------------------------------------' ".yellow
    end
   

end