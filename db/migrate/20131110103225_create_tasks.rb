class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :url_name
      t.integer :target
      t.integer :current
      t.date :date
      t.date :last_time

      t.timestamps
    end
  end
end
