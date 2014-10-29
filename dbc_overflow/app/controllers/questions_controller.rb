class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @question = Question.new
  end

  def show
    @question = Question.find params[:id]
    @answers = @question.answers
  end

  def new
    redirect_to questions_path
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      redirect_to questions_path
    end
  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy

    redirect_to questions_path
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
