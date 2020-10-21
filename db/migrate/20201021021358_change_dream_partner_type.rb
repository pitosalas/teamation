class ChangeDreamPartnerType < ActiveRecord::Migration[6.0]
  def change
    remove_column :preferences, :dream_partner
    add_column :preferences, :dream_partner, :integer
  end
end
