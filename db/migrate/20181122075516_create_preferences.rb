class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.string :destination
      t.integer :discount_perc
      t.integer :duration
      t.boolean :monday, default: true
      t.boolean :tuesday, default: true
      t.boolean :wednesday, default: true
      t.boolean :thursday, default: true
      t.boolean :friday, default: true
      t.boolean :saturday, default: true
      t.boolean :sunday, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
