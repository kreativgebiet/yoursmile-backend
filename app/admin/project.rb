ActiveAdmin.register Project do
  permit_params :name, :logo, :image, :description, :country_code, :sector_code

  index do
    selectable_column
    column :name
    column :logo
    column :image
    column :country_code
    column :sector_code

    actions
  end
end
