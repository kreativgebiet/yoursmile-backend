require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status(200)
    end

    it ''
  end

  describe 'GET show' do
    it 'returns 200' do
      get :show
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST new' do
    context 'on success' do
      it 'returns created' do
        post :new
        expect(response).to have_http_status(:created)
      end
    end

    context 'on failure' do
      it 'returns unprocessable entity' do
        post :new
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
