module ParsesHelper
  GOOGLE_API_KEY_JS = ENV.fetch("GOOGLE_API_KEY_JS")
  GOOGLE_MAPS_API_SRC = "https://maps.googleapis.com/maps/api/js?key=#{GOOGLE_API_KEY_JS}&callback=initMap&libraries=&v=weekly"
  POLYFILL_SRC = "https://polyfill.io/v3/polyfill.min.js?features=default"

  SETTINGS_HUMANIZED = {
    "non_res_parses" => "Non-Residential Settings",
    "edu_parses" => "Educational Settings",
    "citation_parses" => "Citations",
  }

  def google_api_maps_tags
    [
      content_tag("script", "", src: POLYFILL_SRC),
      content_tag("script", "", { src: GOOGLE_MAPS_API_SRC, defer: true }, false),
    ].join("\n").html_safe
  end

  def setting_humanized(name)
    SETTINGS_HUMANIZED[name]
  end

  def is_active_class(name)
    controller_name == name ? "is-active" : nil
  end
end
