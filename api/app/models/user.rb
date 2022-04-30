# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader

  has_many :articles, dependent: :destroy
  has_many :infomations, dependent: :destroy
  has_many :favorites, dependent: :destroy

  VALID_USERNAME_REGEX = /\A[\w_]+\z/i
  VALID_PASSWORD_REGEX = /\A[!-~]+\z/

  validates :name, length: { maximum: 50 }
  validates :address, length: { maximum: 30 }
  validates :username, length: { maximum: 30 }, uniqueness: true, allow_nil: true, presence: true, format: { with: VALID_USERNAME_REGEX }
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX }, allow_nil: true

  # 画像URLを返却
  def image_url(version)
    case version
    when :mini
      image? ? image.mini.url : "/images/user/#{version}_noimage.jpg"
    when :small
      image? ? image.small.url : "/images/user/#{version}_noimage.jpg"
    when :medium
      image? ? image.medium.url : "/images/user/#{version}_noimage.jpg"
    when :large
      image? ? image.large.url : "/images/user/#{version}_noimage.jpg"
    when :xlarge
      image? ? image.xlarge.url : "/images/user/#{version}_noimage.jpg"
    else
      logger.warn("[WARN]Not found: User.image_url(#{version})")
      ''
    end
  end

  def infomation_unread_count
    Infomation.by_target(self).by_unread(infomation_check_last_started_at).count
  end

  def favorite!(article)
    favorites.create!(article_id: article.id)
  end

  def unfavorite!(article)
    favorite = favorites.find_by!(article_id: article.id)

    favorite.destroy
  end

  def favorite?(article)
    favorites.exists?(article_id: article.id)
  end
end
