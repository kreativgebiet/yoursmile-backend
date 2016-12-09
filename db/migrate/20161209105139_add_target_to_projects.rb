class AddTargetToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :target, :integer, default: 100
  end
end
