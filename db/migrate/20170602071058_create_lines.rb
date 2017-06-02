class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.text :text
      t.boolean :auth_public, :default => false
      t.index :auth_id
      t.index :corpse_id

      t.timestamps
    end
  end
end
