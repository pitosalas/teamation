class RemoveProjectFromPreferenceWeights < ActiveRecord::Migration[6.0]
  def change
    remove_column :preference_weights, :project, :integer
  end
end
