class CreateBlogposts < ActiveRecord::Migration
  def self.up
    create_table :blogposts do |t|
      t.string :content
      t.string :title
      t.integer :user_id

      t.timestamps
    end
    add_index :blogposts, :user_id
  end

  def self.down
    drop_table :blogposts
  end
end