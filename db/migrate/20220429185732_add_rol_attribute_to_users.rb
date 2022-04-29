class AddRolAttributeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :rol, :integer, default: 0
  end
end
