defmodule Cs491hw2masteryWeb.PageControllerTest do
  use Cs491hw2masteryWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
