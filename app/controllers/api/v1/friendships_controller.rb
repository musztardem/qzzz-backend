class Api::V1::FriendshipsController < ApplicationController
  def index
    friends = current_user.friends + current_user.inverse_friends
  end

  def create
  end

  def accept
  end
end
