require 'rails_helper'

RSpec.describe Upload, type: :model do
  it { should validate_presence_of :image }
  it { should validate_presence_of :user }
  it { should belong_to :user }
  it { should have_many :upload_comments }
  it { should accept_nested_attributes_for :user }

  describe '#amount_to_charge' do
    it 'is 1000 for one project with amount 1000' do
      @support = create(:upload_support, amount: 1000)
      @upload = create(:upload, supports: [@support])

      expect(@upload.amount_to_charge).to eq(1000)
    end

    it 'should sum all support amounts' do
      @supports = create_list(:upload_support, 3)
      @upload = create(:upload, supports: @supports)
      expect(@upload.amount_to_charge).to eq(3150)
    end
  end
end
