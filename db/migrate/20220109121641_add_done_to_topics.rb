class AddDoneToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :done, :boolean
  end
end
