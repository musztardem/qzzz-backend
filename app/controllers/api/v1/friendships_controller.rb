class Api::V1::FriendshipsController < ApplicationController
  def index
    friendships = current_user.all_friendships
    json_response(friendships)
  end

  def create
    @form = FriendshipForm.from_params(params, user_id: current_user.id)
    CreateFriendship.call(@form) do
      on(:ok) { json_response({ message: 'Invitation has been sent' }, :created) }
      on(:invalid) do
        json_response({ messages: @form.errors.full_messages }, :unprocessable_entity )
      end
    end
  end

  def accept
    Friendship.find(params[:friendship_id]).accepted!
    json_response({ message: 'Invitation has been accepted' })
  end

  def destroy
    Friendship.find(params[:id]).destroy!
    head :no_content
  end
end
