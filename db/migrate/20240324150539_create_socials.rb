class CreateSocials < ActiveRecord::Migration[7.1]
  def change
    create_table :socials, id: :uuid do |t|
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :linkedin
      t.string :youtube
      t.string :pinterest
      t.string :tiktok
      t.string :snapchat
      t.string :whatsapp
      t.string :telegram
      t.string :website
      t.references :socialable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
