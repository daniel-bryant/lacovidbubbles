class Citation < ApplicationRecord
  include Geocodable

  belongs_to :parse

  def address_to_geocode
    [address, city].join(", ")
  end
end
