class Tutorial < ApplicationRecord
  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  validates_presence_of :title, :description, :thumbnail

  def self.not_classroom_content
    where(classroom: false)
  end
end
