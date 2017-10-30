class AnswerForm < Rectify::Form
  attribute :question_id, Integer
  attribute :correct, Boolean
  attribute :content, String

  validates :content,
    presence: true,
    length: { maximum: 50 }
  validates :correct, inclusion: { in: [true, false] }
end
