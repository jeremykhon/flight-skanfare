class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.date :depart_date
      t.date :return_date
      t.string :origin
      t.string :destination
      t.integer :price

      t.timestamps
    end
  end
end
