class RemoveHostFromTalks < ActiveRecord::Migration[7.0]
  def change
    remove_column :talks, :host, :string
  end
end
