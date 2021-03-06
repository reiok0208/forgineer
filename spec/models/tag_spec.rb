require 'rails_helper'

RSpec.describe "タグモデル", type: :model do
  describe "バリデーションに関するテスト" do
    it "名前がなければ無効な状態であること" do
      tag = Tag.new(name: nil)
      tag.valid?
      expect(tag.errors[:name]).to include("を入力してください")
    end

    it "名前が20文字以上であれば無効な状態であること" do
      tag = Tag.new(name: "t" * 30)
      tag.valid?
      expect(tag.errors[:name]).to include("は20文字以内で入力してください")
    end
  end

  describe 'アソシエーションに関するテスト' do
    context 'DiaryTagsモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:diary_tags).macro).to eq :has_many
      end
    end

    context 'Diaryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:diaries).macro).to eq :has_many
      end
    end
  end

  describe 'タグ検索に関するテスト' do
    it '検索タグに一致した記事の表示' do
      @diary = create(:diary)
      @diary2 = Diary.create(title: "記事", body: "テスト")
      @tag = Tag.create(name: "日記")
      @diary_tag = DiaryTag.create(
        diary_id: @diary.id,
        tag_id: @tag.id,
      )
      search_tag = Tag.search(@tag)
      expect(search_tag.ids).to eq [@diary.id]
      expect(search_tag.ids).not_to eq [@diary2.id]
    end
  end
end
