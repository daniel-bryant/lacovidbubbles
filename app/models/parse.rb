class Parse < ApplicationRecord
  DOC_URL = "http://publichealth.lacounty.gov/media/coronavirus/locations.htm"
  DATUM_KEYS = [:obs, :name, :address, :total_staff, :total_non_staff]

  has_many :data

  scope :complete, -> { where(complete: true) }

  def parse_doc!
    return if data.any?

    doc = Nokogiri::HTML(URI.open(DOC_URL))
    trs = doc.css(tr_path).tap(&:pop)

    attrs_ary = trs.map do |tr|
      values = tr.children.map(&:text)
      Hash[DATUM_KEYS.zip(values)]
    end

    data.create!(attrs_ary)
  end

  def geocode_data!
    data.each(&:geocode!)
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
