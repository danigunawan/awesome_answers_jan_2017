class AnswersController < ApplicationController
  def create
    answer_params    = params.require(:answer).permit(:body)
    @answer          = Answer.new answer_params
    @question        = Question.find params[:question_id]
    @answer.question = @question
    if @answer.save
      AnswersMailer.notify_question_owner(@answer).deliver_later
      redirect_to question_path(params[:question_id]), notice: 'answer created!'
    else
      flash[:alert] = 'please fix errors'
      render 'questions/show'
    end
  end

  def destroy
    answer = Answer.find params[:id]
    answer.destroy
    redirect_to question_path(answer.question_id), notice: 'Answer deleted!'
  end

end
