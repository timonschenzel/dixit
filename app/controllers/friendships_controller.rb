class FriendshipsController < ActionController::Base
  def show
    @user = User.find(params[:id])
    @new_friends = User.all
  end

  def create
    @user = User.find(params[:user_id])
    @user.friendships.create(friend_id: params[:friend_id])
  end

  def delete

  end
end