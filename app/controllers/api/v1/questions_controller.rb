class Api::V1::QuestionsController < ApplicationController
  def index
    questions = Quiz.find(params[:quiz_id]).questions
    json_response(questions)
  end

  def create
    @form = QuestionForm.from_params(params, user_id: current_user.id)
    CreateOrUpdateQuestion.call(@form) do
      on(:ok) { json_response({ message: 'Question was successfully created' }, :created) }
      on(:invalid) do
        json_response(
          { messages: @form.errors.full_messages },
          :unprocessable_entity
        )
      end
    end
  end

  def show
    question = Question.includes(:answers).find(params[:id])
    json_response(question)
  end

  def update
    @form = QuestionForm.from_params(params, user_id: current_user.id)
    CreateOrUpdateQuestion.call(@form) do
      on(:ok) { json_response({ message: 'Question was successfully updated'})}
      on(:invalid) do
        json_response(
          { messages: @form.errors.full_messages },
          :unprocessable_entity
        )
      end
    end
  end

  def destroy
    Question.find(params[:id]).destroy!
    head :no_content
  end
end
