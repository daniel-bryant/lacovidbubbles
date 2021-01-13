module ParsesHelper
  GOOGLE_API_KEY_JS = ENV.fetch("GOOGLE_API_KEY_JS")
  GOOGLE_MAPS_API_SRC = "https://maps.googleapis.com/maps/api/js?key=#{GOOGLE_API_KEY_JS}&callback=initMap&libraries=&v=weekly"
  POLYFILL_SRC = "https://polyfill.io/v3/polyfill.min.js?features=default"

  def google_api_maps_tags
    [
      content_tag("script", "", src: POLYFILL_SRC),
      content_tag("script", "", { src: GOOGLE_MAPS_API_SRC, defer: true }, false),
    ].join("\n").html_safe
  end
end
