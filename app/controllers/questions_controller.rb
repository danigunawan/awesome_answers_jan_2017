class QuestionsController < ApplicationController
  # this will execute the method `find_question` before it executes the action
  # if you give it `only` or `except` options then it will only include or only
  # exclude certain actions
  # remember that `before_action` methods get executed within the same
  # request/response cycle which means if you define an instance variable in
  # the `before_action` method, the variable will be available in the action
  before_action(:find_question, { only: [:show, :edit, :destroy, :update] })

  def new
    @question = Question.new
    # by default this will render app/views/questions/new.html.erb
  end

  def create
    @question  = Question.new(question_params)
    if @question.save
      # render :show
      # redirect_to question_path({ id: @question.id })
      # redirect_to question_path({ id: @question })
      flash[:notice] = 'Question created successfully'
      redirect_to question_path(@question)
    else
      flash.now[:alert] = 'Please fix errors below'
      # this will force Rails to render: app/views/questions/new.html.erb
      # instead of the default: app/views/questions/create.html.erb
      render :new
    end
  end

  def show
  end

  def index
    @questions = Question.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question), notice: 'Question updated!'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Question deleted!'
  end

  private

  def question_params
    # this feature is called strong parameters (introduced in Rails 4+)
    params.require(:question).permit([:title, :body])
  end

  def find_question
    @question = Question.find params[:id]
  end

end
