class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  attachment :profile_image

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  # ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(followed_id: other_user.id)
    end
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    relatiohship = self.relationships.find_by(followed_id: other_user.id)
    relatiohship.destroy if relatiohship
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    # 擬似的followerテーブルのUserからRelationshipの中間テーブルを通して擬似的followedテーブルのUserに結びつけ
    self.followings.include?(other_user)
    # self.relationships.where(follower_id: self.id, followed_id: other_user.id).exists?
  end
end
