namespace :backfill do
  desc "Backfill locations from position"
  task locations: :environment do
    Datum.find_each do |d|
      d.location = "POINT(#{d.position.longitude.to_f} #{d.position.latitude.to_f})"
      d.save!
    end
  end
end
