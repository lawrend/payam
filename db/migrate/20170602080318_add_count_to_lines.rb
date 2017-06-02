class AddCountToLines < ActiveRecord::Migration[5.0]
  def change
    add_column :lines, :count, :integer
  end
end
