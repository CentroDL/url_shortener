class RemoveViewsFromLinks < ActiveRecord::Migration[5.0]
  def change
    remove_column :links, :views, :integer
  end
end
