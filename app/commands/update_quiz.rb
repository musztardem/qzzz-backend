class UpdateQuiz < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    update_quiz
    return broadcast(:ok)
  end

  private

  def update_quiz
    find_quiz.update_attributes!(@form.attributes)
  end

  def find_quiz
    current_user.quizzes.find(@form.id)
  end
end
