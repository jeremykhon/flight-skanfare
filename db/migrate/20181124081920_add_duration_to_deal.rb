class AddDurationToDeal < ActiveRecord::Migration[5.2]
  def change
    add_column :deals, :duration, :integer
  end
end
