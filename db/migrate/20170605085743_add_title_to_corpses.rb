class AddTitleToCorpses < ActiveRecord::Migration[5.0]
  def change
    add_column :corpses, :title, :string
  end
end
