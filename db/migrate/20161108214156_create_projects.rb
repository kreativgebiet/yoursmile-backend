# encoding: utf-8
class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :logo
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
