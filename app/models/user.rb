# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts, foreign_key: 'user_id', dependent: :destroy

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :follower_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :follower_users

  has_many :blocked_users, foreign_key: :blocker_id, class_name: 'Block'
  has_many :blockeds, through: :blocked_users
  has_many :blocker_users, foreign_key: :blocked_id, class_name: 'Block'
  has_many :blockers, through: :blocker_users
end
