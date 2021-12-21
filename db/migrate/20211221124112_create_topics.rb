class CreateTopics < ActiveRecord::Migration[7.0]
  def change
    create_table :topics do |t|
      t.references :talk, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
