# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_one_attached :avatar
  has_many :active_follows,  class_name: 'Follow', foreign_key: 'follower_id',  dependent: :destroy, inverse_of: :follower
  has_many :passive_follows, class_name: 'Follow', foreign_key: 'following_id', dependent: :destroy, inverse_of: :following
  has_many :followings, through: :active_follows
  has_many :followers,  through: :passive_follows

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def follow(user)
    followings << user
  end

  def unfollow(user)
    active_follows.find_by(following_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
