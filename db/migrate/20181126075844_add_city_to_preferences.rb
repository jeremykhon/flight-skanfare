class AddCityToPreferences < ActiveRecord::Migration[5.2]
  def change
    add_reference :preferences, :city, foreign_key: true
  end
end
