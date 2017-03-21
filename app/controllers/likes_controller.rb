class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: [:destroy]
  before_action :find_question, only: [:create]

  def index
    @user = User.find(params[:user_id])
    @questions = @user.liked_questions
  end

  def create
    if cannot? :like, @question
      respond_to do |format|
        format.html do
          redirect_to question_path(@question),
                      alert: 'Liking your own Question isn\'t allowed'
        end
        format.js { render js: 'alert("You can\'t like your own question");' }
      end
      # redirect_to and render does not prevent the rest of method from executing
      # calling redirect_to and/or render twice or more in an action will cause
      # an error
      # 👇 do an early return in an action if the rest of the code should not be
      # executed
      return
    end

    @like = Like.new(user: current_user, question: @question)

    if @like.save
      respond_to do |format|
        format.html { redirect_to question_path(@question), notice: 'Question liked! 💙' }
        format.js   { render }
      end
    else
      respond_to do |format|
        format.html { redirect_to question_path(@question), alert: 'Couldn\'t like question! 💔' }
        format.js   { render }
      end
    end
  end

  # because only the last argument of redirect_to changes on whether or not like.save is
  # successful

  def destroy
    @question = @like.question
    if cannot? :like, @question
      respond_to do |format|
        format.html do
          redirect_to question_path(@question),
                      alert: 'Un-liking your own Question isn\'t allowed'
        end
        format.js { render js: 'can\'t unlike' }
      end
      return
    end

    @destroy_outcome = @like.destroy

    respond_to do |format|
      format.html do
        redirect_to(
        question_path(@question),
          @destroy_outcome ? {notice: 'Question Un-liked! 💔'} : {alert: @like.errors.full_messages.join(', ')}
        )
      end
      format.js { render }
    end
  end

  private

  def find_like
    @like ||= Like.find(params[:id])
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end
end
