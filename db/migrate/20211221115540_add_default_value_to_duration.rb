class AddDefaultValueToDuration < ActiveRecord::Migration[7.0]
  def change
    change_column_default :talks, :duration, from: nil, to: 30
  end
end
