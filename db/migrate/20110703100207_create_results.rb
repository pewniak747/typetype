class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :time
      t.boolean :cheat, :default => false
      t.string  :name
      t.integer :text_id

      t.timestamps
    end
  end
end
