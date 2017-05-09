require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  describe '#like' do
    it 'likes an upload by another user' do
      upload = create(:upload)
      expect { @user.like(upload) }.to change { @user.likes.count }.by(1)
    end

    it 'likes an upload by yourself' do
      upload = create(:upload, user: @user)
      expect { @user.like(upload) }.to change { @user.likes.count }.by(1)
    end

    it 'dislikes upload on duplicate call' do
      upload = create(:upload)

      expect { @user.like(upload) }.to change { @user.likes.count }.by(1)
      expect { @user.like(upload) }.to change { @user.likes.count }.by(-1)
    end
  end

  describe '#projects' do
    it 'has none if user is fresh' do
      expect(@user.projects.count).to eql(0)
    end

    it 'has one if user supported one project' do
      @upload = create(:upload, user: @user)

      expect(@user.projects.count).to eql(1)
      expect(@user.projects.first).to eql(@upload.projects.first)
    end
  end
end
