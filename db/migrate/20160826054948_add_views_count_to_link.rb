class AddViewsCountToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :views_count, :integer, default: 0
  end
end
