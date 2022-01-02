class CreateTalks < ActiveRecord::Migration[7.0]
  def change
    create_table :talks, id: :uuid do |t|
      t.string :topic
      t.integer :duration

      t.timestamps
    end
  end
end
