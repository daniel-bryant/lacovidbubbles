require "test_helper"

class CitationTest < ActiveSupport::TestCase
  setup do
    @citation = citations(:one)
  end

  test "creating a new record" do
    assert_difference -> { Citation.count } do
      Citation.create!(
        parse: parses(:citation),
        activity_date: "01/17/2021",
        name: "BIG BELLY GRILL",
        address: "3150 WILSHIRE BLVD",
        city: "LOS ANGELES",
        description: "RESTAURANT (61-150) SEATS HIGH RISK",
      )
    end
  end

  test "address_to_geocode" do
    assert_equal @citation.address_to_geocode, "3835 CROSS CREEK RD, MALIBU"
  end

  test "geocode!" do
    stub_request(:any, /https:\/\/maps\.googleapis\.com\/maps\/api\/geocode\/xml/)
      .to_return(body: file_fixture("geocode_result.xml").read)

    assert_changes -> { @citation.location.to_s },
      from: "", to: "POINT (-118.2567687 34.1462627)" do
      @citation.geocode!
    end

    assert_equal 34.1462627, @citation.location.latitude
    assert_equal -118.2567687, @citation.location.longitude
  end
end
