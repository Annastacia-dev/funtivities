class AddEventStausAndRenameEventTypeToCategory < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :event_type, :event_category
    add_column :events, :event_status, :integer, default: 0
  end
end
