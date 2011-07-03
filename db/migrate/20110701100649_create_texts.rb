class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :title
      t.text :body
      t.string :author
      t.integer :words_count

      t.timestamps
    end
  end
end
