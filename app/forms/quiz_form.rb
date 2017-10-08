class QuizForm < Rectify::Form
  attribute :user_id, Integer
  attribute :title, String
  attribute :description, String

  validates :user_id, :title, :description, presence: true
end
