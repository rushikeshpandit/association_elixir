defmodule AssociationElixir.Repo do
  use Ecto.Repo,
    otp_app: :association_elixir,
    adapter: Ecto.Adapters.Postgres
end
