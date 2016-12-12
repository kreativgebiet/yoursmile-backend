require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :logo }
  it { should validate_presence_of :image }
  it { should validate_presence_of :country_code }
  it { should validate_presence_of :sector_code }

  it { should have_and_belong_to_many :uploads }

  describe '#progress' do
    it 'returns right progress'
    it 'returns formatted progress if parameter is true'
  end

  describe '#country_code_valid?' do
    before(:each) do
      @project = build(:project)
    end

    it 'returns true with valid country code' do
      @project.country_code = 'DE' # Germany
      expect(@project.country_code_valid?).to eql(true)
    end

    it 'return false with invalid country code' do
      @project.country_code = 'AA' # Invalid
      expect(@project.country_code_valid?).to eql(false)
    end
  end

  describe '#upload_count' do
    before(:each) do
      @project = create(:project)
    end

    it 'has the actual upload count' do
      expect(@project.upload_count).to eql(@project.uploads.count)
    end

    it 'updates accordingly' do
      expect(@project.upload_count).to eql(@project.uploads.count)

      @project.uploads << build(:upload)
      expect(@project.upload_count).to eql(@project.uploads.count)
    end
  end
end
