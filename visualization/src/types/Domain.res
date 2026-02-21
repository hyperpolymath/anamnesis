// Anamnesis Domain Types (ReScript)
//
// This module defines the core graph-based data structures for the 
// Anamnesis visualization system. It uses 'Phantom Types' to enforce 
// strict separation between different identifier types.

// PHANTOM IDS: Wrappers that prevent accidental assignment between different ID types.
type messageId = MessageId(string)
type artifactId = ArtifactId(string)
type conversationId = ConversationId(string)

// NODE TYPES: Distinguishes between linguistic units (Messages) 
// and created entities (Artifacts).
type nodeId =
  | MessageNode(messageId)
  | ArtifactNode(artifactId)

// EDGE SEMANTICS: Defines the relationship between graph nodes.
type edgeType =
  | Contains    // Hierarchical inclusion
  | References  // Cross-node mention
  | CreatedIn   // Temporal origin
  | ModifiedIn  // State transition
  | Evaluates   // Meta-analysis connection

// ANALYTICAL METADATA: Tracks project context and membership strength.
type projectMembership = {
  projectId: string,
  strength: float,  // Fuzzy confidence score (0.0 to 1.0)
}

// GRAPH STRUCTURE: The primary representation of an extracted conversation.
type graph = {
  nodes: array<node>,
  edges: array<edge>,
}
