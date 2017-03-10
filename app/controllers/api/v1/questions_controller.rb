class Api::V1::QuestionsController < Api::BaseController

  def index
    @questions = Question.order(created_at: :desc)

    # This will use the built-in `to_json` method that comes with Rails which
    # sends all the attributes without associations
    # render json: @questions.to_json

    # This will use ActiveModel Serializer class: QuestionSerializer which, as
    # we defined it, will serve the question with answers the it will include
    # the creator name.
    # render json: @questions

    # the default behaviour is to render `index.json.jbuilder` which will render
    # JSON as we defined it in the `/app/views/api/v1/questions/index.json.jbuilder`
  end

  def show
    question = Question.find params[:id]

    # in we have ActiveModel Serializer set up for the Question model then when
    # we invoke `render json: question` it will use the ActiveModel Serializer
    # class to render the json instead of the default `to_json` that is built-in
    # with Rails
    render json: question
  end

  def create
    question_params = params.require(:question).permit(:title, :body)
    question        = Question.new question_params
    question.user   = @user
    if question.save
      render json: { id: question.id }
    else
      render json: { errors: question.errors.full_messages }
    end
  end

end
