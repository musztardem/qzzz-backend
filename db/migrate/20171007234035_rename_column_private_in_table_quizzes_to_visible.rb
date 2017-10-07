class RenameColumnPrivateInTableQuizzesToVisible < ActiveRecord::Migration[5.1]
  def change
    rename_column :quizzes, :private, :visible
  end
end
