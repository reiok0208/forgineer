require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = create(:user)
    @user2 = create(:user)
  end
  describe "バリデーションに関するテスト" do
    it "名前、ニックネーム、メール、パスワードがあれば有効な状態であること" do
      expect(@user).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("を入力してください")
    end

    it "名前が10文字以上であれば無効な状態であること" do
      user = User.new(name: "testtesttest")
      user.valid?
      expect(user.errors[:name]).to include("は10文字以内で入力してください")
    end

    it "ニックネームがなければ無効な状態であること" do
      user = User.new(nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "ニックネームが10文字以上であれば無効な状態であること" do
      user = User.new(nickname: "testtesttest")
      user.valid?
      expect(user.errors[:nickname]).to include("は10文字以内で入力してください")
    end

    it "自己紹介がなくても有効な状態であること" do
      user = User.new(introduction: nil)
      user.valid?
    end

    it "自己紹介が160文字以上であれば無効な状態であること" do
      user = User.new(introduction: "t" * 200)
      user.valid?
      expect(user.errors[:introduction]).to include("は160文字以内で入力してください")
    end

    it "メールがなければ無効な状態であること" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスなら無効な状態であること" do
      user = User.new(
        name: "テスト太郎",
        nickname:  "テスト",
        email:      @user.email,
        password:   "testTarou1111",
      )
      user.valid?
      expect(user.errors[:email]).to include("はすでに存在します")
    end
  end

  describe 'アソシエーションに関するテスト' do
    context 'Diaryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:diaries).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context 'CommentDiaryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comment_diaries).macro).to eq :has_many
      end
    end
    context 'FavoriteDiaryモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:favorite_diaries).macro).to eq :has_many
      end
    end
    context 'Followerモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:follower).macro).to eq :has_many
      end
    end
    context 'Followedモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:followed).macro).to eq :has_many
      end
    end
    context 'FollowingUserモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:following_user).macro).to eq :has_many
      end
    end
    context 'FollowerUserモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:follower_user).macro).to eq :has_many
      end
    end
  end

  describe 'フォローに関するテスト' do
    it 'フォローが正常に行われる' do
      @user.follow(@user2.id)
      expect(@user.following_user).to eq [@user2]
    end

    it 'フォローを解除できる' do
      @user.follow(@user2.id)
      @user.unfollow(@user2.id)
      expect(@user.following_user).not_to eq [@user2]
    end

    it 'フォローしているか検証できる' do
      @user.follow(@user2.id)
      expect(@user.following?(@user2)).to eq true
    end

    it 'フォローしていないか検証できる' do
      expect(@user.following?(@user2)).to eq false
    end
  end

end
