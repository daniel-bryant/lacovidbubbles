class CreateParses < ActiveRecord::Migration[6.1]
  def change
    create_table :parses do |t|
      t.string :type, null: false
      t.boolean :complete, null: false, default: false

      t.timestamps
      t.index [:type, :complete]
    end
  end
end
