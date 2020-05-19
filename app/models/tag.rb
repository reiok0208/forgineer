class Tag < ApplicationRecord
  has_many :diary_tags, dependent: :destroy

  validates :name, presence: true
end
