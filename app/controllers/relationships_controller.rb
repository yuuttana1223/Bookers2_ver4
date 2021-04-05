class RelationshipsController < ApplicationController
  def create
    other_user = User.find(params[:user_id])
    current_user.follow(other_user)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    other_user = User.find(params[:user_id])
    current_user.unfollow(other_user)
    redirect_back(fallback_location: root_path)
  end
end
