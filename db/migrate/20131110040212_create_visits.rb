class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :name
      t.integer :times

      t.timestamps
    end
  end
end
