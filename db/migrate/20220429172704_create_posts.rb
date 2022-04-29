class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :views_count, default: 0, null: false
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
