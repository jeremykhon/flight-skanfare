class AddDestinationToPreference < ActiveRecord::Migration[5.2]
  def change
    add_column :preferences, :destination, :string
  end
end

