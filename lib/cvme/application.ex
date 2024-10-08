defmodule Cvme.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CvmeWeb.Telemetry,
      Cvme.Repo,
      {DNSCluster, query: Application.get_env(:cvme, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Cvme.PubSub},
      # Start a worker by calling: Cvme.Worker.start_link(arg)
      # {Cvme.Worker, arg},
      # Start to serve requests, typically the last entry
      CvmeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cvme.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CvmeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
