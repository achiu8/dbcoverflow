class QuestionsController < ApplicationController
  before_action :get_questions

  def index
    @question = Question.new
  end

  def show
    @question = Question.find params[:id]
  end

  def new
    redirect_to questions_path
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question }
        format.js {}
      else
        redirect_to questions_path
      end
    end
  end

  def destroy
    @question = Question.find params[:id]
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_path }
      format.js {}
    end
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

  def upvote
    @question = Question.find params[:id]
    @question.increment!(:votes)

    respond_to do |format|
      format.html { redirect_to @question }
      format.js {}
    end
  end

  def downvote
    @question = Question.find params[:id]
    @question.decrement!(:votes)

    respond_to do |format|
      format.html { redirect_to @question }
      format.js {}
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :votes)
  end

  def get_questions
    @questions = Question.order(votes: :desc).order(updated_at: :desc)
  end
end
