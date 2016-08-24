class RenameOriginalLinkFromLinks < ActiveRecord::Migration[5.0]
  def change
    rename_column :links, :original_link, :target
  end
end
