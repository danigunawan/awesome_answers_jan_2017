class QuestionsController < ApplicationController
  def new
    @question = Question.new
    # by default this will render app/views/questions/new.html.erb
  end

  def create
    # this feature is called strong parameters (introduced in Rails 4+)
    question_params = params.require(:question).permit([:title, :body])
    @question  = Question.new(question_params)
    if @question.save
      # render :show
      # redirect_to question_path({ id: @question.id })
      # redirect_to question_path({ id: @question })
      redirect_to question_path(@question)
    else
      # this will force Rails to render: app/views/questions/new.html.erb
      # instead of the default: app/views/questions/create.html.erb
      render :new
    end
  end

  def show
    @question = Question.find params[:id]
  end

  def index
    @questions = Question.order(created_at: :desc)
  end

  def edit
    @question = Question.find params[:id]
  end

  def update
    @question = Question.find params[:id]
    question_params = params.require(:question).permit([:title, :body])
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit
    end
  end

  def destroy
    question = Question.find params[:id]
    question.destroy
    redirect_to questions_path
  end
end
