ActiveAdmin.register Upload do
  permit_params :image, :description, :user_id, project_ids: []

  form do |f|
    f.inputs do
      f.input :image
      f.input :description
      f.input :user, collection: User.all.map { |user| [user, user.id] }
      f.input :projects

      f.actions
    end
  end
end
