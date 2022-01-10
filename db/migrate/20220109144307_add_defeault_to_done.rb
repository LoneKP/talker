class AddDefeaultToDone < ActiveRecord::Migration[7.0]
  def change
    change_column_default :topics, :done, from: nil, to: false
  end
end
