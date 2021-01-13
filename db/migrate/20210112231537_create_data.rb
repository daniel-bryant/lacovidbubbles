class CreateData < ActiveRecord::Migration[6.1]
  def change
    create_table :data do |t|
      t.belongs_to :parse, null: false, foreign_key: true
      t.string :obs, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.integer :total_staff, null: false
      t.integer :total_non_staff, null: false

      t.timestamps
    end
  end
end
