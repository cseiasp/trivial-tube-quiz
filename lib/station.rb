class Station < ActiveRecord::Base
    has_many :stops
    has_many :lines, through: :stops

    # Methods for randomly generating a first letter from all stations

    # Create a unique array containing starting letters of all stations
    def self.create_starting_stations_array
        station_name_arrays = Station.all.map{|station| station.name[0]}.uniq
    end
    
    # Create a unique array containing the starting letters of the stations on a line
    def self.create_starting_stations_by_line_array(line_id)
        station_names_on_line(line_id).map{|station| station[0]}.uniq
    end

    # Create an array of station names starting with a particular letter
    def self.stations_by_letter(letter)
        #return array of instances stations begining with letter
        Station.all.select{|station| station.name[0] == letter}
    end
  

    def self.station_names_by_letter(letter)
        #return array of station names begining with letter
        stations_by_letter(letter).map{|station| station.name}
    end



    # Methods for creating an array of stations on a particular line, by id

    # Create an array of station instances on a line by id
    def self.all_stations_by_line_id(line_id)
        Stop.all.select {|stop| stop.line_id == line_id}.flatten
    end

    # Create an array of station ids on a particular line
    def self.station_id_array_by_line(line_id)
        all_stations_by_line_id(line_id).map {|stop| stop.station_id}
    end

    #Create an array of station names on a particular line
    def self.station_names_on_line(line_id)
        station_id_array_by_line(line_id).map {|station_id| Station.all.find_by(id:station_id).name}
    end


    # Creates and array of station begining with with a particular letter on a particular line
    def self.stations_on_line_by_letter(letter, line_id)
       station_names_on_line(line_id) & station_names_by_letter(letter)
    end

end