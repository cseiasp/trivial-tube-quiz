require_relative '../config/environment'

class Train 

    def self.mind_the_gap(number)
        gap = ""

        number.times do
        gap += "   " 
        end

        gap
    end

    def self.moving_train(number)
        
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
        #puts "#{gap}You have #{(2*number) - i} seconds left - hurry!         \n".yellow
        puts "#{gap}Goodbye - Mind The Gap! \n".yellow
        
        i += 1
        sleep(0.25)
        end
        train_dissappears(number)
    end

    def self.train_dissappears(number)
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
        #puts "#{gap2}You have #{number - i } seconds left - hurry!         \n".yellow
        puts "#{gap}Goodbye - Mind The Gap! \n".yellow
        i += 1
        sleep(0.25)
        end
    end

end