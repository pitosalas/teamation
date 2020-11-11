class ChangeDataTypeForSchedule < ActiveRecord::Migration[6.0]
  def change
    remove_column :preferences, :schedule
    add_column :preferences, :schedule, :string
  end
end
