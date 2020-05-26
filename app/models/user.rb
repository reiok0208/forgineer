class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_diaries, through: :comments, source: :diary
  has_many :favorites, dependent: :destroy
  has_many :favorite_diaries, through: :favorites, source: :diary


  #1つのモデル（Relationship）に2つのアソシエーション（follower,followed）を組むためclass_nameを指定する。
  #foreign_key（入口）はfollower_idを使用してRelationshipへアクセス
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #foreign_key（入口）はfollowed_idを使用してRelationshipへアクセス
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #following_userという架空のクラス（モデル）を命名し、中間テーブルをfollower、follower_id（カレント）に結びついているfollowed_id（フォローしたユーザー）を集める
  has_many :following_user, through: :follower, source: :followed
  #follower_userという架空のクラス（モデル）を命名し、中間テーブルをfollowed、followed_id（カレント）に結びついているfollower_id（フォローされたユーザー）を集める
  has_many :follower_user, through: :followed, source: :follower

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end


  validates :name, presence: true
  validates :nickname, presence: true

  attachment :profile_image
end
