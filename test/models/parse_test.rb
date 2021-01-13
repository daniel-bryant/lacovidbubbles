require "test_helper"

class ParseTest < ActiveSupport::TestCase
  test "creating a new record" do
    assert_difference -> { Parse.count } do
      parse = Parse.create!(type: "NonResParse")
      assert_not parse.complete?
    end
  end

  # test parse_doc! in child models

  test "geocode_data!" do
    stub_request(:any, /https:\/\/maps\.googleapis\.com\/maps\/api\/geocode\/xml/)
      .to_return(body: file_fixture("geocode_result.xml").read)

    @parse = parses(:downloaded)

    assert_difference -> { Position.count }, 2 do
      @parse.geocode_data!
    end
  end

  test "complete!" do
    @parse = parses(:newbie)
    assert_changes -> { @parse.complete? }, from: false, to: true do
      @parse.complete!
    end
  end
end
