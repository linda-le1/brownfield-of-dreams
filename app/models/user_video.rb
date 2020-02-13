class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: 'video_id'
  belongs_to :user, foreign_key: 'user_id'

  def self.video_titles(user_id)
    joins(video: :tutorial).select('videos.title, videos.id AS video_id, tutorials.id AS tutorial_id').where(user_id: user_id).order('tutorials.title, videos.position')
  end
end
