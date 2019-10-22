require_relative '../config/environment'

TubeData.seed_data_zones("db/station_zones.csv")

Line.create(colour: "Black", name: "Northern")
Line.create(colour: "Brown", name: "Bakerloo")
Line.create(colour: "Yellow", name: "Circle")
Line.create(colour: "Pink", name: "Hammersmith & City")
Line.create(colour: "Grey", name: "Jubilee")
Line.create(colour: "Light Blue", name: "Victoria")
Line.create(colour: "Red", name: "Central")
Line.create(colour: "Green", name: "District")
Line.create(colour: "Purple", name: "Metropolitan")
Line.create(colour: "Dark Blue", name: "Piccadilly")
Line.create(colour: "Turquoise", name: "Waterloo & City")

TubeData.seed_data_lines("db/station_lines.csv")

User.create(username: "Li")
User.create(username: "Caroline")

TubeData.delete_data_where_no_stops