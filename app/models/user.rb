class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates_presence_of :first_name, :last_name, :password
  validates :email, uniqueness: true, presence: true
  # validates_presence_of :github_token, presence: false
  
  has_secure_password

  enum role: [:default, :admin]
end
