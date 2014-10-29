require 'spec_helper'

describe AnswersController, type: :controller do
  let(:question) { FactoryGirl.create :question }
  let(:answer) { FactoryGirl.create :answer, :question_id => [question.id] }

  context "#create" do
    it "creates a new answer with valid params" do
      expect {
        post :create,
          question_id: question.id,
          answer: { title: "new title", content: "new content" }
      }.to change { Answer.count }.by(1)
    end

    it "doesn't create a new answer with invalid params" do
      expect {
        post :create,
          question_id: question.id,
          answer: { content: "new content" }
      }.to change { Answer.count }.by(0)
    end
  end

  context "votes" do
    it "should increment votes when upvoted" do
      answer
      expect {
        patch :upvote, { question_id: question.id, id: answer.id }
        answer.reload
      }.to change { answer.votes }.by(1)
    end

    it "should decrement votes when downvoted" do
      question
      expect {
        patch :downvote, { question_id: question.id, id: answer.id }
        answer.reload
      }.to change { answer.votes }.by(-1)
    end
  end
end
