class ChangeColumntoNullonVideos < ActiveRecord::Migration[5.2]
  def change
      change_column_default(:videos, :position, from: 0, to: nil)
  end
end