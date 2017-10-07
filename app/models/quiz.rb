class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  belongs_to :user
  enum status: [
    :invisible,
    :visible_for_friends
    :visible_for_all
  ]
end
