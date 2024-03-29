class AddConfirmationToEventsHost < ActiveRecord::Migration[7.1]
  def change
    add_column :events_hosts, :confirmed, :boolean, default: false
    add_column :events_hosts, :confirmation_token, :string
    add_column :events_hosts, :confirmed_at, :datetime
  end
end
