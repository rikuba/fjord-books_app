# frozen_string_literal: true

class FollowersController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page])
  end
end
