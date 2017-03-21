class AnswersController < ApplicationController
  def create
    answer_params    = params.require(:answer).permit(:body)
    @answer          = Answer.new answer_params
    @question        = Question.find params[:question_id]
    @answer.question = @question
    respond_to do |format|
      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later
        format.html { redirect_to question_path(params[:question_id]), notice: 'answer created!' }
        format.js   { render :success }
      else
        flash[:alert] = 'please fix errors'
        format.html { render 'questions/show' }
        format.js   { render :failure }
      end
    end
  end

  def destroy
    @answer = Answer.find params[:id]
    @answer.destroy
    respond_to do |format|
      format.html do
        redirect_to question_path(@answer.question_id),
                       notice: 'Answer deleted!'
      end
      format.js { render }
    end
  end

end
