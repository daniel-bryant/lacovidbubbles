class AddPositionToData < ActiveRecord::Migration[6.1]
  def change
    change_table :data do |t|
      enable_extension "postgis"
      t.st_point :location, geographic: true
    end
  end
end
