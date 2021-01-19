class Datum < ApplicationRecord
  include Geocodable

  belongs_to :parse

  def address_to_geocode
    address
  end
end
