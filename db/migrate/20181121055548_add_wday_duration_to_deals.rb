class AddWdayDurationToDeals < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :wday_duration, :string
  end
end
