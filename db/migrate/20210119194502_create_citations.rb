class CreateCitations < ActiveRecord::Migration[6.1]
  def change
    create_table :citations do |t|
      t.belongs_to :parse, null: false, foreign_key: true
      t.string :activity_date, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :description, null: false
      t.st_point :location, geographic: true

      t.timestamps
    end
  end
end
