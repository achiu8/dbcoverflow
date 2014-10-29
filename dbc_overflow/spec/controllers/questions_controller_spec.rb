require 'spec_helper'

describe QuestionsController, type: :controller do
  let(:question) { FactoryGirl.create :question }
  let(:answer) { FactoryGirl.create :answer, :question_id => [question.id] }

  it "#index" do
    question
    get :index
    expect(assigns(:questions)).to include Question.last
  end

  it "#show" do
    get :show, id: question.id
    expect(assigns(:question)).to eq question
    expect(assigns(:answers)).to eq question.answers
    expect(response).to render_template "show"
  end

  context "#create" do
    it "creates a new question with valid params" do
      expect {
        post :create, question: { title: "new title", content: "new content" }
      }.to change { Question.count }.by(1)
    end

    it "doesn't create a new question with invalid params" do
      expect {
        post :create, question: { content: "new content" }
      }.to change { Question.count }.by(0)
    end
  end

  it "#destroy" do
    question
    expect {
      delete :destroy, id: question.id
    }.to change { Question.count }.by(-1)
  end

  it "#edit" do
    get :edit, id: question.id
    expect(assigns(:question)).to eq question
    expect(response).to render_template "edit"
  end

  it "updates question with new values" do
    new_title = "updated title"
    patch :update, id: question.id, question: { title: new_title }
    question.reload
    expect(question.title).to eq new_title
  end

  context "votes" do
    it "should increment votes when upvoted" do
      question
      expect {
        patch :upvote, id: question.id
        question.reload
      }.to change { question.votes }.by(1)
    end

    it "should decrement votes when downvoted" do
      question
      expect {
        patch :downvote, id: question.id
        question.reload
      }.to change { question.votes }.by(-1)
    end
  end
end
