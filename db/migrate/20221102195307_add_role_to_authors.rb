class AddRoleToAuthors < ActiveRecord::Migration[7.0]
  def change
    add_column :authors, :role, :integer, default: 0
  end
end
