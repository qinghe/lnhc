class CreateCategories < ActiveRecord::Migration
  def up
    create_table :blog_categories do |t|
      t.string :name
      t.string :short_name
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.timestamps
    end
    add_column :blogposts, :category_id, :integer, :default=>0 #  
    add_column :blogposts, :position, :integer, :default=>0 #  
  end
  
  def down
    drop_table :blog_categories
    drop_column :blogposts, :category_id, :position  
  end
end
