class FriendsController < ApplicationController
  def create
    friender = current_user
    friendee = User.find_by(uid: params[:friendee_uid])
    friender.friendees << friendee
    binding.pry
    flash[:success] = "You have added a friend!"
    redirect_to '/dashboard'
    # Friend.create(friender_id: friender, friendee_id: friendee)
  end
end
