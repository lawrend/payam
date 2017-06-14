class AddProtectedToStyles < ActiveRecord::Migration[5.0]
  def change
    add_column :styles, :protected, :boolean, :default => false
  end
end
