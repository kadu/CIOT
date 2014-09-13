class AddTokenToUsers < ActiveRecord::Migration
  def up
    add_column :users, :token, :string
    User.all.each do | user |
      user.save
    end
    add_index :users, :token, unique: true
  end

  def down
    remove_index :users, :token
    remove_column :users, :token    
  end
end
