class AddCurrentScribeToCorpses < ActiveRecord::Migration[5.0]
  def change
    add_column :corpses, :current_scribe, :integer
  end
end
