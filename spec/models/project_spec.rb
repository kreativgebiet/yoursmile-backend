require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :logo }

  it { should have_and_belong_to_many :uploads }

  describe '#upload_count' do
    it 'should have the actual upload count' do
      project = create(:project)
      expect(project.upload_count).to equal(project.uploads.count)
    end
  end
end
