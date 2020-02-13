class FriendsController < ApplicationController
  def create
    friender = current_user
    friendee = User.find_by(uid: params[:friendee_uid])
    if friender.friendees.include?(friendee)
      flash[:error] = 'You have already added this friend!'
    else
      friender.friendees << friendee
      flash[:success] = 'You have added a friend!'
    end
    redirect_to '/dashboard'
  end
end
