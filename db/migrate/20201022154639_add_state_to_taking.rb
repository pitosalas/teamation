class AddStateToTaking < ActiveRecord::Migration[6.0]
  def change
    add_column :takings, :state, :string, default: "created"
  end
end
