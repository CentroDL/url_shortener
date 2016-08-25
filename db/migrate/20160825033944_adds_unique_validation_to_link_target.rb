class AddsUniqueValidationToLinkTarget < ActiveRecord::Migration[5.0]
  def change
    add_index :links, :target, unique: true
  end
end
