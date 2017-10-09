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

  def show
    @quiz = Quiz.find(params[:id])
    json_response({ quiz: quiz })
  end

  def update
    @form = QuizForm.from_params(params, user_id: current_user.id)
    CreateOrUpdateQuiz.call(@form) do
      on(:ok) { json_response({ message: 'Quiz was successfully updated.' }) }
      on(:invalid) { json_response({ messages: @form.errors.full_messages }, :unprocessable_entity) }
    end
  end

  def user_quizzes
    user = User.find(params[:user_id])
    quizzes = if current_user.is_friend_of? user
      Quiz.for_friend
    else
      Quiz.visible_for_all
    end
    json_response( { quizzes: quizzes } )
  end

  def destroy
    current_user.quizzes.find(params[:id]).destroy!
    head :no_content
  end
end
