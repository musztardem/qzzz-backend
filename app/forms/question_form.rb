class QuestionForm < Rectify::Form
  attribute :quiz_id, Integer
  attribute :content, String

  validates :quiz_id, :content, presence: true
  validates :content, length: { maximum: 160 }
end
