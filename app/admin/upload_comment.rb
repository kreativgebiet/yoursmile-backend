ActiveAdmin.register Upload::Comment do
  belongs_to :upload, parent_class: Upload

  permit_params :author_id, :upload_id, :text
end
