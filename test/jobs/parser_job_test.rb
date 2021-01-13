require "test_helper"

class ParserJobTest < ActiveJob::TestCase
  setup do
    @parse = NonResParse.create!
  end

  test "perform" do
    stub_request(:any, "http://publichealth.lacounty.gov/media/coronavirus/locations.htm")
      .to_return(body: file_fixture("media_coronavirus_locations.htm").read)

    stub_request(:any, /https:\/\/maps\.googleapis\.com\/maps\/api\/geocode\/xml/)
      .to_return(body: file_fixture("geocode_result.xml").read)

    assert_difference -> { Datum.count }, 538 do
      assert_difference -> { Position.count }, 538 do
        assert_changes -> { @parse.complete? }, from: false, to: true do
          ParserJob.perform_now(@parse)
        end
      end
    end

    @datum = @parse.data.first

    assert_equal "1", @datum.obs
    assert_equal "3M", @datum.name
    assert_equal "2724 Peck Rd, Monrovia, CA, 91016", @datum.address
    assert_equal 18, @datum.total_staff
    assert_equal 0, @datum.total_non_staff

    @position = @datum.position
    assert_equal 34.146263, @position.latitude
    assert_equal -118.256769, @position.longitude
  end
end
