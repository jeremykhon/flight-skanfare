class AddUniqueFlightToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :unique_flight, :string, default: ""
  end
end
