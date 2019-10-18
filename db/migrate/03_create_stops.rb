class CreateStops < ActiveRecord::Migration[5.2]

    def change
        create_table :stops do |t|
            t.integer :station_id
            t.integer :line_id
        end
    end
end