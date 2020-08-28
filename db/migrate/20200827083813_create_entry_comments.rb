class CreateEntryComments < ActiveRecord::Migration[6.0]
  def change
    create_table :entry_comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :entry, null: false, foreign_key: true

      t.timestamps
    end
  end
end
