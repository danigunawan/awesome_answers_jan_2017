class AnswersMailer < ApplicationMailer

  def notify_question_owner(answer)
    @answer   = answer
    @question = answer.question
    @owner    = @question.user
    if @owner.present?
      mail(to: @owner.email, subject: 'You got a new answer to your question')
    end
  end

end
