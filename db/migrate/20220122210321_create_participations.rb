class CreateParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :participations, id: :uuid do |t|
      t.boolean :facilitator, default: false
      t.references :visitor, type: :uuid, foreign_key: true
      t.references :talk, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
