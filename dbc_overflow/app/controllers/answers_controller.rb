class AnswersController < ApplicationController
  def index
  end

  def create
    @question = Question.find params[:question_id]
    @answer = @question.answers.create(answer_params)

    respond_to do |format|
      format.html { redirect_to @question }
      format.js {}
    end
  end

  def upvote
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.increment!(:votes)

    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.js {}
    end
  end

  def downvote
    @question = Question.find params[:question_id]
    @answer = Answer.find params[:id]
    @answer.decrement!(:votes)

    respond_to do |format|
      format.html { redirect_to question_path(@question) }
      format.js {}
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end
end
