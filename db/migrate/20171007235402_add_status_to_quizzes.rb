class AddStatusToQuizzes < ActiveRecord::Migration[5.1]
  def change
    add_column :quizzes, :status, :integer
  end
end
