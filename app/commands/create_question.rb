class CreateQuestion < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    create_question
    return broadcast(:ok)
  end

  private

  def create_question
    Question.create!(@form.attributes)
  end
end
