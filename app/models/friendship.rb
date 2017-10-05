class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  enum status: [:pending, :accepted]

  scope :between, -> (user, friend) { where(user: user, friend: friend) + where(user: friend, friend: user) }
end
