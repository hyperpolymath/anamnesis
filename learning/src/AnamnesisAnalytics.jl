# SPDX-License-Identifier: PMPL-1.0-or-later
# Copyright (c) 2026 Jonathan D.A. Jewell (hyperpolymath) <jonathan.jewell@open.ac.uk>

/**
 * AnamnesisAnalytics — Semantic Inference and Graph Analysis Engine.
 *
 * This module provides the analytical backbone for the Anamnesis project.
 * It integrates RDF triple processing, graph-based knowledge mapping, 
 * and Echo State Networks (ESN) for temporal pattern prediction.
 *
 * PIPELINE:
 * 1. CAPTURE: Ingest natural language conversations.
 * 2. SEMANTICS: Convert text to RDF triples using the `Serd` bridge.
 * 3. KNOWLEDGE GRAPH: Map triples into a `MetaGraph` for structural analysis.
 * 4. PREDICTION: Train Reservoir Computing models to predict future trends.
 */

module AnamnesisAnalytics

using Serd
using HTTP
using JSON
using Graphs
using MetaGraphs
using ReservoirComputing
using Flux
using SparseArrays
using LinearAlgebra

# --- KNOWLEDGE REPRESENTATION (RDF) ---
include("rdf/schema.jl")        # Semantic ontology definitions
include("rdf/serialization.jl") # Turtle/JSON-LD export logic
include("rdf/sparql.jl")        # Query interface for triple stores
include("rdf/virtuoso.jl")      # High-performance DB integration

# --- STRUCTURAL ANALYSIS (Graphs) ---
include("graphs/conversion.jl") # RDF -> Graph mapping
include("graphs/analysis.jl")   # Centrality, pathfinding, clustering

# --- TEMPORAL PREDICTION (AI) ---
include("reservoir/esn.jl")         # Echo State Network implementation
include("reservoir/embeddings.jl")  # Semantic vector spaces

# --- SYSTEM INTEGRATION ---
include("port_interface.jl") # Integration with Elixir/Ephapax via Ports

# PUBLIC API: Expose primary analytical functions.
export conversation_to_rdf
export execute_sparql
export virtuoso_insert
export rdf_to_metagraph
export train_conversation_predictor

end # module
