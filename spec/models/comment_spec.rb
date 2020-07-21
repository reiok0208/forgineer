require 'rails_helper'

RSpec.describe "コメントモデル", type: :model do
  describe "バリデーションに関するテスト" do
    it "タイトルがなければ無効な状態であること" do
      comment = Comment.new(title: nil)
      comment.valid?
      expect(comment.errors[:title]).to include("を入力してください")
    end
    it "タイトルが30文字以上であれば無効な状態であること" do
      comment = Comment.new(title: "t" * 50)
      comment.valid?
      expect(comment.errors[:title]).to include("は30文字以内で入力してください")
    end
    it "内容がなければ無効な状態であること" do
      comment = Comment.new(body: nil)
      comment.valid?
      expect(comment.errors[:body]).to include("を入力してください")
    end
  end

  describe 'アソシエーションに関するテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Diaryモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:diary).macro).to eq :belongs_to
      end
    end
  end
end
