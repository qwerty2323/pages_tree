class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :slug, null:false
      t.string :title, null:false
      t.text :content
      t.string :ancestry

      t.timestamps
    end

    add_index :pages, :slug, unique:true
    add_index :pages, :ancestry
end
end
