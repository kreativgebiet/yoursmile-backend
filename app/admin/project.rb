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

  form do |f|
    f.inputs do
      f.semantic_errors *f.object.errors.keys

      f.input :logo
      f.input :name
      f.input :description
      f.input :image
      f.input :country_code
      f.input :sector_code

      f.actions
    end
  end
end
