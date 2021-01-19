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
    @datum_three = data(:three)
    @datum_four = data(:four)

    assert_changes -> { @datum_three.reload.location.to_s },
      from: "", to: "POINT (-118.2567687 34.1462627)" do
      assert_changes -> { @datum_four.reload.location.to_s },
        from: "", to: "POINT (-118.2567687 34.1462627)" do
        @parse.geocode_data!
      end
    end
  end

  test "complete!" do
    @parse = parses(:newbie)
    assert_changes -> { @parse.complete? }, from: false, to: true do
      @parse.complete!
    end
  end

  test "cached_as_json" do
    @parse = parses(:geocoded)
    assert_equal @parse.as_json(include: [:data]),
      @parse.cached_as_json
  end
end
