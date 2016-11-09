require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :logo }

  it { should have_and_belong_to_many :uploads }

  describe '#upload_count' do
    before(:each) do
      @project = create(:project)
    end

    it 'has the actual upload count' do
      expect(@project.upload_count).to eql(@project.uploads.count)
    end

    it 'updates accordingly' do
      expect(@project.upload_count).to eql(@project.uploads.count)

      @project.uploads << create(:upload)
      expect(@project.upload_count).to eql(@project.uploads.count)
    end
  end
end
