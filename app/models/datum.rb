class Datum < ApplicationRecord
  GOOGLE_API_KEY = ENV.fetch("GOOGLE_API_KEY")
  LATITUDE_XPATH = "//result//geometry//location//lat"
  LONGITUDE_XPATH = "//result//geometry//location//lng"

  belongs_to :parse

  has_one :position

  def geocode!
    doc = Nokogiri::HTML(URI.open(geocode_uri))

    unless doc.xpath("//status").text == "OK"
      logger.error "Geocode failed for Datum with id #{id}"
      return
    end

    create_position!(
      latitude: doc.xpath(LATITUDE_XPATH).text,
      longitude: doc.xpath(LONGITUDE_XPATH).text,
    )
  end

  private

  def geocode_uri
    URI::HTTPS.build(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "/maps/api/geocode/xml",
      query: {
        address: address,
        key: GOOGLE_API_KEY,
      }.to_query,
    )
  end
end
