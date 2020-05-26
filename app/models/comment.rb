class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :diary

  validates :title, presence: true
  validates :body, presence: true
end
