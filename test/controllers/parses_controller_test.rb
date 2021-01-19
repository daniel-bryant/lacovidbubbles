require "test_helper"

class ParsesControllerTest < ActionDispatch::IntegrationTest
  test "root url" do
    get root_url, as: :html
    assert_response :success
    assert_match /id="map"/, response.body
  end

  test "latest parse url" do
    get parses_latest_url, as: :json
    assert_response :success
    assert_equal parses(:geocoded).as_json(include: [:data]),
      response.parsed_body
  end
end
