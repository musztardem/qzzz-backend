class AddPrivateToQuizzes < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :private, :bool
  end
end
