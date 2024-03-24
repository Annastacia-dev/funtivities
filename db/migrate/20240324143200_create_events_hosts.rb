class CreateEventsHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :events_hosts, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :description
      t.integer :status, default: 0
      t.string :slug

      t.timestamps
    end
  end
end
