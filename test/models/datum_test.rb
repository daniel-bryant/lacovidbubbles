require "test_helper"

class DatumTest < ActiveSupport::TestCase
  test "creating a new record" do
    assert_difference -> { Datum.count } do
      Datum.create!(
        parse: parses(:downloaded),
        obs: "541",
        name: "Big Belly Burger",
        address: "3150 Wilshire Blvd, Los Angeles, CA, 90010",
        total_staff: 12,
        total_non_staff: 1,
      )
    end
  end

  test "geocode!" do
    stub_request(:any, /https:\/\/maps\.googleapis\.com\/maps\/api\/geocode\/xml/)
      .to_return(body: file_fixture("geocode_result.xml").read)

    @datum = data(:three)

    assert_difference -> { Position.count }, 1 do
      @datum.geocode!
    end

    @position = @datum.position
    assert_equal 34.146263, @position.latitude
    assert_equal -118.256769, @position.longitude
  end
end
