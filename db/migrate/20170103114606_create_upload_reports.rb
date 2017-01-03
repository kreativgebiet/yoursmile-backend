class CreateUploadReports < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_reports do |t|
      t.integer :upload_id
      t.integer :user_id

      t.timestamps
    end
  end
end
