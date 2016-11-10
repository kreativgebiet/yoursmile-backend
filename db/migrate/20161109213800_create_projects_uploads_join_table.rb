# encoding: utf-8
class CreateProjectsUploadsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :projects, :uploads
  end
end
