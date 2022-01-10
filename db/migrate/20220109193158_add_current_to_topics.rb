class AddCurrentToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :current, :boolean, default: false
  end
end
