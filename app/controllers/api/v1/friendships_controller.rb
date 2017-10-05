class Api::V1::FriendshipsController < ApplicationController
  def index
    friendships = current_user.all_friendships
    response = { friends: friendships }
    json_response(response)
  end

  def create
    current_user.friendships.create!(params[:friend_id])
  end

  def accept
  end
end
