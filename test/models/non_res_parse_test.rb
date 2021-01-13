require "test_helper"

class NonResParseTest < ActiveSupport::TestCase
  test "creating a new record" do
    assert_difference -> { NonResParse.count } do
      parse = NonResParse.create!
      assert_not parse.complete?
    end
  end

  test "parse_doc!" do
    stub_request(:any, "http://publichealth.lacounty.gov/media/coronavirus/locations.htm")
      .to_return(body: file_fixture("media_coronavirus_locations.htm").read)

    @parse = NonResParse.create!

    assert_difference -> { Datum.count }, 538 do
      @parse.parse_doc!
    end

    @datum = @parse.data.first

    assert_equal "1", @datum.obs
    assert_equal "3M", @datum.name
    assert_equal "2724 Peck Rd, Monrovia, CA, 91016", @datum.address
    assert_equal 18, @datum.total_staff
    assert_equal 0, @datum.total_non_staff
  end
end
