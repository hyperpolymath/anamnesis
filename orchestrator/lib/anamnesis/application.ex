defmodule Anamnesis.Application do
  @moduledoc """
  Anamnesis Orchestrator — OTP Application Entry Point.

  This module defines the primary supervision tree for the Anamnesis 
  knowledge extraction engine. It orchestrates the lifecycle of polyglot 
  port processes and the data ingestion pipelines.
  """

  use Application

  @impl true
  def start(_type, _args) do
    # SUPERVISION TREE:
    # 1. PortSupervisor: Manages external binary processes (OCaml, λProlog, Julia).
    # 2. CacheManager: ETS-backed storage for intermediate graph fragments.
    # 3. IngestionPipeline: Reactive stage for raw text processing.
    # 4. QueryPipeline: Handles semantic search and SPARQL resolution.
    # 5. Endpoint: Phoenix web interface for visualization.
    children = [
      {Anamnesis.PortSupervisor, []},
      {Anamnesis.CacheManager, []},
      {Anamnesis.Pipelines.IngestionPipeline, []},
      {Anamnesis.Pipelines.QueryPipeline, []},
      AnamnesisWeb.Telemetry,
      {Phoenix.PubSub, name: Anamnesis.PubSub},
      AnamnesisWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Anamnesis.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    AnamnesisWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
