ActiveAdmin.register User do
  permit_params :name, :nickname, :email

  index do
    selectable_column
    column :id
    column :uid, as: :text
    column :name
    column :nickname
    column :email

    actions do |user|
      link_to "Uploads (#{user.uploads.count})", admin_user_uploads_path(user)
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :nickname
      f.input :email

      f.actions
    end
  end
end
