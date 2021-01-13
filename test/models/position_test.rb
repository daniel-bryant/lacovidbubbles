require "test_helper"

class PositionTest < ActiveSupport::TestCase
  setup do
    @datum = data(:three)
  end

  test "creating a new record" do
    assert_difference -> { Position.count } do
      Position.create!(
        datum: @datum,
        latitude: 34.0613026,
        longitude: -118.2932071,
      )
    end
  end
end
