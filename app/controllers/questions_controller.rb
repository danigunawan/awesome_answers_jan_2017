class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # this will execute the method `find_question` before it executes the action
  # if you give it `only` or `except` options then it will only include or only
  # exclude certain actions
  # remember that `before_action` methods get executed within the same
  # request/response cycle which means if you define an instance variable in
  # the `before_action` method, the variable will be available in the action
  before_action(:find_question, { only: [:show, :edit, :destroy, :update] })
  before_action :authorize, only: [:edit, :destroy, :update]

  def new
    @question = Question.new
    # by default this will render app/views/questions/new.html.erb
  end

  def create
    @question  = Question.new(question_params)
    @question.user = current_user
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
    @answer = Answer.new
    @vote = @question.vote_for(current_user)
    # respond_to enables us to send different responses depending on the format
    # of the request
    respond_to do |format|
      # `html` is the default format. Render will just render `show.html.erb`
      format.html { render }
      # this will render `show.json.erb`
      # format.json { render }

      # with every ActiveRecord object we have a `to_json` method that returns
      # a JSON object with attributes of every single attribute in the
      # ActiveRecord object
      format.json { render json: @question.to_json }
    end
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
    # { tag_ids: [] } will tell Rails to accept and array of value for `tag_ids`
    # instead of a single value
    params.require(:question).permit([:title, :body, { tag_ids: [] }])
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authorize
    # `can?` and `cannot?` are helper methods that are available in controllers
    # and views that came from the `cancancan` gem and it will check in the
    # `ability.rb` file for a matching rule.
    if cannot?(:manage, @question)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

end
