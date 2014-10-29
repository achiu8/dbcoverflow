class AnswersController < ApplicationController
  def index
  end

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.create(answer_params)
    redirect_to @question
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end
end
