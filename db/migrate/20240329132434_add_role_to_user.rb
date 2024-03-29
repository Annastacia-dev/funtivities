class AddRoleToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :integer, default: 0
    add_reference :users, :events_host, foreign_key: true, type: :uuid, null: true
  end
end
