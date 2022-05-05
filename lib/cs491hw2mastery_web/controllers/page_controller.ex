defmodule Cs491hw2masteryWeb.PageController do
  use Cs491hw2masteryWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
