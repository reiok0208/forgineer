require 'rails_helper'

RSpec.describe DiaryTag, type: :model do
  describe 'アソシエーションに関するテスト' do
    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(DiaryTag.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
    context 'Diaryモデルとの関係' do
      it 'N:1となっている' do
        expect(DiaryTag.reflect_on_association(:diary).macro).to eq :belongs_to
      end
    end
  end
end
