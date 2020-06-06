defmodule FindYourHappyHourWeb.PageController do
  use FindYourHappyHourWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
