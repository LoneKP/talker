class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes, id: :uuid do |t|
      t.belongs_to :topic, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end