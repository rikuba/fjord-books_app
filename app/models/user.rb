# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_one_attached :picture

  validates :uid, uniqueness: { scope: :provider }, if: -> { uid.present? }
  validates :picture, content_type: %w[image/jpeg image/png image/gif]

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def picture_medium
    picture.variant(resize_to_limit: [256, 256])
  end

  def picture_small
    picture.variant(resize_and_pad: [32, 32])
  end

  def valid_picture?
    picture.attached? && picture.persisted?
  end
end
