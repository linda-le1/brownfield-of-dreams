class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates_presence_of :first_name, :last_name
  validates_presence_of :password, :on => :create
  validates :email, uniqueness: true, presence: true
  validates_presence_of :uid, allow_blank: true

  has_many :friended_users, foreign_key: :friender_id, class_name: "Friend"
  has_many :friendees, through: :friended_users

  has_many :friendee_users, foreign_key: :friendee_id, class_name: "Friend"
  has_many :frienders, through: :friendee_users

  has_secure_password

  enum role: [:default, :admin]
end
