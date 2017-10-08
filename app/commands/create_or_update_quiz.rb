class CreateOrUpdateQuiz < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    create_or_update_quiz
    return broadcast(:ok)
  end

  private

  def create_or_update_quiz
    if @form.persisted?
      find_quiz.update_attributes!(@form.attributes)
    else
      current_user.quizzes.create!(@form.attributes)
    end
  end

  def find_quiz
    current_user.quizzes.find(@form.id)
  end
end
