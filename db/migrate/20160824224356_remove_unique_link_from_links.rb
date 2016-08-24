class RemoveUniqueLinkFromLinks < ActiveRecord::Migration[5.0]
  def change
    remove_column :links, :unique_link, :string
  end
end
