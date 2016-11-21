ActiveAdmin.register User do
  index do
    selectable_column
    column :provider
    column :uid
    column :name
    column :nickname
    column :email
    actions
  end
end
