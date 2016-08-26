class CreateViews < ActiveRecord::Migration[5.0]
  def change
    create_table :views do |t|
      t.string :ip_address, required: true
      t.references :link, foreign_key: true, required: true

      t.timestamps
    end
  end
end
