class AddUniqueIndexToKey < ActiveRecord::Migration
  def change
    add_index :devices, :key, unique: true
  end
end
