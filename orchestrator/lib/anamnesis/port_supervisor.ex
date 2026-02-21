defmodule Anamnesis.PortSupervisor do
  @moduledoc """
  Port Supervisor — Polyglot Runtime Management.

  This module supervises the external processes used by Anamnesis for 
  specialized computation. It manages the lifecycle of OCaml, λProlog, 
  and Julia backends, communicating via the standard Erlang Port protocol.
  """

  use Supervisor

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    # WORKER INVENTORY:
    # 1. ParserPool: A pool of OCaml workers for high-throughput text parsing.
    # 2. LambdaPrologPort: A singleton reasoner for symbolic logic queries.
    # 3. JuliaPort: A singleton analytics engine for complex graph metrics.
    children = [
      {Anamnesis.Ports.ParserPool, pool_size: 4},
      {Anamnesis.Ports.LambdaPrologPort, []},
      {Anamnesis.Ports.JuliaPort, []}
    ]

    # STRATEGY: :one_for_one. If the Julia process crashes due to a 
    # large matrix calculation, the logical reasoner and parsers 
    # continue to operate normally.
    Supervisor.init(children, strategy: :one_for_one)
  end
end
