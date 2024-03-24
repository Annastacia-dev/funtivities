class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts, id: :uuid do |t|
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_1, null: false
      t.string :phone_2
      t.string :title
      t.string :slug
      t.integer :status, default: 0
      t.references :contactable, polymorphic: true, null: false
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
