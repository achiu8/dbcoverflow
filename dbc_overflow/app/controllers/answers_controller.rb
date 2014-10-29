class AnswersController < ApplicationController
  def index
  end

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.create(answer_params)
    redirect_to @question
  end

  def upvote
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.increment!(:votes)

    redirect_to question_path(@question)
  end

  def downvote
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.decrement!(:votes)

    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end
end
