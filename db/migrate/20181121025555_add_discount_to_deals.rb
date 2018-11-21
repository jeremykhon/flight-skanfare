class AddDiscountToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :discount, :integer
  end
end
