class FriendshipForm < Rectify::Form
  attribute :user_id, Integer
  attribute :friend_id, Integer

  validates :user_id, :friend_id, presence: true
  validate :check_if_exists

  def check_if_exists
    friendship = Friendship.between(user_id, friend_id).first
    return if friendship.nil? || friendship.try(:pending?)

    errors.add(:friend_id, 'is already your friend.')
  end
end
