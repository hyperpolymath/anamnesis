;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — anamnesis

(ecosystem
  (version "1.0.0")
  (name "anamnesis")
  (type "project")
  (purpose "*A conversation knowledge extraction and reconciliation system for multi-LLM development workflows.*")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "*A conversation knowledge extraction and reconciliation system for multi-LLM development workflows.*")
  (what-this-is-not "- NOT exempt from RSR compliance"))
