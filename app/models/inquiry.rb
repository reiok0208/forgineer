class Inquiry < ApplicationRecord
  validates :name, presence: true, length: { maximum: 10 }
  validates :message, presence: true, length: { maximum: 65535 }
end
