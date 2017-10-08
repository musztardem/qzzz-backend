class CreateQuiz < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    create_quiz
    return broadcast(:ok)
  end

  private

  def create_quiz
    current_user.quizzes.create!(@form.attributes)
  end
end
