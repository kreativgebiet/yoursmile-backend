ActiveAdmin.register Upload::Comment do
  belongs_to :upload

  permit_params :author_id, :upload_id, :text
end
