class AddUserIdToDevices < ActiveRecord::Migration
  def change
    add_reference :devices, :user, index: true
  end
end
