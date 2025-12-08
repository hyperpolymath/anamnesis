;;; STATE.scm - Anamnesis Project State
;;; Guile Scheme checkpoint/restore format for AI conversation continuity
;;; Format: https://github.com/hyperpolymath/state.scm

;;;============================================================================
;;; METADATA
;;;============================================================================

(define-module (state anamnesis)
  #:export (state metadata user-context session-context focus
            project-catalog history critical-next-actions))

(define metadata
  '((format-version . "2.0")
    (schema-date . "2025-12-08")
    (created . "2025-11-22")
    (last-updated . "2025-12-08")
    (generator . "claude/state-scm-system")))

;;;============================================================================
;;; USER CONTEXT
;;;============================================================================

(define user-context
  '((name . "hyperpolymath")
    (roles . ("researcher" "journalist" "developer"))
    (preferred-languages . ("Elixir" "OCaml" "Julia" "ReScript" "λProlog"))
    (forbidden-languages . ("Python"))  ; HARD CONSTRAINT
    (preferred-tools . ("Virtuoso" "SPARQL" "Guix" "Nix"))
    (documentation-format . "AsciiDoc")  ; LaTeX when needed
    (core-values . ("FOSS" "reproducibility" "type-safety"
                    "functional-paradigm" "academic-rigor"))
    (research-interests . ("agnotology" "neurosymbolic-AI" "epistemics"))))

;;;============================================================================
;;; SESSION CONTEXT
;;;============================================================================

(define session-context
  '((conversation-id . "claude/create-state-scm-01RLhm8FTxXVrq1k5G7hyQcv")
    (branch . "claude/create-state-scm-01RLhm8FTxXVrq1k5G7hyQcv")
    (messages-this-session . 0)
    (token-budget-status . "fresh")))

;;;============================================================================
;;; CURRENT FOCUS
;;;============================================================================

(define focus
  '((project . "anamnesis")
    (phase . "planning")
    (current-milestone . "research-and-setup")
    (deadline . #f)
    (blockers . ((research-needed . "Julia RDF libraries evaluation")
                 (research-needed . "Julia reservoir computing options (NOT ReservoirPy)")
                 (clarification-needed . "terminology for 'not knowing' vs agnotology")))))

;;;============================================================================
;;; PROJECT CATALOG
;;;============================================================================

(define project-catalog
  '(;; === ANAMNESIS (PRIMARY) ===
    (anamnesis
     (description . "Conversation knowledge extraction and reconciliation system")
     (problem-solved . "Mixed-project conversations, dead-end tangents, lost context in AI-assisted workflows")
     (status . in-progress)
     (completion-pct . 5)
     (category . "AI/knowledge-management")
     (phase . "planning")
     (repository . "https://github.com/Hyperpolymath/anamnesis")

     ;; Tech Stack
     (tech-stack . ((orchestration . "Elixir")
                    (parsing . "OCaml→Elixir bridge via ports/NIFs")
                    (knowledge-graph . "Virtuoso + SPARQL")
                    (learning . "Julia (KBANN, reservoir computing)")
                    (reasoning . "λProlog/Teyjus")
                    (visualization . "ReScript")))

     ;; Data Sources
     (data-sources
      (current . ("Claude" "Mistral" "ChatGPT" "LMArena" "Copilot"
                  "Genesis" "Edge-Phi3" "Firefox" "Chrome" "git-logs" "local-LLMs"))
      (future . ("WhatsApp" "LinkedIn")))

     ;; Architecture
     (architecture-principles . ("multi-category-membership"
                                 "episodic-memory-structure"
                                 "fuzzy-boundaries"
                                 "artifact-lifecycle-tracking"
                                 "cross-conversation-linking"))

     ;; Dependencies
     (dependencies . ("Virtuoso" "Teyjus" "Julia" "Elixir" "OCaml"))

     ;; Blockers
     (blockers . ((type . research)
                  (items . ("Julia RDF library selection"
                            "Julia reservoir computing library selection"
                            "PuppyGraph stack analysis"))))

     ;; Next Actions
     (next-actions . ("Research Julia RDF libraries (Semantic.jl, RDFLib.jl)"
                      "Research Julia reservoir computing (NOT Python)"
                      "Copy zotero-voyant-export to proving-ground/"
                      "Create maximal handover document"
                      "Setup project structure directories")))

    ;; === PROVING GROUND (TEST CASE) ===
    (proving-ground
     (description . "Test workspace using contaminated zotero-voyant-export repo")
     (status . pending)
     (completion-pct . 0)
     (category . "testing")
     (phase . "setup")
     (source-repo . "zotero-voyant-export")
     (contamination-type . "Anamnesis planning discussions mixed in")
     (handover-docs . ("docs/contamination-notice/ANAMNESIS_HANDOVER_MINIMAL.adoc"
                       "docs/contamination-notice/THREAD_CONTAMINATION_WARNING.adoc"))
     (strategy . "Copy entire repo, preserve original, store iterations")
     (blockers . ((type . dependency)
                  (on . "anamnesis research phase")))
     (next-actions . ("Clone zotero-voyant-export to proving-ground/")))

    ;; === RELATED PROJECTS ===
    (rescript-evangeliser
     (description . "ReScript learning and advocacy")
     (status . paused)
     (completion-pct . 10)
     (category . "education/tooling")
     (phase . "learning")
     (synergies . ("anamnesis visualization layer"))
     (blockers . ())
     (next-actions . ()))

    (zotero-nsai
     (description . "Neurosymbolic AI integration with Zotero")
     (status . paused)
     (completion-pct . 5)
     (category . "AI/research-tools")
     (phase . "exploration")
     (synergies . ("anamnesis knowledge graph"))
     (blockers . ())
     (next-actions . ()))

    (fogbinder
     (description . "Uncertainty-as-feature framework")
     (status . paused)
     (completion-pct . 5)
     (category . "AI/epistemics")
     (phase . "conceptual")
     (synergies . ("anamnesis fuzzy boundaries"))
     (blockers . ())
     (next-actions . ()))))

;;;============================================================================
;;; ROUTE TO MVP v1
;;;============================================================================

(define mvp-v1-roadmap
  '((goal . "Parse single Claude conversation JSON → Virtuoso RDF triples")

    (phase-1 "Research & Setup"
     ((status . in-progress)
      (completion-pct . 20)
      (tasks . (("Create Anamnesis repository" . complete)
                ("Create CLAUDE.md" . complete)
                ("Create STATE.scm" . in-progress)
                ("Research Julia RDF libraries" . pending)
                ("Research Julia reservoir computing" . pending)
                ("Analyze PuppyGraph stack" . pending)
                ("Research ReScript visualization ecosystem" . pending)
                ("Copy proving ground" . pending)
                ("Create maximal handover document" . pending)
                ("Setup project structure directories" . pending)))))

    (phase-2 "Parser Implementation"
     ((status . pending)
      (completion-pct . 0)
      (tasks . (("Design Claude JSON schema parser" . pending)
                ("Implement OCaml parser combinators" . pending)
                ("Create Elixir-OCaml bridge (ports/NIFs)" . pending)
                ("Parse conversation structure" . pending)
                ("Extract artifact references" . pending)
                ("Handle multi-turn context" . pending)))))

    (phase-3 "Knowledge Graph"
     ((status . pending)
      (completion-pct . 0)
      (tasks . (("Design RDF ontology for conversations" . pending)
                ("Setup Virtuoso instance" . pending)
                ("Implement Julia RDF manipulation" . pending)
                ("Create SPARQL query templates" . pending)
                ("Map parsed data to triples" . pending)))))

    (phase-4 "MVP Integration"
     ((status . pending)
      (completion-pct . 0)
      (tasks . (("End-to-end pipeline" . pending)
                ("Test with proving ground" . pending)
                ("Validate artifact lifecycle tracking" . pending)
                ("Document MVP capabilities" . pending)))))))

;;;============================================================================
;;; CURRENT ISSUES
;;;============================================================================

(define issues
  '((open
     ((id . 1)
      (type . research-blocker)
      (title . "Julia RDF library selection")
      (description . "Need to evaluate Semantic.jl, RDFLib.jl, and alternatives for RDF manipulation")
      (priority . high)
      (assigned . #f))

     ((id . 2)
      (type . research-blocker)
      (title . "Julia reservoir computing library")
      (description . "Need Julia-native reservoir computing - ReservoirPy is Python, FORBIDDEN")
      (priority . high)
      (assigned . #f))

     ((id . 3)
      (type . clarification)
      (title . "Epistemics terminology gap")
      (description . "Word for 'not knowing' distinct from agnotology (knowing wrong). Candidates: nescience, aporia, epistemic ignorance")
      (priority . low)
      (assigned . #f))

     ((id . 4)
      (type . design-decision)
      (title . "Multi-LLM abstraction layer")
      (description . "Design abstraction for multiple LLM conversation formats - stub complexity initially but architecture must support")
      (priority . medium)
      (assigned . #f))

     ((id . 5)
      (type . infrastructure)
      (title . "Development environment reproducibility")
      (description . "Setup Guix/Nix manifests for reproducible development across all stack components")
      (priority . medium)
      (assigned . #f)))

    (resolved . ())))

;;;============================================================================
;;; QUESTIONS FOR USER
;;;============================================================================

(define questions-pending
  '(((id . 1)
     (question . "Should I proceed with Julia RDF library research? Check Semantic.jl, RDFLib.jl availability and maturity?")
     (context . "Needed for Phase 1 completion")
     (priority . high))

    ((id . 2)
     (question . "Confirm: Julia reservoir computing research should exclude ALL Python dependencies, correct? Any Julia-native libraries you're aware of?")
     (context . "NO PYTHON constraint")
     (priority . high))

    ((id . 3)
     (question . "The epistemics terminology - was the word you mentioned 'nescience' (simple not-knowing) or something else?")
     (context . "Documentation accuracy")
     (priority . low))

    ((id . 4)
     (question . "For the proving ground: should I clone zotero-voyant-export now, or wait until parser design is further along?")
     (context . "Phase 1 task ordering")
     (priority . medium))

    ((id . 5)
     (question . "PuppyGraph analysis - is this for potential integration, or just competitive/architectural research?")
     (context . "Scope clarification")
     (priority . medium))))

;;;============================================================================
;;; LONG-TERM ROADMAP
;;;============================================================================

(define long-term-roadmap
  '((vision . "Complete conversation knowledge extraction and reconciliation system across all LLM sources")

    (milestones
     ((name . "MVP v1")
      (goal . "Parse single Claude conversation JSON → Virtuoso RDF triples")
      (status . in-progress)
      (estimated-completion . "TBD"))

     ((name . "MVP v2")
      (goal . "Multi-conversation linking, artifact lifecycle tracking")
      (status . future)
      (dependencies . ("MVP v1")))

     ((name . "v1.0")
      (goal . "Full multi-LLM support (Claude, Mistral, ChatGPT, Copilot)")
      (status . future)
      (dependencies . ("MVP v2")))

     ((name . "v1.5")
      (goal . "λProlog meta-reasoning integration")
      (status . future)
      (dependencies . ("v1.0")))

     ((name . "v2.0")
      (goal . "KBANN/reservoir computing for pattern recognition")
      (status . future)
      (dependencies . ("v1.5")))

     ((name . "v2.5")
      (goal . "ReScript visualization layer")
      (status . future)
      (dependencies . ("v2.0")))

     ((name . "v3.0")
      (goal . "Additional data sources (WhatsApp, LinkedIn, browser history)")
      (status . future)
      (dependencies . ("v2.5"))))

    (architectural-goals
     ("Multi-category membership for conversations spanning projects"
      "Episodic memory structure for temporal reasoning"
      "Fuzzy boundaries instead of rigid categorization"
      "Artifact lifecycle: created→modified→removed→evaluated"
      "Cross-conversation fragment linking"
      "Clean summaries bucketed by project/topic"))

    (research-integration
     ("Agnotology applications in knowledge graph"
      "Neurosymbolic AI via Zotero:NSAI synergy"
      "Uncertainty modeling via Fogbinder concepts"
      "Axiology for value-based filtering"))))

;;;============================================================================
;;; HISTORY / SNAPSHOTS
;;;============================================================================

(define history
  '((snapshots
     ((date . "2025-11-22")
      (event . "Repository created")
      (anamnesis-completion . 2)
      (notes . "Initial repo setup, CLAUDE.md created"))

     ((date . "2025-12-08")
      (event . "STATE.scm created")
      (anamnesis-completion . 5)
      (notes . "Checkpoint/restore system initialized, roadmap documented")))))

;;;============================================================================
;;; CRITICAL NEXT ACTIONS (Top 5 Prioritized)
;;;============================================================================

(define critical-next-actions
  '(((priority . 1)
     (action . "Research Julia RDF libraries")
     (details . "Evaluate Semantic.jl, RDFLib.jl - check maturity, Virtuoso compatibility")
     (deadline . #f)
     (blocker-for . "Phase 1 completion"))

    ((priority . 2)
     (action . "Research Julia reservoir computing")
     (details . "Find Julia-native alternatives to ReservoirPy - NO PYTHON")
     (deadline . #f)
     (blocker-for . "Phase 1 completion"))

    ((priority . 3)
     (action . "Clone proving ground")
     (details . "Copy zotero-voyant-export to proving-ground/ directory")
     (deadline . #f)
     (blocker-for . "Real-world testing"))

    ((priority . 4)
     (action . "Create maximal handover document")
     (details . "Necessary AND sufficient version of handover docs")
     (deadline . #f)
     (blocker-for . "Context preservation"))

    ((priority . 5)
     (action . "Setup project structure directories")
     (details . "Create parser/, orchestrator/, reasoning/, learning/, visualization/")
     (deadline . #f)
     (blocker-for . "Development start"))))

;;;============================================================================
;;; FILES MODIFIED THIS SESSION
;;;============================================================================

(define files-this-session
  '((created . ("STATE.scm"))
    (modified . ())
    (deleted . ())))

;;;============================================================================
;;; QUERY INTERFACE
;;;============================================================================

(define (get-current-focus)
  "Returns the current project focus"
  (assoc-ref focus 'project))

(define (get-blocked-projects)
  "Returns list of projects with blockers"
  (filter (lambda (p)
            (not (null? (assoc-ref (cdr p) 'blockers))))
          project-catalog))

(define (get-critical-next)
  "Returns top priority action"
  (car critical-next-actions))

(define (get-completion-pct project-name)
  "Returns completion percentage for a project"
  (let ((project (assoc project-name project-catalog)))
    (if project
        (assoc-ref (cdr project) 'completion-pct)
        #f)))

;;; END STATE.scm
