defmodule Anamnesis.Pipelines.IngestionPipeline do
  @moduledoc """
  Ingestion Pipeline — Multi-Stage Semantic Transformation.

  This module orchestrates the end-to-end processing of conversation data. 
  It implements a "Chain of Responsibility" where raw text is iteratively 
  refined by specialized polyglot engines.

  ## Processing Stages:
  1. **PARSING**: Uses the OCaml `ParserPort` to transform raw text into 
     a structured conversation map.
  2. **REASONING**: Uses the λProlog `LambdaPrologPort` to infer semantic 
     relationships and identify project associations.
  3. **SERIALIZATION**: Uses the Julia `JuliaPort` to generate a set of 
     standard RDF triples from the conversation and inferences.
  4. **PERSISTENCE**: Commits the final triples to the `Virtuoso` triplestore.
  """

  use GenServer
  require Logger

  # CLIENT API: Public interface for triggering ingestion jobs.

  @doc """
  TRIGGERS ingestion for a physical file. 
  Uses a generous 120s timeout to allow for complex Julia/Prolog operations.
  """
  def ingest_file(file_path) do
    GenServer.call(__MODULE__, {:ingest_file, file_path}, 120_000)
  end

  # SERVER CALLBACKS: Pipeline execution logic.

  @impl true
  def handle_call({:ingest_file, file_path}, _from, state) do
    Logger.info("Starting ingestion: #{file_path}")

    # MONADIC CHAIN: Executes each stage sequentially. 
    # Failure in any stage halts the pipeline and returns the error.
    result = with \
      {:ok, content}      <- File.read(file_path),
      {:ok, conversation} <- parse_conversation(content),
      {:ok, inferences}   <- reason_about_conversation(conversation),
      {:ok, rdf}          <- generate_rdf(conversation, inferences),
      {:ok, _}            <- store_in_virtuoso(rdf)
    do
      {:ok, conversation["id"]}
    else
      {:error, reason} = error ->
        Logger.error("Pipeline failed at stage: #{inspect(reason)}")
        error
    end

    {:reply, result, state}
  end
end
