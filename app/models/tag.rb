class Tag < ApplicationRecord
  has_many :diary_tags, dependent: :destroy
  has_many :diaries, through: :diary_tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 20 }

  def self.search(search)
    Diary.joins(diary_tags: :tag).merge(Tag.where(id: search))
  end

end
