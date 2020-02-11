class ChangeColumnonVideos < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:videos, :position, from: nil, to: 0)
  end
end
