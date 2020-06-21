class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :diary

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 65535 }
end
