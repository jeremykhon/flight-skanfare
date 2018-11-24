class RemoveWdayDurationFromDeal < ActiveRecord::Migration[5.2]
  def change
    remove_column :deals, :wday_duration, :string
  end
end
