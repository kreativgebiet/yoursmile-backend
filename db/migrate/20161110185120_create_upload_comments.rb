class CreateUploadComments < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_comments do |t|
      t.integer :author_id
      t.integer :upload_id
      t.string :text

      t.timestamps
    end
  end
end
