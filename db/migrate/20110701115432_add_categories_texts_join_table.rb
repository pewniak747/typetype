class AddCategoriesTextsJoinTable < ActiveRecord::Migration
  def up
    create_table :categories_texts, :id => false do |t|
      t.integer :category_id
      t.integer :text_id
    end
  end

  def down
    drop_table :categories_texts
  end
end
