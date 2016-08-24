class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :original_link, unique: true
      t.string :unique_link, unique: true
      t.integer :views, default: 0

      t.timestamps
    end
  end
end
