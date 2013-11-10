class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :name
      t.string :url
      t.string :type

      t.timestamps
    end
  end
end
