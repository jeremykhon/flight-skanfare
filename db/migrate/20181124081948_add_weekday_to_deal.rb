class AddWeekdayToDeal < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :weekday, :integer
  end
end
