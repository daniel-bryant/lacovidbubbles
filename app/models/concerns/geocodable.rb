module Geocodable
  extend ActiveSupport::Concern

  GOOGLE_API_KEY = ENV.fetch("GOOGLE_API_KEY")
  LATITUDE_XPATH = "//result//geometry//location//lat"
  LONGITUDE_XPATH = "//result//geometry//location//lng"


  def geocode!
    doc = Nokogiri::HTML(URI.open(geocode_uri))

    unless doc.xpath("//status").text == "OK"
      logger.error "Geocode failed for #{self.class.name} with id #{id}"
      return
    end

    lat = doc.at_xpath(LATITUDE_XPATH).text
    lon = doc.at_xpath(LONGITUDE_XPATH).text
    update!(location: "POINT(#{lon} #{lat})")
  end

  private

  def geocode_uri
    URI::HTTPS.build(
      scheme: "https",
      host: "maps.googleapis.com",
      path: "/maps/api/geocode/xml",
      query: {
        address: address_to_geocode,
        key: GOOGLE_API_KEY,
      }.to_query,
    )
  end
end
