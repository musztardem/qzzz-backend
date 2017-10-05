class FriendshipForm < Rectify::Form
  attribute :user_id, Integer
  attribute :friend_id, Integer
  attribute :status, Integer

  validates :user_id, :friend_id, presence: true
  validates :check_if_exists

  def check_if_exists
    return if Friendship.between(user_id, friend_id).empty?
    errors.add(:friend_id, 'is already your friend.')
  end
end
