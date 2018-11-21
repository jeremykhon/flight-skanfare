class AddDiscountToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :discount_abs, :integer
    add_column :deals, :discount_perc, :integer
  end
end
