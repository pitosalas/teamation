class AddProjectWeightInProfPreference < ActiveRecord::Migration[6.0]
  def change
    add_column :preference_weights, :project_voting, :integer
  end
end
