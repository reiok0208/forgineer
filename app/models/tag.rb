class Tag < ApplicationRecord
  has_many :diary_tags, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
