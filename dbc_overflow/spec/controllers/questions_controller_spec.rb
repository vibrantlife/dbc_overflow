require 'rails_helper'

describe QuestionsController do
  describe 'GET questions#index' do
    let(:question) { FactoryGirl.create :question}
    before(:each) do
      get :index
    end
    it 'returns a status of 200' do
      expect(response.status).to eq(200)
    end
  end
end
