defmodule RsvpWeb.EventViewTest do
  use(RsvpWebWeb.ConnCase, async: true)

  @tag current: true
  test "Should convert a date to M/D/YY format" do
    date = ~N[2019-04-06 00:00:00]
    formatted = RsvpWebWeb.EventView.format_date(date)
    assert formatted == "4/6/2019"
  end
end
