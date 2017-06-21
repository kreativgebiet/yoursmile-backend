FactoryGirl.define do
  factory :upload_support, class: 'Upload::Support' do
    amount 1050
    project { create(:project) }
  end
end
