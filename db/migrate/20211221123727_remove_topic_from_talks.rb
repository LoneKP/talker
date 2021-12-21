class RemoveTopicFromTalks < ActiveRecord::Migration[7.0]
  def change
    remove_column :talks, :topic, :string
  end
end
