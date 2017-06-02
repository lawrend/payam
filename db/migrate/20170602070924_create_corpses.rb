class CreateCorpses < ActiveRecord::Migration[5.0]
  def change
    create_table :corpses do |t|
      t.integer :counter, :null => false, :default => 1
      t.index :style_id

      t.timestamps
    end
  end
end
