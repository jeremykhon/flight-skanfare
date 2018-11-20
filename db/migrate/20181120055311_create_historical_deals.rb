class CreateHistoricalDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :historical_deals do |t|
      t.references :deal, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
