class AddCityToDeal < ActiveRecord::Migration[5.2]
  def change
    add_reference :deals, :city, foreign_key: true
  end
end
