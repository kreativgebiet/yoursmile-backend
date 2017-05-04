require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { create(:user) }

  before(:each) do
    auth_request(user)
  end

  describe 'GET #uploads' do
    it 'returns 200' do
      get :uploads, params: { id: user.to_param }
      expect(response).to have_http_status(200)
    end

    it 'assigns @uploads' do
      upload = create(:upload, { user_id: user.id })
      get :uploads, params: { id: user.to_param }
      expect(assigns(:uploads)).to match_array([upload])
    end
  end

  describe 'GET #show' do
    it 'returns 200' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(200)
    end

    it 'assigns user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eql(user)
    end
  end

  describe 'GET #supported_projects' do
    it 'returns 200' do
      get :supported_projects, params: { id: user.id }
      expect(response).to have_http_status(200)
    end

    it 'assigns user to @user' do
      @upload = create(:upload, user: user)

      get :supported_projects, params: { id: user.id }
      expect(assigns(:projects)).to match_array([@upload.projects.first])
    end
  end

  describe 'POST #follow' do
    it 'returns 204 if succeeded' do
      follower = create(:user)
      post :follow, params: { id: follower.id }
      expect(response).to have_http_status(204)
    end

    it 'returns 422 if failed' do
      post :follow, params: { id: 'test' }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET #followers' do
    it 'returns 200 status code' do
      get :followers, params: { id: user.to_param }
      expect(response).to have_http_status(200)
    end

    it 'assigns users followers' do
      get :followers, params: { id: user.to_param }
      expect(assigns(:followers)).to eq(user.followers)
    end
  end

  describe 'GET #following' do
    it 'returns 200 status code' do
      get :following, params: { id: user.to_param }
      expect(response).to have_http_status(200)
    end

    it 'assigns users followings' do
      get :following, params: { id: user.to_param }
      expect(assigns(:following)).to eq(user.following)
    end
  end
end
