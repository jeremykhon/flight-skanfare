class AddDiscountToPreference < ActiveRecord::Migration[5.2]
  def change
    add_column :preferences, :discount, :integer
  end
end
