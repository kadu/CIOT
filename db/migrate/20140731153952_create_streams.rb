class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.integer :device_id
      t.text :body

      t.timestamps
    end
  end
end
