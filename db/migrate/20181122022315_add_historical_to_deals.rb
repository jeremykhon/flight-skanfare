class AddHistoricalToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :historical, :jsonb, default: '[]'
  end
end
