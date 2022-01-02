class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics, id: :uuid do |t|
      t.references :talk, type: :uuid, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
