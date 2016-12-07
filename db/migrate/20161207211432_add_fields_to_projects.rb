class AddFieldsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :image, :string
    add_column :projects, :country_code, :string
    add_column :projects, :sector_code, :string
  end
end
