defmodule Dunkan.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DunkanWeb.Telemetry,
      Dunkan.Repo,
      {DNSCluster, query: Application.get_env(:dunkan, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Dunkan.PubSub},
      {Guardian.DB.Sweeper, [interval: 60 * 60 * 1000]},
      # Start a worker by calling: Dunkan.Worker.start_link(arg)
      # {Dunkan.Worker, arg},
      # Start to serve requests, typically the last entry
      DunkanWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dunkan.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DunkanWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
