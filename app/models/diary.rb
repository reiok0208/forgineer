class Diary < ApplicationRecord
  belongs_to :user, optional: true
  has_many :diary_tags, dependent: :destroy
  has_many :tags, through: :diary_tags

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :diary_image

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true
end
