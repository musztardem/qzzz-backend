class QuestionForm < Rectify::Form
  attribute :quiz_id, Integer
  attribute :content, String
  attribute :answers, Array[AnswerForm]

  validates :quiz_id, :content, presence: true
  validates :content, length: { maximum: 160 }

  validate :minimal_answers_size
  validate :has_correct_answer

  def minimal_answers_size
    return unless answers.size <= 1
    errors.add(:base, 'should have at least 2 answers.')
  end

  def has_correct_answer
    return if answers.any? { |e| e.correct == true }
    errors.add(:base, 'should have at least one correct answer.')
  end
end
