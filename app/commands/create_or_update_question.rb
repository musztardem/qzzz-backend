class CreateOrUpdateQuestion < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    create_or_update_question
    return broadcast(:ok)
  end

  private

  def create_or_update_question
    if @form.persisted?
      find_question.update_attributes!(@form.attributes)
    else
      Question.create!(@form.attributes)
    end
  end

  def find_question
    Question.find(@form.id)
  end
end
