class AddDefaultValueToDuration < ActiveRecord::Migration[7.0]
  def change
    change_column :talks, :duration, :integer, :default => 30
  end
end
