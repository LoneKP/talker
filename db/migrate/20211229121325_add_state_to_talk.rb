class AddStateToTalk < ActiveRecord::Migration[7.0]
  def change
    add_column :talks, :state, :integer, default: 1
  end
end
