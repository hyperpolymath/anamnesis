defmodule Anamnesis.Ports.JuliaPort do
  @moduledoc """
  Julia Analytics Port Bridge — High-Performance Computing Interface.

  This module manages the connection to the Julia-based analytics engine. 
  It provides the primary interface for complex mathematical and 
  semantic operations within the Anamnesis orchestrator.

  ## Analytical Capabilities:
  - **RDF Generation**: Transforms conversations into semantic N-Triples.
  - **SPARQL Execution**: Communicates with the knowledge graph.
  - **Graph Metrics**: Computes centrality, complexity, and density.
  - **AI Training**: Manages the lifecycle of Echo State Networks (ESN).

  ## Communication Protocol:
  - **JSON**: Payload serialization for high-level semantic data.
  - **Framing**: Manual 4-byte big-endian length prefixing (`<<len::big-32>>`).
  - **Persistence**: Reuses a long-lived Julia process to avoid JIT startup latency.
  """

  use GenServer
  require Logger

  @impl true
  def init(_opts) do
    # SPAWN: Opens the port to the Julia runner.
    port = Port.open({:spawn, @port_path}, [:binary, {:packet, 4}, :exit_status, :use_stdio])
    {:ok, %{port: port, pending: %{}}}
  end

  # HELPER: Prepends the 4-byte big-endian length header required by the Julia side.
  defp send_request(port, json_string) do
    len = byte_size(json_string)
    Port.command(port, <<len::big-unsigned-32>> <> json_string)
  end

  @impl true
  def handle_call({:generate_rdf, conversation, inferences}, from, state) do
    # DISPATCH: Encodes the request as JSON and sends it over the port.
    request = Jason.encode!(%{action: "generate_rdf", conversation: conversation, inferences: inferences})
    send_request(state.port, request)
    # ... [State management for the reply]
    {:noreply, state}
  end
end
