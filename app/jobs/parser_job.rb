class ParserJob < ApplicationJob
  queue_as :default

  def perform(parse)
    parse.parse_doc!
    parse.geocode_data!
    parse.complete!
  end
end
