require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  let(:user) { create(:user) }
  let(:projects) { create_list(:project, 3) }
  let(:attributes) { attributes_for(:upload) }
  let(:valid_attributes) { attributes.merge(project_ids: projects.pluck(:id)) }
  let(:invalid_attributes) { attributes.merge(image: nil) }

  describe 'GET #index' do
    it 'assigns all uploads as @uploads' do
      upload = create(:upload)
      get :index, params: {}
      expect(assigns(:uploads)).to eq([upload])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested upload as @upload' do
      upload = create(:upload)
      get :show, params: { id: upload.to_param }
      expect(assigns(:upload)).to eq(upload)
    end
  end

  describe 'POST #create' do
    before(:each) { auth_request(user) }

    context 'with valid params' do
      it 'creates a new Upload' do
        expect {
          post :create, params: { upload: valid_attributes }
        }.to change(Upload, :count).by(1)
      end

      it 'assigns a newly created upload as @upload' do
        post :create, params: { upload: valid_attributes }

        expect(assigns(:upload)).to be_a(Upload)
        expect(assigns(:upload)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved upload as @upload' do
        post :create, params: { upload: invalid_attributes }
        expect(assigns(:upload)).to be_a_new(Upload)
        expect(assigns(:upload)).to be_invalid
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { description: Faker::Lorem.paragraph } }

      it 'updates the requested upload' do
        upload = create(:upload)
        put :update, params: { id: upload.to_param, upload: new_attributes }
        upload.reload
      end

      it 'assigns the requested upload as @upload' do
        upload = create(:upload)
        put :update, params: { id: upload.to_param, upload: valid_attributes }
        expect(assigns(:upload)).to eq(upload)
      end
    end

    context 'with invalid params' do
      it 'assigns the upload as @upload' do
        upload = create(:upload)
        put :update, params: { id: upload.to_param, upload: invalid_attributes }
        expect(assigns(:upload)).to eq(upload)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) { auth_request(user) }

    it 'destroys the requested upload' do
      upload = create(:upload)
      expect {
        delete :destroy, params: { id: upload.to_param }
      }.to change(Upload, :count).by(-1)
    end
  end
end
