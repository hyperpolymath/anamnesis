defmodule Anamnesis.Ports.LambdaPrologPort do
  @moduledoc """
  λProlog Reasoning Port Bridge — Symbolic Logic Interface.

  This module manages the connection to the ELPI (Embeddable Lambda-Prolog 
  Interpreter) reasoner. It provides the high-level symbolic reasoning 
  capabilities for Anamnesis, allowing for higher-order logic queries 
  over conversation and artifact graphs.

  ## Reasoning Capabilities:
  - **Artifact Lifecycle**: Deterministically tracks state transitions 
    (Created -> Modified -> Evaluated).
  - **Fuzzy Membership**: Infers the strength of association between 
    conversations and project categories.
  - **Contamination Detection**: Identifies when knowledge from one 
    silo has leaked into another unverified context.
  - **Episodic Querying**: Complex temporal searches across the history 
    of user interactions.

  ## Communication Protocol:
  - **ETF**: Uses Erlang External Term Format for seamless data exchange 
    with the OCaml host.
  - **Packet Framing**: Standard 4-byte length prefix (`{:packet, 4}`).
  """

  use GenServer
  require Logger

  @impl true
  def init(_opts) do
    # SPAWN: Launches the OCaml-based ELPI reasoner process.
    port = Port.open({:spawn, @port_path}, [:binary, {:packet, 4}, :exit_status])
    {:ok, %{port: port, pending: %{}}}
  end

  @impl true
  def handle_call({:reason, conversation}, from, state) do
    # DISPATCH: Submits a conversation map for symbolic fact extraction.
    ref = make_ref()
    request = %{ref: ref, action: :reason, conversation: conversation}
    Port.command(state.port, :erlang.term_to_binary(request))
    {:noreply, %{state | pending: Map.put(state.pending, ref, from)}}
  end
end
