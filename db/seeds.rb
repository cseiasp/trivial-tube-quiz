require_relative '../config/environment'

TubeData.seed_data_zones("db/station_zone.csv")

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

Stop.create(station_id: 1 , line_id: 1)
Stop.create(station_id: 2 , line_id: 2)
Stop.create(station_id: 3 , line_id: 7)
Stop.create(station_id: 4 , line_id: 3)
Stop.create(station_id: 5 , line_id: 7)
Stop.create(station_id: 1 , line_id: 4)
Stop.create(station_id: 2 , line_id: 3)
Stop.create(station_id: 2 , line_id: 1)
Stop.create(station_id: 3 , line_id: 3)
Stop.create(station_id: 3 , line_id: 8)

User.create(username: "Li")
User.create(username: "Caroline")