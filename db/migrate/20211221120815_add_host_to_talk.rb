class AddHostToTalk < ActiveRecord::Migration[7.0]
  def change
    add_column :talks, :host, :string
  end
end
