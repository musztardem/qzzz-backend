class UpdateQuestion < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    update_question
    return broadcast(:ok)
  end

  private

  def update_question
    find_question.update_attributes!(@form.attributes)
  end

  def find_question
    Question.find(@form.id)
  end
end
