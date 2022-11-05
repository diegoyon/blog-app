class CreateAuthor < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :photo, default: "https://www.charitytaxgroup.org.uk/wp-content/uploads/no-face.jpg"
      t.text :bio
      t.timestamps
      t.integer :posts_counter, default: 0
    end
  end
end
