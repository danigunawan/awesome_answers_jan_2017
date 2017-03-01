class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, :authorize_vote_creation, only: :create
  before_action :find_vote, :authorize_vote_change, only: [:update, :destroy]

  def create
    vote = Vote.new user: current_user, question: @q, is_up: params[:is_up]
    if vote.save
      redirect_to @q, notice: 'Thanks for voting!'
    else
      redirect_to @q, alert: 'Could not vote'
    end
  end

  def update
    if @vote.update is_up: params[:is_up]
      redirect_to @vote.question, notice: 'vote changed!'
    else
      redirect_to @vote.question, alert: 'vote not changed!'
    end
  end

  def destroy
    if @vote.destroy
      redirect_to @vote.question, notice: 'Vote removed'
    else
      redirect_to @vote.question, alert: 'Can\'t remove vote'
    end
  end

  private

  def find_question
    @q = Question.find params[:question_id]
  end

  def authorize_vote_creation
    redirect_to @q, alert: 'can\'t vote!' if cannot? :vote, @q
  end

  def find_vote
    @vote = Vote.find params[:id]
  end

  def authorize_vote_change
    if cannot? :manage, @vote
      redirect_to @vote.question, alert: 'can\'t change vote'
    end
  end
end
