class Api::V1::QuizzesController < ApplicationController

  def index
    json_response(current_user.quizzes)
  end

  def create
    @form = QuizForm.from_params(params, user_id: current_user.id)
    CreateQuiz.call(@form) do
      on(:ok) { json_response({ message: 'Quiz was successfully created.' }, :created) }
      on(:invalid) { json_response({ messages: @form.errors.full_messages }, :unprocessable_entity) }
    end
  end

  def show
    quiz = Quiz.find(params[:id])
    json_response(quiz)
  end

  def update
    @form = QuizForm.from_params(params, user_id: current_user.id)
    UpdateQuiz.call(@form) do
      on(:ok) { json_response({ message: 'Quiz was successfully updated.' }) }
      on(:invalid) { json_response({ messages: @form.errors.full_messages }, :unprocessable_entity) }
    end
  end

  def user_quizzes
    user = User.find(params[:user_id])
    quizzes = quizzes_of user
    json_response(quizzes)
  end

  def destroy
    current_user.quizzes.find(params[:id]).destroy!
    head :no_content
  end

  private

  def quizzes_of(user)
    if current_user.is_friend_of? user
      user.quizzes.for_friend
    else
      user.quizzes.visible_for_all
    end
  end
end
