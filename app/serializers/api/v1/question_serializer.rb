class Api::V1::QuestionSerializer < ActiveModel::Serializer
  has_many :answers

  attributes :id, :content
end
