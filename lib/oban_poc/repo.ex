defmodule ObanPoc.Repo do
  use Ecto.Repo,
    otp_app: :oban_poc,
    adapter: Ecto.Adapters.Postgres
end
