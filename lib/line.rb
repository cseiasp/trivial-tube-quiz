class Line < ActiveRecord::Base
    has_many :stops
    has_many :stations, through: :stops


    def self.most_stops(line_1, line_2)
        
    end

end