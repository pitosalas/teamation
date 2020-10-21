class ChangePreferenceTimeZoneType < ActiveRecord::Migration[6.0]
  def change
    change_column :preferences, :time_zone, :string, default: "UTC"
  end
end
