ActiveAdmin.register Upload do
  permit_params :image, :description, :user_id, project_ids: []

  index do
    selectable_column

    column :image
    column :description
    column :created_at

    actions do |upload|
      link_to 'Comments', admin_upload_upload_comments_path(upload)
    end
  end

  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys

      f.input :image
      f.input :description
      f.input :user, collection: User.all.map { |user| [user, user.id] }
      f.input :projects

      f.actions
    end
  end
end
