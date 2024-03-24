class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :country, null: false
      t.string :city, null: false
      t.string :county
      t.string :state
      t.string :postal_code
      t.string :street
      t.string :building_name
      t.string :floor_number
      t.string :room_number
      t.string :nearest_landmark
      t.text :extra_info
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.string :slug
      t.integer :status, default: 0
      t.references :locatable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
