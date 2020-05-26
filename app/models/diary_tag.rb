class DiaryTag < ApplicationRecord
  belongs_to :tag, optional: true
  belongs_to :diary, optional: true
end
