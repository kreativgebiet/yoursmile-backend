ActiveAdmin.register User do
  permit_params :name, :nickname, :email

  index do
    selectable_column
    column :provider, as: :text
    column :uid, as: :text
    column :name

    column :email

    actions
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
