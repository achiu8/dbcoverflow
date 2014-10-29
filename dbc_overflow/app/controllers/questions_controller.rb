class QuestionsController < ApplicationController
  def index
    @questions = Question.order(votes: :desc)
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

  def up_vote
    @question = Question.find params[:id]
    @question.increment!(:votes)

    redirect_to :back
  end

  def down_vote
    @question = Question.find params[:id]
    @question.decrement!(:votes)

    redirect_to :back
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :votes)
  end
end
