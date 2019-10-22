require 'csv'

#"lib/station_lines.csv"

class TubeData

    #parse CSV data to have it in a table format in order to map through it
    def self.import_data(path)
        station_line = CSV.parse(File.read(path), headers: true)
    end

    # map through imported table to create new Station.create commands to be seeded into table
    # want to return a list of Station.creates, then use rake db:seed
    def self.seed_data_zones(path)
        import_data(path).map {|sl| Station.create(name: sl["name"].strip, zone: sl["zone"])}
    end
    
    def self.seed_data_lines(path)
        
        import_data(path).map do |sl| 
            station_id = Station.find_by(name: sl["Name"].strip).id
            line_id = Line.find_by( name:sl["Line"]).id
            Stop.create(station_id: station_id, line_id: line_id)
        end

    end

    def self.data_with_no_stops
        Station.all.select {|s| s.lines == []}
    end

    def self.delete_data_where_no_stops
        data_with_no_stops.each {|s| s.delete}
    end

    
end

        
