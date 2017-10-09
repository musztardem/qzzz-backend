class Api::V1::AnswerSerializer < ActiveModel::Serializer
  belongs_to :question

  attributes :id, :content
end
