class CreateUploadSupports < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_supports do |t|
      t.integer :amount
      t.integer :upload_id
      t.integer :project_id

      t.timestamps
    end
  end
end
