# frozen_string_literal: true

class FollowingsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @users = @user.followings.with_attached_avatar.page(params[:page])
  end
end
