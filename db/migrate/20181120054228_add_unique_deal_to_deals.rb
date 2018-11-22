class AddUniqueDealToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :unique_deal, :string, default: ""
  end
end
