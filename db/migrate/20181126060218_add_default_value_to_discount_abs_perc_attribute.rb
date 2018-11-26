class AddDefaultValueToDiscountAbsPercAttribute < ActiveRecord::Migration[5.2]
  def change
    change_column :deals, :discount_perc, :integer, default: 0
    change_column :deals, :discount_abs, :integer, default: 0
  end
end
