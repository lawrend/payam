class AddStyleRefToCorpses < ActiveRecord::Migration[5.0]
  def change
    add_reference :corpses, :style, foreign_key: true
  end
end
