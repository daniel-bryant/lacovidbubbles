require "test_helper"

class EduParsesControllerTest < ActionDispatch::IntegrationTest
  test "educational url" do
    get educational_url, as: :html
    assert_response :success
    assert_match /id="map" data-json-url="#{edu_parse_url(format: :json)}"/, response.body
  end

  test "edu_parse url" do
    get edu_parse_url, as: :json
    assert_response :success
    assert_equal parses(:education_complete).as_json(include: [:data, :citations]),
      response.parsed_body
  end
end
