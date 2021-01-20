require "test_helper"

class NonResParsesControllerTest < ActionDispatch::IntegrationTest
  test "root url" do
    get root_url, as: :html
    assert_response :success
    assert_match /id="map" data-json-url="#{non_res_parse_url(format: :json)}"/, response.body
  end

  test "non_residential url" do
    get non_residential_url, as: :html
    assert_response :success
    assert_match /id="map" data-json-url="#{non_res_parse_url(format: :json)}"/, response.body
  end

  test "non_res_parse url" do
    get non_res_parse_url, as: :json
    assert_response :success
    assert_equal parses(:geocoded).as_json(include: [:data, :citations]),
      response.parsed_body
  end
end
