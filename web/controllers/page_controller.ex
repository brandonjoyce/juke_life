defmodule JukeLife.PageController do
  use JukeLife.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
