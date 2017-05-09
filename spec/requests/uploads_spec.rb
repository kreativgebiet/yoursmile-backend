require 'rails_helper'

RSpec.describe "Uploads", type: :request do
  describe "GET /uploads" do
    it "works!" do
      get uploads_path
      expect(response).to have_http_status(200)
    end

    it 'returns an array (as "data")' do
      get uploads_path
      parsed_body = JSON.parse(response.body)

      expect(parsed_body['data']).to be_an(Array)
    end
  end
end
