defmodule PhxMdn.Repo do
  use Ecto.Repo,
    otp_app: :phx_mdn,
    adapter: Ecto.Adapters.Postgres
end
