defmodule PhxMdnWeb.PageController do
  use PhxMdnWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
