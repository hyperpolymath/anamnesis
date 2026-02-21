defmodule Anamnesis.Ports.ParserPort do
  @moduledoc """
  Parser Port Bridge — OCaml/Elixir Interop.

  This module manages the connection to the OCaml-based "Alberto" parser. 
  It provides a high-assurance interface for transforming natural language 
  streams into structured conversation maps.

  ## Communication Protocol:
  - **ETF**: Uses Erlang External Term Format for bit-identical data 
    serialization between languages.
  - **Framing**: Uses 4-byte length-prefixed binary packets (`{:packet, 4}`).
  - **Asynchrony**: Implements a 'Correlation ID' (reference) pattern to 
    handle multiple concurrent parse requests.
  """

  use GenServer
  require Logger

  # COMPILATION: Resolves the physical path to the parser binary.
  @port_path Application.compile_env(:anamnesis, :parser_port_path, "../parser/_build/default/bin/parser_port.exe")

  @impl true
  def init(_opts) do
    # SPAWN: Opens the physical port to the OCaml executable.
    port = Port.open({:spawn, @port_path}, [:binary, {:packet, 4}, :exit_status])
    {:ok, %{port: port, pending: %{}}}
  end

  @impl true
  def handle_call({:parse, content, format}, from, state) do
    # DISPATCH: Encodes the request and sends it to the OCaml side.
    # Tracks the 'from' PID using a unique reference for the reply.
    ref = make_ref()
    request = %{ref: ref, action: :parse, format: format, content: content}
    Port.command(state.port, :erlang.term_to_binary(request))
    {:noreply, %{state | pending: Map.put(state.pending, ref, from)}}
  end

  @impl true
  def handle_info({port, {:data, data}}, %{port: port} = state) do
    # INGEST: Decodes the ETF response and routes it back to the original caller.
    response = :erlang.binary_to_term(data)
    case Map.pop(state.pending, response.ref) do
      {from, pending} -> 
        GenServer.reply(from, response.result)
        {:noreply, %{state | pending: pending}}
      _ -> {:noreply, state}
    end
  end
end
