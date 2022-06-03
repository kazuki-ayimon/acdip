class Article < ApplicationRecord
  belongs_to :user

  has_many :article_favorites, dependent: :destroy
  has_many :article_comments, dependent: :destroy

  flag :category, %i[gas watersuppry emergency knowledge earthquake tsunami volcano snow typhoon internalwater riverflood landslide strongwind heatstroke warning jalert]

  default_scope { order(created_at: :desc, id: :desc) }

  validates :title, presence: true
  validates :content, presence: true
  validates :category, presence: true
end
