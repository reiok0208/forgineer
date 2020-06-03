class Tag < ApplicationRecord
  has_many :diary_tags, dependent: :destroy
  has_many :diaries, through: :diary_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

  def self.search(search)
    if search
      self.find(search).diaries.order(id: "DESC")
    else
      all.order(id: "DESC")
    end
  end

end
