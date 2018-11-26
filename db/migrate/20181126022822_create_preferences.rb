class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.integer :weekday
      t.integer :duration

      t.timestamps
    end
  end
end
