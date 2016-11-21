ActiveAdmin.register Upload do
  permit_params :image, :description, :user_id project_ids: []
end
