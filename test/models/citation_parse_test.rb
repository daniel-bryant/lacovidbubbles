require "test_helper"

class CitationParseTest < ActiveSupport::TestCase
  test "creating a new record" do
    assert_difference -> { CitationParse.count } do
      parse = CitationParse.create!
      assert_not parse.complete?
    end
  end

  test "parse_doc!" do
    @parse = CitationParse.create!

    assert_difference -> { Citation.count }, 613 do
      @parse.parse_doc!
    end

    @citation = @parse.citations.first

    assert_equal "01/10/2021", @citation.activity_date
    assert_equal "MALIBU COUNTRY MART", @citation.name
    assert_equal "3835 CROSS CREEK RD", @citation.address
    assert_equal "MALIBU", @citation.city
    assert_equal "SHOPPING MALLS", @citation.description

    assert_no_difference -> { Citation.count } do
      @parse.parse_doc!
    end
  end
end
