require "test_helper"

class CitationParsesControllerTest < ActionDispatch::IntegrationTest
  test "citations url" do
    get citations_url, as: :html
    assert_response :success
    assert_match /id="map" data-json-url="#{citation_parse_url(format: :json)}"/, response.body
  end

  test "citation_parse url" do
    get citation_parse_url, as: :json
    assert_response :success
    assert_equal parses(:citation_complete).as_json(include: [:data, :citations]),
      response.parsed_body
  end
end
