class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end
  end
end
