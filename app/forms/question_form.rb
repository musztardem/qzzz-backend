class QuestionForm < Rectify::Form
  attribute :quiz_id, Integer
  attribute :content, String
  attribute :answers, Array[AnswerForm]

  validates :quiz_id, :content, presence: true
  validates :content, length: { maximum: 160 }
  validate :minimal_answers_size

  def minimal_answers_size
    return if answers.size <= 1
    errors.add(:base, 'should have at least 2 answers')
  end
end
