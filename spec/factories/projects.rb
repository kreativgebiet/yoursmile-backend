FactoryGirl.define do
  factory :project do
    name { Faker::Company.name }
    description Faker::Lorem.paragraph(2)

    logo do
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, 'spec', 'fixtures', 'project-logo.png')
      )
    end
  end
end
