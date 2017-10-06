class CreateFriendship < Rectify::Command
  def initialize(form)
    @form = form
  end

  def call
    return broadcast(:invalid) if @form.invalid?
    @friendship = find_friendship

    if @friendship
      accept_friendship
    else
      create_friendship
    end

    return broadcast(:ok)
  end

  private

  def accept_friendship
    @friendship.accepted!
  end

  def create_friendship
    Friendship.create!(user_id: @form.user_id, friend_id: @form.friend_id)
  end

  def find_friendship
    Friendship.between(@form.user_id, @form.friend_id).first
  end
end
