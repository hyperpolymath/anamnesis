# Anamnesis RDF Schema — Ontological Vocabulary.
#
# This Julia module defines the authoritative URIs and namespaces for the 
# Anamnesis knowledge graph. It provides a structured vocabulary for 
# describing conversations, their participants, and the artifacts 
# they produce.

module Schema

export ANAMNESIS, RDF, RDFS, XSD

# VOCABULARY HELPER: Simplifies URI generation using index notation.
struct Namespace
    base::String
end

Base.getindex(ns::Namespace, sym::Symbol) = string(ns.base, sym)

# STANDARD NAMESPACES: Canonical Semantic Web vocabularies.
const RDF  = Namespace("http://www.w3.org/1999/02/22-rdf-syntax-ns#")
const RDFS = Namespace("http://www.w3.org/2000/01/rdf-schema#")
const XSD  = Namespace("http://www.w3.org/2001/XMLSchema#")

# ANAMNESIS NAMESPACE: Domain-specific entities and properties.
const ANAMNESIS = Namespace("http://anamnesis.hyperpolymath.org/ns#")

# --- SEMANTIC CLASSES ---
const CONVERSATION    = ANAMNESIS[:Conversation]
const MESSAGE         = ANAMNESIS[:Message]
const ARTIFACT        = ANAMNESIS[:Artifact]
const LIFECYCLE_EVENT = ANAMNESIS[:LifecycleEvent]

# --- SEMANTIC PROPERTIES ---
const PART_OF    = ANAMNESIS[:partOf]    # Links Message/Artifact to Conversation.
const DISCUSSES  = ANAMNESIS[:discusses] # Links Conversation to Artifact.
const CONTENT    = ANAMNESIS[:content]   # The raw text of a message.
const TIMESTAMP  = ANAMNESIS[:timestamp] # XSD-formatted temporal marker.
const STATE_PROP = ANAMNESIS[:state]     # Current lifecycle status of an artifact.

end # module Schema
