class Api::V1::QuizzesController < ApplicationController

  def index
    json_response({ quizzes: current_user.quizzes })
  end

  def create
    @form = QuizForm.from_params(params, user_id: current_user.id)
    CreateOrUpdateQuiz.call(@form) do
      on(:ok) { json_response({ message: 'Quiz was successfully created.' }, :created) }
      on(:invalid) { json_response({ messages: @form.errors.full_messages }, :unprocessable_entity) }
    end
  end

  def edit
  end

  def update
    @form = QuizForm.from_params(params, user_id: current_user.id)
    CreateOrUpdateQuiz.call(@form) do
      on(:ok) { json_response({ message: 'Quiz was successfully updated.' }) }
      on(:invalid) { json_response({ messages: @form.errors.full_messages }, :unprocessable_entity) }
    end
  end

  def user_quizzes
  end

  def destroy
    current_user.quizzes.find(params[:id]).destroy!
    head :no_content
  end
end
