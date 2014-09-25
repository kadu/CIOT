class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.references :device, index: true
      t.string :title
      t.string :email
      t.string :property
      t.string :operation
      t.string :value
      t.string :message

      t.timestamps
    end
  end
end
