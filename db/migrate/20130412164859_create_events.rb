class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps
      t.string :name
      t.string :group_name
      t.integer :time
      t.integer :attendees 
      t.string :event_url
      t.text :description
      t.string :city
      t.string :state
      t.string :zip_code

      t.timestamps
    end
  end
end
