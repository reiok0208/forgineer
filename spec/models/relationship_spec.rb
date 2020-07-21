require 'rails_helper'

RSpec.describe "関係モデル", type: :model do
  describe 'アソシエーションに関するテスト' do
    context 'Followerモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
    end

    context 'Followedモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
