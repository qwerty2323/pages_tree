class AddCacheDepth < ActiveRecord::Migration
  def up
    add_column :pages, :ancestry_depth, :integer, default:0
  end

  def down
    remove_column :pages, :ancestry_depth
  end
end
