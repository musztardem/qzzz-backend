class Api::V1::FriendshipSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  attributes :id, :user, :friend, :status

  def user
    Api::V1::UserSerializer.new(object.user).attributes.except(:email)
  end

  def friend
    Api::V1::UserSerializer.new(object.friend).attributes.except(:email)
  end
end
