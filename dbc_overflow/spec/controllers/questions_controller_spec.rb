require 'rails_helper'

describe QuestionsController do
  let!(:question) { FactoryGirl.create :question}
  describe 'GET questions#index' do
    before :each do
      get :index
    end
    it 'returns a status of 200' do
      expect(response.status).to eq(200)
    end
    it 'should return an array of Question objects' do
      expect(assigns(:questions).length).to be(1)
    end
  end
  describe 'GET questions#show' do
    let!(:answer) {FactoryGirl.create :answer, question: question}
    before :each do
      get :show, id: question.id
    end
    it 'finds a question and defines @answers to a particular question\'s answers' do
      expect(assigns(:answers)).to include(answer)
    end
  end
  describe 'POST question#create' do
    before :each do
      post :create, question: {title: 'test', content: 'sigh this blows'}
    end
    it 'should generate a new question' do
      expect(question.reload.title).to eq(question.title)
    end
  end

  #controller end
end






