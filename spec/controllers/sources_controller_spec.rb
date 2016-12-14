require 'rails_helper'
require 'stripe_mock'

RSpec.describe SourcesController, type: :controller do
  before { StripeMock.start }
  after { StripeMock.stop }

  let(:stripe_helper) { StripeMock.create_test_helper }
  let(:user) { create(:user) }

  describe 'POST #create' do
    let(:src) { stripe_helper.generate_card_token }
    before(:each) { auth_request(user) }

    context 'with valid source id' do
      it 'assigns the new source to `src`' do
        post :create, params: { source: src }
        expect(assigns(:src)).to be_an(Object)
      end

      it 'sets the new source id as default_source' do
        post :create, params: { source: src }
        expect(assigns(:customer).default_source).to eql(assigns(:src).id)
      end
    end
  end
end
