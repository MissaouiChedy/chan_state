defmodule ChanState.PageController do
  use ChanState.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
