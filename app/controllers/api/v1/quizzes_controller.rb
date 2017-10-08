class Api::V1::QuizzesController < ApplicationController

  def index
    json_response({ quizzes: current_user.quizzes })
  end

  def create
    @form = QuizForm.from_params(params, user_id: current_user.id)
    CreateQuiz.call(@form) do
      on(:ok) { json_response({ message: 'Quiz was successfully created.' }) }
      on(:invalid) { json_response({ messages: @form.errors.full_messages }), :unprocessable_entity }
    end
  end

  def user_quizzes
  end

  def destroy
  end
end
