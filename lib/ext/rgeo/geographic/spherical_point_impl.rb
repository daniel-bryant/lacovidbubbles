class RGeo::Geographic::SphericalPointImpl
  def as_json
    {
      "latitude" => latitude,
      "longitude" => longitude,
    }
  end
end
