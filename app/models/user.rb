class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates_presence_of :first_name, :last_name
  validates_presence_of :password, :on => :create
  validates :email, uniqueness: true, presence: true

  has_secure_password

  enum role: [:default, :admin]
end
