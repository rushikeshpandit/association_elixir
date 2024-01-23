defmodule AssociationElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AssociationElixirWeb.Telemetry,
      AssociationElixir.Repo,
      {DNSCluster,
       query: Application.get_env(:association_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AssociationElixir.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AssociationElixir.Finch},
      # Start a worker by calling: AssociationElixir.Worker.start_link(arg)
      # {AssociationElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      AssociationElixirWeb.Endpoint,
      {Finch, name: Swoosh.Finch}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AssociationElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AssociationElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
