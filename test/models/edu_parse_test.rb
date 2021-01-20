require "test_helper"

class EduParseTest < ActiveSupport::TestCase
  test "creating a new record" do
    assert_difference -> { EduParse.count } do
      parse = EduParse.create!
      assert_not parse.complete?
    end
  end

  test "parse_doc!" do
    @parse = EduParse.create!

    assert_difference -> { Datum.count }, 71 do
      @parse.parse_doc!
    end

    @datum = @parse.data.first

    assert_equal "1", @datum.obs
    assert_equal "Amir Family Child Care", @datum.name
    assert_equal "5218 Sylmar Ave, Sherman Oaks, CA, 91401", @datum.address
    assert_equal 3, @datum.total_staff
    assert_equal 6, @datum.total_non_staff

    assert_no_difference -> { EduParse.count } do
      @parse.parse_doc!
    end
  end
end
