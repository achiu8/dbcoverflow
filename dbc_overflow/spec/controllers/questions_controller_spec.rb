require 'spec_helper'

describe QuestionsController, type: :controller do
  context "displays" do
    let(:question) { FactoryGirl.create :question }
    let(:answer) { FactoryGirl.create :answer, :question_id => [question.id] }

    it "#index" do
      get :index
      expect(assigns(:questions)).to eq Question.all
    end

    it "#show" do
      get :show, id: question.id
      expect(assigns(:question)).to eq question
      expect(assigns(:answers)).to eq question.answers
      expect(response).to render_template "show"
    end
  end
end
