class Line < ActiveRecord::Base
    has_many :stops
    has_many :stations, through: :stops


    def self.most_stops(line_1, line_2)
        
    end

    # Create an array of station instances on a line by id
    def self.all_lines_by_station_id(station_id)
        Stop.all.select {|stop| stop.station_id == station_id}
    end

    def self.line_id_array_by_station(station_id)
        all_lines_by_station_id(station_id).map {|stop| stop.line_id}
    end

    def self.lines_names_of_station(station_id)
        line_id_array_by_station(station_id).map {|line_id| Line.find_by(id:line_id).name}
    end

end