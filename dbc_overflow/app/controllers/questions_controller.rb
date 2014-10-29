class QuestionsController < ApplicationController
  def index
    @questions = Question.order(votes: :desc)
    @question = Question.new

    response = HTTParty.get("https://api.github.com/zen")
    @quote = response.body
  end

  def show
    @question = Question.find params[:id]
    @answers = @question.answers.order(votes: :desc)
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

  def upvote
    @question = Question.find params[:id]
    @question.increment!(:votes)

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def downvote
    @question = Question.find params[:id]
    @question.decrement!(:votes)

    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :votes)
  end
end
