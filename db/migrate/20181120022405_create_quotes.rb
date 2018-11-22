class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.date :depart_date
      t.string :origin
      t.string :destination
      t.integer :min_price
      t.boolean :direct

      t.timestamps
    end
  end
end
