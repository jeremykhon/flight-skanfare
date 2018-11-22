class AddDiscountToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :discount_abs, :integer, default: 0
    add_column :deals, :discount_perc, :integer, default: 0
  end
end
