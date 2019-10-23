require_relative '../config/environment'

class Train 

    # Welcome banner
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

    # ---- logic for moving train ----

    # defines the length of the gap the train will move by
    def self.mind_the_gap(number)
        gap = ""

        number.times do
        gap += "   " 
        end

        gap
    end

    # moves the train by the gap amount a number of times
    def self.moving_train(number, message, sleep)
        
        i = 1

        number.times do
            gap = mind_the_gap(i)
            system('clear')
            
            puts "#{gap}___________   _______________________________________^__        ".yellow 
            puts "#{gap} ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     ".green
            puts "#{gap}|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    ".cyan
            puts "#{gap}|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   ".blue
            puts "#{gap}           |||                    |___|___| |  |__|         )   ".magenta
            puts "#{gap}___________|||______________________________|______________/    ".red
            puts "#{gap}           |||                                        /-------- ".yellow
            puts "#{gap}-----------'''---------------------------------------'          ".yellow
            puts "#{message}\n".yellow
            
            i += 1
            sleep(sleep)
        end
        train_dissappears(number, message, sleep)
    end

    # makes the end characters dissapear so it looks like the train is moving out of sight
    def self.train_dissappears(number, message, sleep)

        gap2 = mind_the_gap(15)
        i = 1

        number.times do
            gap = mind_the_gap(15 + i)
            system('clear')
            
            puts "#{gap}___________   _______________________________________^__        "[0...-5*i].yellow 
            puts "#{gap} ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     "[0...-5*i].green
            puts "#{gap}|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    "[0...-5*i].cyan
            puts "#{gap}|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   "[0...-5*i].blue
            puts "#{gap}           |||                    |___|___| |  |__|         )   "[0...-5*i].magenta
            puts "#{gap}___________|||______________________________|______________/    "[0...-5*i].red
            puts "#{gap}           |||                                        /-------- "[0...-5*i].yellow
            puts "#{gap}-----------'''---------------------------------------'          "[0...-5*i].yellow
            puts "#{message}\n".yellow

            i += 1
            sleep(sleep)
        end
    end
    # ---- end of logic for moving train ----


    

end