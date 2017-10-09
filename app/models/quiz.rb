class Quiz < ApplicationRecord
  has_many :questions, dependent: :destroy
  belongs_to :user
  enum status: [
    :invisible,
    :visible_for_friends,
    :visible_for_all
  ]

  scope :for_friend, -> { where(status: [:visible_for_friends, :visible_for_all]) }
end
