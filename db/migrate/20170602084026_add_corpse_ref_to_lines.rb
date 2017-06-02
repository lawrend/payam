class AddCorpseRefToLines < ActiveRecord::Migration[5.0]
  def change
    add_reference :lines, :corpse, foreign_key: true
  end
end
