class AnswerForm < Rectify::Form
  attribute :question_id, Integer
  attribute :correct, Boolean
  attribute :content, String

  validates :content, :question_id, :correct, presence: true
  validates :content, length: { maximum: 50 }
end
