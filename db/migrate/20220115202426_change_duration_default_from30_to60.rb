class ChangeDurationDefaultFrom30To60 < ActiveRecord::Migration[7.0]
  def change
    change_column_default :talks, :duration, from: 30, to: 60
  end
end
