class Parse < ApplicationRecord
  has_many :data
  has_many :citations

  scope :complete, -> { where(complete: true) }

  def geocode_data!
    data.each(&:geocode!)
    citations.each(&:geocode!)
  end

  def complete!
    update!(complete: true)
  end

  def cached_as_json
    Rails.cache.fetch("#{cache_key_with_version}/cached_as_json") do
      as_json(include: [:data])
    end
  end
end
