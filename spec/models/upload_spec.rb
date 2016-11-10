require 'rails_helper'

RSpec.describe Upload, type: :model do
  it { should validate_presence_of :image }
  it { should validate_presence_of :user }
  it { should validate_length_of :projects }

  it { should have_and_belong_to_many :projects }
  it { should belong_to :user }
  it { should have_many :comments }

  it { should accept_nested_attributes_for :user }
end
