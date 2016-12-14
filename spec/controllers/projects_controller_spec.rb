require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #index' do
    it 'returns 200' do
      get :index
      expect(response).to have_http_status(200)
    end

    it 'assigns all uploads as @uploads' do
      project = create(:project)

      p "Using #{project.country_code} for validation."

      get :index, params: {}
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe 'GET #show' do
    it 'returns 200' do
      project = create(:project)
      get :show, params: { id: project.id }
      expect(response).to have_http_status(200)
    end
  end
end
