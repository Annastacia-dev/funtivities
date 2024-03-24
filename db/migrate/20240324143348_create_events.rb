class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events, id: :uuid do |t|
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.integer :event_type, default: 0
      t.datetime :start_date
      t.datetime :end_date
      t.string :slug
      t.references :events_host, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
