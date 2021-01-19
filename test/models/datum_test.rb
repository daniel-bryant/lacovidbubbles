require "test_helper"

class DatumTest < ActiveSupport::TestCase
  setup do
    @datum = data(:three)
  end

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

  test "address_to_geocode" do
    assert_equal @datum.address_to_geocode, "21822 Lassen St, Chatsworth, CA, 91311"
  end

  test "geocode!" do
    stub_request(:any, /https:\/\/maps\.googleapis\.com\/maps\/api\/geocode\/xml/)
      .to_return(body: file_fixture("geocode_result.xml").read)

    assert_changes -> { @datum.location.to_s },
      from: "", to: "POINT (-118.2567687 34.1462627)" do
      @datum.geocode!
    end

    assert_equal 34.1462627, @datum.location.latitude
    assert_equal -118.2567687, @datum.location.longitude
  end
end
