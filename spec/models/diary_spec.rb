require 'rails_helper'

RSpec.describe "日記モデル", type: :model do
  before do
    @user = create(:user)
  end

  describe "バリデーションに関するテスト" do
    it "タイトルがなければ無効な状態であること" do
      diary = Diary.new(title: nil)
      diary.valid?
      expect(diary.errors[:title]).to include("を入力してください")
    end
    it "タイトルが30文字以上であれば無効な状態であること" do
      diary = Diary.new(title: "t" * 50)
      diary.valid?
      expect(diary.errors[:title]).to include("は30文字以内で入力してください")
    end
    it "内容がなければ無効な状態であること" do
      diary = Diary.new(body: nil)
      diary.valid?
      expect(diary.errors[:body]).to include("を入力してください")
    end
  end

  describe "検索機能に関するテスト" do
    before do
      @diary = create(:diary)
      @diary2 = create(:diary)
      diary3 = Diary.create(
        title: "テスト",
        body: "テスト内容",
      )
    end

    it "検索文字列に一致する日記を返すこと" do
      expect(Diary.search("日記")).to include(@diary, @diary2)
      expect(Diary.search("日記")).not_to include(@diary3)
    end

    it "検索文字列が未入力の場合は全日記を返すこと" do
      expect(Diary.search("")).not_to include
    end
  end

  describe 'アソシエーションに関するテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Diary.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'DiaryTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:diary_tags).macro).to eq :has_many
      end
    end

    context 'Tagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:tags).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Diary.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end
