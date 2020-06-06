class Diary < ApplicationRecord
  belongs_to :user, optional: true
  has_many :diary_tags, dependent: :destroy
  has_many :tags, through: :diary_tags

  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  attachment :diary_image

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true

  is_impressionable counter_cache: true

  def self.search(search)
    if search
      where(['diaries.title LIKE ? OR diaries.body LIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
