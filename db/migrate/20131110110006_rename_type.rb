class RenameType < ActiveRecord::Migration
  def change
  	rename_column :urls, :type, :url_type
  end
end
