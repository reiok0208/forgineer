class Diary < ApplicationRecord
  belongs_to :user
  has_many :diary_tags, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :diary_image_id

  validates :title, presence: true
  validates :body, presence: true
end
