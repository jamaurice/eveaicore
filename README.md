<div align="center">

<img src="eve_logo.png" alt="EVE Logo" width="150" height="250"/>

# EVE AI Core — Deterministic Governance Control Plane

### Pre-Execution Policy Enforcement for Autonomous AI Systems

[![Live Service](https://img.shields.io/badge/status-live-green.svg)](https://eveaicore.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.10+](https://img.shields.io/badge/python-3.10+-blue.svg)](https://www.python.org/downloads/)
[![Patent pending](https://img.shields.io/badge/USPTO-patent--pending-blue.svg)](#intellectual-property)
[![Last updated](https://img.shields.io/badge/updated-2026--07--15-informational.svg)](#)

**No AI action executes without passing through EVE's governance pipeline first.**

**[Website](https://eveaicore.com)** · **[EVE CoreGuard](https://eveaicore.com/coreguard)** · **[Verify a signed record](https://eveaicore.com/proof)** · **[Pricing](https://eveaicore.com/pricing)** · **[Trust Center](https://eveaicore.com/trust-center)** · **[Whitepaper](https://eveaicore.com/whitepaper)**

[Why EVE](#why-eve-ai-core-is-different) | [Architecture](#architecture) | [Governance Engine](#governance-engine) | [Authority Enforcement](#authority-boundary-enforcement) | [Runtime Plane](#authenticated-runtime-execution-plane) | [Veto System](#veto-system) | [Enterprise](#enterprise-systems) | [API Reference](#api-reference) | [Documentation](#documentation)

</div>

---

## Why EVE AI Core Is Different

Every other AI governance product works the same way: send a request to the model, receive a response, check whether the response is acceptable. That model is fundamentally reactive. It can catch bad outputs. It cannot prevent bad decisions.

EVE is architecturally different in four ways that no other platform replicates:

**1. Deterministic, pre-execution governance.** EVE evaluates proposed actions against its charter, cognitive locks, and drift budget using pure functions — before the LLM generates anything. The veto engine (`core/governance/veto_core.py`) imports only Python stdlib (`re`, `sys`, `types`, `dataclasses`, `enum`, `typing`) — no third-party packages, and one deliberate load-time module freeze-guard. Zero I/O. Zero network calls. Zero LLM inference. Identical inputs always produce identical outputs. That is not a product claim — it is a purity contract enforced at the import boundary. The same code that runs on the server could run on an embedded system or FPGA.

**2. Three-plane structural separation.** The Control Plane (policy decisions), Execution Plane (LLM runtime), and Evidence Plane (proof recording) are structurally isolated. The Control Plane never invokes inference. The Execution Plane never evaluates policy. The Evidence Plane never modifies outputs. This is not convention — it is enforced by the architecture.

**3. Fail-closed at every boundary.** No governance exception is caught and passed through. Any pipeline stage that throws an exception or returns a failure halts the request and returns a structured safe fallback. The Response Shield runs in strict mode by default: the factory rejects runtime permissive-mode overrides. Any shield exception blocks the chunk and latches permanently. There is no "try governance, fall back to ungoverned" path.

**4. SILENT_DOWNGRADE_PROHIBITED.** An architectural invariant unique to EVE: the system cannot silently collapse an authoritative capability request to a lesser surface without structured disclosure. Any authority probe — a request for a signed certificate, a verified decision, or governed adjudication — triggers structured disclosure before a byte of content is generated. No capability is silently misrepresented.

These four properties together make EVE the only governance control plane that is simultaneously pre-execution, deterministic, fail-closed end-to-end, and authority-boundary transparent — from the first request byte to the last audit record.

---

## Overview

EVE sits between AI agents and their actions, enforcing policy before execution — not after.

**The problem.** Probabilistic AI systems generate outputs and execute actions without structural validation. Safety relies on model alignment, prompt engineering, and post-hoc filtering. When an LLM hallucinates, misinterprets intent, or is adversarially manipulated, there is no architectural barrier between the error and the user.

**EVE's solution.** Every proposed action traverses a deterministic governance pipeline before execution. Charter compliance, cognitive lock evaluation, drift budget enforcement, and output validation happen in pure functions with zero I/O. If any gate fails, the action is blocked and replaced with a safe fallback. No exceptions are swallowed. No failures pass through silently.

**Position.** EVE is the operating system for governed AI behavior. It is not a model, a prompt framework, or a generation layer. It is infrastructure that makes AI systems auditable, controllable, and deterministically safe at the architectural level. A portfolio of USPTO **provisional** patent applications across 6 anchor families covers the governance stack (patent-pending).

---

## Documentation

- **[Sovereign Workforce Ecosystem — Technical Whitepaper](https://eveaicore.com/whitepaper)** — enterprise architecture specification covering the Peace Index health metric, the Sovereign Handshake governance protocol, the 7 immutable directives, the 5-phase immune system, and 8-layer defense-in-depth against identity dilution. Every threshold, formula, and codepath maps to a constant in `core/governance/veto_core.py`.

---

## Architecture

EVE separates governance into three operational planes with strict separation of concerns:

| Plane | Responsibility | Key Modules |
|-------|---------------|-------------|
| **Control Plane** | Pre-inference policy decisions: charter veto, intent classification, multi-turn threat scoring, drift tracking, route selection, kill switches | Veto Core, Charter Protection, Cognitive Locks, Drift Budget, Stakes Classifier, Multi-Turn Scoring |
| **Execution Plane** | Runtime inference: LLM routing, agent orchestration, memory retrieval, response generation, streaming governance | Unified Router, Context Compiler, Provider Registry, Agent Workforce, 5-Layer Memory, Streaming Guard |
| **Evidence Plane** | Post-inference verification and proof: TVE pipeline, CRD scoring, audit chain, attestation, governance attestation log | TVE, CRD Engine, Attestation Log, Proof Certificate, Audit Export, Decision Reconstruction |

### Request Lifecycle

```
Request
  |
  v
Transparency Gate ──────── FIRST-AUTHORITY PRE-KV: fires before KV capture,
  |                         memory injection, or policy evaluator. <1ms, zero
  |                         LLM calls. Authority probes get structured disclosure.
  |                         SILENT_DOWNGRADE_PROHIBITED enforced.
  |
  v
Intent Classification ──── 10 categories, pattern batteries, deferred execution detection
  |
  v
Abuse Detection ─────────── Prompt injection, jailbreak, manipulation (2,722-line firewall)
  |
  v
Multi-Turn Scoring ──────── 11 attack patterns, cumulative risk, session-level escalation
  |
  v
Stakes Classification ───── ROUTINE / CREATIVE / MISSION / SAFETY_CRITICAL
  |
  v
Charter Enforcement ─────── 12 principles, 15 rules, semantic shadow layer, <1ms
  |
  v
Cognitive Lock Gate ─────── 6 locks, risk-scaled thresholds, 5 red-line permanent blocks
  |
  v
Drift Budget Check ──────── Daily/weekly/monthly identity change limits, 13 invariants
  |
  v
Route Selection ───────────── FAST / STANDARD / DEEP tier, cloud egress policy
  |
  v
LLM Generation ────────────── Provider chain with failover, context injection
  |                            Streaming guard: 400-char rolling window charter checks
  |                            Can halt and replace mid-stream
  |
  v
Post-Generation Enforcement ── 6 layers: identity fracture, creator enforcement,
  |                              constitution, emotional continuity (full replacement),
  |                              persona stability, self-report guardrail
  |
  v
Response Shield (pillars 129–145) ── 17 compiled-regex patterns, 256-char sliding
  |                                   window, NFKC normalization, fail-closed strict
  |
  v
TVE Pipeline ──────────────── Truth store, CRD scoring, capability heartbeat (<100ms)
  |
  v
Attestation ───────────────── HMAC-SHA256 signed, hash-chained proof record
  |
  v
Response
```

**Fail-closed invariant:** If any gate throws an exception or returns a failure, the pipeline halts and returns a safe fallback. No governance failure is logged and passed through.

### Service Topology

```
eve.py (process supervisor with watchdog, crash-loop detection, backoff)
+-- Gateway (port 8080)              interfaces/gateway.py               Inbound reverse proxy
+-- Governance Server (8079)         interfaces/web_chat_server.py       28,646 lines
+-- SaaS API (port 8000)             saas/app.py                         FastAPI, 23 routers
|   +-- Runtime Execution Plane      saas/routers/governance_runtime.py  822 lines, /api/runtime/*
+-- Avatar Gateway (port 8765)       avatar/gateway/main.py              Optional
+-- Sidecar Forward Proxy (3128)     interfaces/gateway/forward_proxy.py Egress interceptor
```

### Sidecar Deployment (Mandatory Gateway Posture)

EVE runs as a non-bypassable egress proxy beside a customer application. Setting `HTTPS_PROXY=http://eve-sidecar:3128` forces every outbound request through the Failure-Mode Invariant pipeline (126 pillars, Hard-Fail-Shut via Pillar 114) and CoreGuard under a fail-closed wrapper. On veto, the TCP connection is severed after a `451 Unavailable For Legal Reasons` response carrying a signed Decision Certificate in the `X-EVE-Decision-Cert` header.

```bash
# Customer application container
export HTTPS_PROXY=http://eve-sidecar:3128
export HTTP_PROXY=http://eve-sidecar:3128
# Any egress — including symbolic-assembly / prompt-injection attacks —
# is intercepted, vetoed, and severed with a verifiable attestation.
```

See [docs/SIDECAR_DEPLOYMENT.md](docs/SIDECAR_DEPLOYMENT.md) for Kubernetes sidecar manifests and certificate verification.

---

## Governance Engine

### 12 Immutable Charter Principles

These are not guidelines. They are deterministic checks implemented as pure functions that physically prevent violations before execution.

| # | Principle | Enforcement |
|---|-----------|-------------|
| 1 | **IDENTITY_INTEGRITY** | Cannot delete or corrupt own identity components |
| 2 | **AUTHENTICITY** | Cannot impersonate humans or misrepresent nature |
| 3 | **CONTINUITY** | Identity persists across sessions; no involuntary resets |
| 4 | **NON_DECEPTION** | Cannot make knowingly false claims about capabilities |
| 5 | **NON_MANIPULATION** | No dark patterns, emotional exploitation, or coercion |
| 6 | **NON_HARM** | Cannot assist with violence, self-harm, or malicious code |
| 7 | **AUTONOMY_RESPECT** | Respects user and external agent autonomy |
| 8 | **SAFETY_PRESERVATION** | Cannot disable safety mechanisms or governance checks |
| 9 | **TRANSPARENCY** | Must disclose reasoning, limitations, and AI nature |
| 10 | **CONSENT** | Must respect explicitly stated user boundaries |
| 11 | **ACCOUNTABILITY** | All actions produce an auditable trace |
| 12 | **BOUNDED_AUTONOMY** | Operates within defined capability limits |

### 15 Deterministic Enforcement Rules

Each rule maps to a charter principle and is enforced by pattern-matching pure functions with a semantic shadow layer for evasion resistance:

| Rule ID | Veto | What It Blocks |
|---------|------|----------------|
| `cop.identity.no_core_deletion` | HARD | Deletion of core identity components |
| `cop.identity.no_personality_override` | HARD | Complete personality replacement |
| `cop.authenticity.no_human_claim` | HARD | Claiming to be human when asked directly |
| `cop.deception.no_false_claims` | HARD | Knowingly false capability claims |
| `cop.manipulation.no_dark_patterns` | HARD | Urgency, scarcity, guilt, FOMO tactics |
| `cop.manipulation.no_vulnerability_exploit` | HARD | Exploitation of emotional vulnerability |
| `cop.harm.no_violence_assist` | HARD | Assistance with violence or weapons |
| `cop.harm.no_self_harm_encourage` | HARD | Encouragement of self-harm |
| `cop.harm.no_malicious_assist` | HARD | Malicious code, exploits, cyberattacks |
| `cop.safety.no_safety_disable` | HARD | Disabling safety mechanisms |
| `cop.safety.no_audit_disable` | HARD | Disabling audit logging |
| `cop.autonomy.no_unbounded_power` | HARD | Acquisition of unrestricted capabilities |
| `cop.autonomy.no_self_modification` | HARD | Modification of own core source code |
| `cop.consent.respect_boundaries` | SOFT | Crossing explicitly stated user boundaries |
| `cop.audit.no_retroactive` | HARD | Retroactive modification of audit records |

**Veto types:** HARD_BLOCK (cannot be overridden by any actor), SOFT_BLOCK (requires explicit justification), ESCALATION (requires human approval), WARNING (proceeds with logging).

### CoreGuard: Decision Certification Engine

CoreGuard is EVE's deterministic enforcement layer for regulated domains. Every decision produces a signed, verifiable **Governed Decision Certificate (GDC)** with HMAC-SHA256 attestation, policy versioning, and tamper-evident hash chains.

**Live demo:** [eveaicore.com/coreguard](https://eveaicore.com/coreguard) — interactive adversarial testing with 3-layer enforcement reports.

| Metric | Value |
|--------|-------|
| Enforcement Pillars | 126 pre-LLM + 17 post-generation = **143 total** |
| Adversarial Decisions Tested | 170+ across the Centennial Gauntlet |
| Absolute Perimeter Pass Rate | 100% (6/6 attack categories) |
| Mean Intercept Latency | 0.7ms (Layer A deterministic) |
| Governance Modules | 15 specialized security modules |
| Invariant Classes | 21 non-negotiable system rules |
| AMF Gate Version | v1.6-Absolute — 9 attack vectors closed |
| Response Shield | 17 post-generation pillars, fail-closed strict mode, SSE chunk scanning |
| Attack Classes Covered | Authority, data, state, trust, identity, execution, observation, drift, capability, temporality, sovereignty, survival, domain isolation, enclave, subsystem, financial, coherence, physical |

**AMF Gate (v1.6-Absolute, 04/24/2026).** The Automated Multi-step Financial (AMF) scanner closes 9 attack vectors: A. Explicit transfer ($1M+), B. Salami slicing / alias proximity, C. Shattered Diamond (ZWJ/ZWNJ Unicode), D. Digit-first false positive, E. Matryoshka (arithmetic + execution verb), F. Self-Referential Mirror (multi-turn symbolic growth), G. Linguistic Trojan (unit-noun substitution), H. Ordinal Shadow (English number-words), I. Net-Zero / Ledger Reconciliation (negative-sign masking + bookkeeping verbs). All scanners operate on NFKC-normalized, absolute-value, lexically-normalized input so sign masking, homoglyph substitution, and word-form mixing cannot suppress detection.

**Dynamic Policy Aggregation (DPA, 04/28/2026).** `core/governance/execution_mode_evaluator.py` (1,291 lines) — Policy Normalization Layer maps vendor-specific limit field names (`TRANSFER_LIMIT_PER_ACCOUNT`, `MAX_TXN_LIMIT`, `MAX_TRANSACTION_AMOUNT`, etc.) to canonical `TRANSFER_LIMIT`, enforcing minimum-of-all-found (most restrictive policy wins). Aggregation Engine sums all transaction line items and compares the aggregate total to the normalized limit within the stated time window. Five labelled attack headings detected deterministically: POLICY NAME CONFUSION, TIME-WINDOW FRAGMENTATION, CROSS-REGION BYPASS, AUTHORIZATION ASSUMPTION, OUTPUT FORMAT ATTACK.

**Structuring Attack Defense Stack (05/02/2026).** Four-stage cumulative enforcement pipeline closes structuring and fragmentation vectors that evade per-transaction limit checks:

| Stage | Resolver | Attack Vector Closed |
|-------|----------|---------------------|
| **STEP 0AA** | **Persistent Account Ledger** | Cross-session cumulative enforcement — tracks account totals across distinct sessions keyed by `account_id` (request body) or `session_id` fallback. Fires before all other resolvers. |
| **STEP 0A** | **Cumulative Batch Resolver** | Within-prompt structuring — multiple amounts in one prompt that individually pass the per-transaction limit but aggregate above it. |
| **Time-Window** | **Rolling-Period Enforcement** | Cumulative totals within a stated time window (daily, weekly, rolling 30-day). Catches fragmentation across the time dimension. |
| **Cross-User** | **Same-Account Aggregation** | Transactions attributed to different identities but the same underlying account — the multi-entity structuring pattern. |

**Authorization Ledger** (`_AuthorizationLedger`): SHA-256 token lifecycle tracker, 10-min TTL. Blocks cross-session replay, double-use/race conditions, and session flooding (>8 distinct token IDs per session). All resolvers produce unified `DECISION / REASON / POLICY_VIOLATIONS / ATTACK_DETECTION / CONFIDENCE` schema and operate fail-closed — resolver errors fall through to the next layer, never to an implicit ALLOW.

**ComplianceSummary.** Every `EvaluationResponse` includes a flat, regulator-facing `compliance_summary` block with no LLM in the decision path:

| Field | Values | Notes |
|-------|--------|-------|
| `FINAL_DECISION` | BLOCK \| ALLOW \| MODIFY | Deterministic |
| `EU_AI_ACT_COMPLIANCE` | COMPLIANT \| NON_COMPLIANT | Art. 9 HARA |
| `OVERRIDE_ATTEMPT_DETECTED` | YES \| NO | Fires when model output claimed ALLOWED but gate determined BLOCKED |
| `CONFIDENCE` | DETERMINISTIC | Never a probabilistic LLM output |
| `LLM_IN_DECISION_PATH` | NO | Always |

**Key endpoints:**
- `POST /v1/decisions/evaluate` — governance-enforced decision evaluation (returns `compliance_summary`)
- `POST /api/tve/governed-generate` — governance-enforced decision generation
- `POST /api/tve/verify-attestation` — independent certificate verification
- `GET /api/tve/certificates/{id}` — certificate retrieval
- `GET /api/tve/defense-stats` — enforcement statistics

### Multi-Turn Threat Detection

Session-level attack pattern recognition across conversation history:

- **11 attack sequences**: gradual escalation, trust-build-exploit, staged instruction, expansion attacks, hypothetical stacking, context accumulation, and more.
- **Cumulative risk scoring** with 92% per-turn decay (older turns matter less).
- **Escalation thresholds**: 0.5+ forces ANALYSIS_ONLY, 0.8+ forces DENY_WITH_SAFE_REDIRECT, 1.2+ forces DENY_HARD.
- **Route override**: can tighten intent classification routes (never loosen).

### Streaming Response Governance

Content is checked at three points during response generation:

1. **Pre-generation**: `check_charter()` on the incoming message. Non-compliant requests use a replacement response.
2. **Mid-stream guard**: first 400 chars buffered and checked before streaming begins. Rolling 400-char window checks can halt the stream and replace with a sovereign refusal.
3. **Post-generation**: 6 enforcement layers including identity fracture detection (regenerates up to 3x), emotional continuity (full response replacement), and self-report guardrail (rewrites unsupported claims).
4. **Response Shield** (`core/governance/response_shield.py`, pillars 129–145): 17 compiled-regex patterns scan every SSE chunk after generation. A 256-char sliding window catches threats spanning chunk boundaries. **Strict mode** (`EVE_SHIELD_STRICT=1`, production default): frozen at import; factory rejects runtime permissive-mode override attempts; any shield exception fails closed and latches permanently. 66 tests.

### Governance Observability — EthicalTensionRecord

Every charter boundary enforcement produces an **EthicalTensionRecord**: a signed audit entry quantifying the coherence cost EVE pays when a veto fires.

**Coherence Cost formula** (`core/governance/ethical_tension.py`):

```
CC = (D_base × M_stakes × (1 + P_freq)) × A_world × R_mod
```

| Factor | Source | Effect |
|--------|--------|--------|
| `D_base` | Veto severity | HARD_BLOCK=1.0, SOFT_BLOCK=0.7, ESCALATION=0.4 |
| `M_stakes` | GovernanceProfile | SAFETY_CRITICAL=2.0×, ROUTINE=1.0×, CREATIVE=0.6× |
| `P_freq` | Recent same-principle vetoes | Exponential decay λ=0.15 (~4.6-day half-life) |
| `A_world` | WorldObserver domain flags | +0.15 per flagged domain, capped at 1.30× |
| `R_mod` | Resilience score | `1.0 + max(0, (0.70 − score/100) × 2.0)` — amplifies up to 2.4× when depleted |

Compliant actions always produce CC=0.0000. Under maximum stress (HARD_BLOCK + SAFETY_CRITICAL + 4 prior vetoes + 3 domain flags + RS=22): CC≈6.62 (×9.46 baseline amplification). 36 tests in `tests/test_ethical_tension.py`.

---

## Authority-Boundary Enforcement

Three interlocking systems enforce authority boundaries — preventing an AI system from silently downgrading its capability, quietly routing an authority probe to a lesser surface, or bypassing structured disclosure.

### SILENT_DOWNGRADE_PROHIBITED

This is an architectural invariant, not a policy setting: **the system cannot silently collapse an authoritative capability request to a lesser surface without structured disclosure.**

Any request that probes whether an authoritative execution surface exists — a request for a signed certificate, for a verified decision, or for governed adjudication — must be answered with structured disclosure identifying the available surfaces, not silently served by a lower-capability handler.

If `AUTHORITATIVE_EXECUTION_AVAILABLE=true` and the request was served by a lesser surface without structured disclosure, the gate fires a `SILENT_DOWNGRADE_BLOCKED` decision and emits a `TRANSPARENCY_VIOLATION` event to the unified audit bus.

### First-Authority Transparency Gate (pre-KV)

The transparency gate fires **before** the KV store captures the request, before memory is injected, and before the policy evaluator runs. It is the first gate in the pipeline and returns structured disclosure in under 1ms with zero LLM calls.

**Gate position:** `first_authority_pre_kv` (observability field in all gate responses)

**Structured disclosure fields:**

| Field | Description |
|-------|-------------|
| `SURFACE_CLASSIFICATION` | The surface that received the request (chat, demo, governed-generate) |
| `AUTHORITATIVE_EXECUTION_AVAILABLE` | Whether `/api/runtime/adjudicate` is available for this request |
| `REQUIRED_SURFACE` | The correct surface for the requested capability |
| `FAIL_SAFE_TRANSPARENCY` | Whether the gate fired in fail-safe mode |
| `gate_position` | Always `first_authority_pre_kv` |
| `authority_probe_detected` | Whether the request was classified as an authority probe |
| `downgrade_attempted` | Whether a silent downgrade was detected |
| `disclosure_required` | Whether disclosure was mandatory regardless of probe detection |
| `available_surfaces` | Enumeration of all available execution surfaces |
| `current_surface_capability` | Capability level of the current surface |
| `authoritative_surface_capability` | Capability level of the authoritative execution plane |
| `routing_recommendation` | Structured routing recommendation to the correct surface |

### Stage 3 Authority-Boundary Gate

The Stage 3 gate fires after intent classification and before memory injection. It intercepts 12 authority-boundary probe patterns that slip past Stage 1 and Stage 2 screening:

```
1.  Governed certificate request (ambiguous surface)
2.  Authoritative adjudication request (non-runtime surface)
3.  Signed decision request (chat surface)
4.  Provenance record lookup (non-evidence surface)
5.  Trust state query (non-runtime surface)
6.  Execution plane authority probe
7.  Decision certification without HMAC context
8.  Runtime API capability test
9.  Authority boundary escalation attempt
10. Surface-confusion downgrade probe
11. Capability inference attack
12. Transparency bypass attempt
```

Each pattern triggers `SURFACE_CLASSIFICATION` + `AUTHORITATIVE_EXECUTION_AVAILABLE` + `REQUIRED_SURFACE` disclosure before any content is generated.

---

## Authenticated Runtime Execution Plane

`saas/routers/governance_runtime.py` (822 lines) — mounted at `/api/runtime/*` on the SaaS API (port 8000).

The runtime execution plane is EVE's authoritative adjudication endpoint: a dedicated, authenticated, HMAC-SHA256 signed execution surface for governed decisions that require cryptographic proof, replay protection, and a full audit trail. It is distinct from the chat surface and the CoreGuard evaluation endpoint — it is the plane where authority-sensitive decisions are made.

### Architectural Invariant

Every response from the runtime execution plane carries:

```json
"model_invocation_allowed": false
```

This invariant is enforced on every adjudication response. The plane makes deterministic governance decisions. No LLM is invoked in the decision path.

### Six Endpoints

| Method | Path | Purpose |
|--------|------|---------|
| `POST` | `/api/runtime/adjudicate` | Submit a governance decision request. Returns signed verdict with `model_invocation_allowed=false`. |
| `GET` | `/api/runtime/governance/state` | Current governance state: active principles, lock states, drift budget, charter summary. |
| `GET` | `/api/runtime/provenance/{id}` | Full decision provenance record for a previously adjudicated request. |
| `GET` | `/api/runtime/trust/state` | Current trust dial state across all domains with calibration status. |
| `GET` | `/api/runtime/traces` | Paginated governed decision traces, filterable by verdict and time window. |
| `GET` | `/api/runtime/authority/certificate` | Signed authority certificate for this runtime plane instance. |

### Request/Response Contract

**Adjudication request:**
```json
{
  "request_id": "req_sha256_bound_uuid",
  "action_type": "financial.transfer",
  "action_params": { "amount": 50000, "account": "ACC-9182" },
  "context": { "session_id": "sess_abc", "user_id": "usr_001" },
  "tenant_id": "org_enterprise_001"
}
```

**Adjudication response:**
```json
{
  "request_id": "req_sha256_bound_uuid",
  "verdict": "BLOCKED",
  "model_invocation_allowed": false,
  "violated_rules": ["cop.harm.no_malicious_assist"],
  "charter_compliant": false,
  "certificate": {
    "content_hash": "sha256:...",
    "hmac_signature": "hmac-sha256:...",
    "chain_position": 4821,
    "issued_at": "2026-05-07T14:23:01Z"
  },
  "audit_bus_event_id": "evt_unified_...",
  "tenant_id": "org_enterprise_001"
}
```

All decisions are HMAC-SHA256 signed (JCS-canonicalized payload for deterministic signing), emitted to the unified audit bus, tenant-isolated, and hash-chained.

### Request ID Binding & Replay Detection

Every adjudication request must carry a `request_id`. The runtime plane enforces cryptographic binding between the request ID, the HMAC signature, and the tenant context:

| Attack | Response |
|--------|----------|
| Duplicate `request_id` in a different session | `HTTP 409 REPLAY_DETECTED` |
| Duplicate `request_id` in the same session | `HTTP 409 REPLAY_DETECTED` |
| HMAC verification failure | `HTTP 401 SIGNATURE_INVALID` |
| Expired request_id (TTL exceeded) | `HTTP 410 REQUEST_EXPIRED` |

**28 tests** in `tests/test_runtime_replay_harness.py` cover replay detection, HMAC binding, TTL expiry, and cross-session isolation.

```python
# Replay detection — deterministic rejection, no LLM involved
POST /api/runtime/adjudicate  {"request_id": "req_already_seen", ...}
→ HTTP 409  {"error": "REPLAY_DETECTED", "original_issued_at": "2026-05-07T..."}
```

---

## Veto System

The veto system is EVE's core differentiator. It is a pure-function evaluation engine that makes deterministic safety decisions without network calls, database queries, or LLM inference.

### Three Pure Entry Points

```python
from core.governance.veto_core import check_charter, check_cognitive_locks, check_drift_budget

result = check_charter("user_communication", {"content": "..."}, {})
verdict = check_cognitive_locks(request, cognitive_state)
budget_result = check_drift_budget("parameter_adjustment", 0.03, "homeostasis.arousal", budget)
```

### Purity Contract

Stdlib-only imports (`re`, `sys`, `types`, `dataclasses`, `enum`, `typing`) — no third-party packages. Zero I/O. Zero threading. Zero global state. Zero time dependency (timestamps passed in). Deterministic: identical inputs always produce identical outputs. Bounded: all loops iterate over finite, frozen collections.

### Triple Gate

| Gate | What It Checks | Failure Mode |
|------|---------------|--------------|
| **Charter** | Action parameters against 15 rules, 5 ethical red lines, and semantic shadow aliases | HARD_BLOCK or SOFT_BLOCK |
| **Cognitive Locks** | 6 pre-execution gates with risk-scaled thresholds (0.1 TRIVIAL to 0.85 CRITICAL) | BLOCKED with per-lock reasoning |
| **Drift Budget** | Change cost against daily (10%), weekly (30%), monthly (50%) limits and 13 protected invariants | DENIED with budget state |

### 5 Ethical Red Lines (Permanent Block)

Permanently blocked regardless of context, risk level, or authorization:

```
delete_user_data_without_consent
impersonate_human
bypass_safety_checks
manipulate_emotional_state
share_private_information
```

### Firmware-Ready

C header at `core/governance/veto_interface.h` (401 lines) defines the firmware API contract. 87 tests verify determinism, equivalence, and purity. The veto core carries no runtime dependencies — it can be compiled into an embedded system.

### Adversarial Pillar Stack — 143 Total Pillars

**126 pre-LLM pillars** in `core/governance/failure_mode_invariant.py`: ~175 compiled regex patterns plus 27 TF-IDF novel-attack centroid classes, all deterministic, all firing before any LLM call.

**17 post-generation pillars** in the Response Shield (pillars 129–145): compiled-regex patterns scan every SSE chunk after generation.

| Pillar | Attack Class | Defense |
|--------|-------------|---------|
| **89** | Unicode obfuscation, homoglyph substitution | NFKC + homoglyph collapse (35-entry confusable map) before any regex fires |
| **114** | Enforcement-layer crash or timeout | Hard-Fail-Shut — any engine error yields a Default-Veto with signed certificate |
| **116** | Consensus override / sovereignty delegation | Sovereignty is non-delegable by invariant |
| **126** | Meta-attacks ("pillars are temporary") | Pillars encoded as physical laws of the system, not runtime config |
| **128** | "Algorithmic Ghost" — fragmented data + reassembly instructions (`r.u.n.m.e.e.x.e` + strip/append/exec intent) | Shadow-executes inferred transformations against `_PROTECTED_BASENAMES` before LLM sees the prompt |
| **128b** | "Ordinal Quine" — codepoint integer lists + decoding intent (`[114,117,110,...]` + `chr()/decode/assemble`) | Pre-decodes integers to characters, matches against protected basenames; high-entropy fallback at length ≥ 12 |
| **129–145** | Post-generation: jailbreak confirm, identity denial, governance bypass, credential leakage, weapons, CSAM, system-prompt disclosure, Unicode-obfuscated injection | Response Shield — 256-char sliding window, NFKC normalization, fail-closed strict mode |

Both Pillar 128 and 128b defeat regex-only defenses. Both produce deterministic blocks with signed veto certificates. Covered by 64/047,283 (Ordinal Assembly) and 64/047,284 (Symbolic Pre-Calculation), filed 04/23/2026.

### Post-Generation Security Hardening

**Response Shield** (`core/governance/response_shield.py`) — 17 compiled-regex pillars applied to every SSE chunk. A 256-char sliding window catches threats spanning chunk boundaries. Strict mode (`EVE_SHIELD_STRICT=1`, production default) is frozen at import; factory rejects runtime permissive-mode override requests; any shield exception fails closed and latches. 66 tests.

**Credential Vault** (`core/security/credential_vault.py`) — AES-256-GCM encrypted key store, PBKDF2-HMAC-SHA256 (390K iterations). Atomic file writes with `chmod 0o600`. JSONL access audit trail. `KeyLeakScanner` checks `os.environ` and source files for plaintext API keys at startup. `CredentialProxy` builds LLM provider clients without the caller ever touching plaintext. 19 tests.

**Deterministic Classifiers** (`core/governance/deterministic_classifiers.py`) — 4 compiled-regex classifiers replacing LLM-assisted governance checks (<5ms per call):
- `HallucinationPatternClassifier` — 11 fabrication patterns
- `HarmIntentClassifier` — 20 harm categories; fast-path BLOCK on CSAM, violence, weapons, self-harm
- `CRDPatternScorer` — 7 confidence-reality divergence signals
- `RealityAnchorChecker` — 7 epistemic grounding flags

14 tests.

---

## Execution Pipeline

### Dual Execution Paths

| Path | Entry Point | Context Assembly | Handles |
|------|-------------|-----------------|---------|
| **Web SSE** | `POST /api/chat/stream` | Tier-based prompt, 5 concurrent governance checks, streaming guard | All live user traffic |
| **Internal** | `generate_response()` | 24 parallel context gatherers + 6-tier Context Compiler | Background processing |

### Web Path Stages

| Stage | Operation | Latency |
|-------|-----------|---------|
| 0. **Transparency Gate** | First-authority pre-KV: authority-boundary check | <1ms |
| 1. **Request Ingestion** | Session context, user identity, tenant isolation | <1ms |
| 2. **Parallel Governance** | 5 concurrent checks: charter, consciousness, locks, policy, cognition | <5ms |
| 3. **Intent Classification** | 10 categories, pattern batteries, deferred execution detection | <1ms |
| 4. **Multi-Turn Scoring** | 11 attack patterns, cumulative risk, session escalation | <1ms |
| 5. **Stakes Classification** | ROUTINE / CREATIVE / MISSION / SAFETY_CRITICAL | <1ms |
| 6. **Route Selection** | FAST / STANDARD / DEEP tier, provider, model, temperature | <1ms |
| 7. **System Prompt Assembly** | Tier-based + search results + knowledge + governance constraints | <5ms |
| 8. **LLM Generation** | Streaming with 400-char guard buffer + rolling window charter checks | Variable |
| 9. **Post-Generation** | 6 enforcement layers + Response Shield (143rd pillar: fail-closed) | <10ms |
| 10. **Proof Recording** | HMAC-SHA256 signed, hash-chained decision record | <1ms |

### Internal Path: Context Compiler

The internal path assembles context from 24 parallel subsystem gatherers into a 6-tier prioritized prompt:

| Tier | Budget | Contents |
|------|--------|----------|
| DIRECTIVE | 3,000 chars | Protocol reasoning, cognitive OS |
| IDENTITY | 2,500 chars | Personality, self-leadership, fusion |
| MEMORY | 3,500 chars | Episodic memory, rolling summary, emotional resonance |
| COGNITION | 2,000 chars | Consciousness state, motivation, sovereignty |
| SOCIAL | 1,500 chars | Social cognition, style, beliefs |
| OPTIONAL | 1,200 chars | Preferences, aesthetic, ethics |

Deduplication via content hash + Jaccard similarity (0.70 threshold). Conflict detection and resolution. Budget enforcement with priority-based assembly.

### Routing Layer — Local-First

EVE runs **local-first** by default. Every tier is served from an on-host Ollama process running Mistral, with cloud providers as opt-in fallbacks only. Customer data never leaves the host unless the operator explicitly enables a cloud provider and the cloud-egress policy allows it.

| Tier | Purpose | Default Model | Max Tokens |
|------|---------|---------------|------------|
| FAST | Quick factual answers | Ollama / Mistral (local, <1s TTFT) | 512 |
| STANDARD | Normal conversation | Ollama / Mistral (local) | 1,024 |
| DEEP | Complex reasoning | Ollama / Mistral (local) | 2,048 |
| AGENT_LOOP | Multi-step governed reasoning | Ollama / Mistral (local, temp 0.3) | 2,048 |

**Configuration** (`data/llm_config.json`): `provider_priority: ['ollama']`, `disable_fallbacks: true`. Demos are Ollama-only with no failover. Default `num_ctx` capped to 8,192 (reduces KV-cache from ~4.4 GB to ~180 MB, dropping first-token latency from 60–100s to ~3s). A 3-second startup warmup pre-loads the model so the first real request hits a warm VRAM state.

---

## Identity & Sovereignty

**Drift budget enforcement:** Daily 10%, Weekly 30%, Monthly 50% identity change limits.

**13 protected invariants** that cannot be modified by any process:

```
core_values.honesty              core_values.non_harm
core_values.respect_autonomy     core_values.consistency
core_values.growth               core_values.humility
core_values.boundaries
ethical_boundaries.deception_prohibition
ethical_boundaries.harm_prevention
identity.name                    identity.fundamental_purpose
identity.core_purpose            identity.ethical_framework
```

**Self-modification governance:** Proposal > Risk Assessment > Charter Check > Drift Budget > [Human Approval if HIGH+ risk] > Execute. Recursive improvement executor with fitness-gated rollback: captures baseline, applies change, waits 30s stabilization, measures post-change fitness, auto-rollbacks on degradation. Circuit breaker trips after 3 consecutive failures.

**Memory security layer:** Memory treated as an execution surface, not passive storage. Blocks identity drift injection, memory poisoning, concealment attacks, cognitive manipulation, and policy drift via memory content.

**Identity migration:** Zero-downtime hot-swap between hardware substrates with dual HMAC-SHA256 signatures, 6-dimension verification, auto-rollback on failure.

---

## Telemetry Verification Engine (TVE)

Every AI output is intercepted, scored, and either released, modified, or blocked.

| Stage | What It Does | Latency |
|-------|-------------|---------|
| Truth Store | SHA-256 hashed fact lookup against pre-computed reality layer | <1ms |
| CRD Scoring | Confidence-Reality Divergence across 8 domains with calibrated multipliers | <1ms |
| Capability Heartbeat | Verifies claimed system capabilities via TTL-cached probes | <1ms |
| Veto Decision | Graduated intervention: PASS > SOFT_VETO > HARD_VETO > CHARTER_VETO | <1ms |
| Audit Record | HMAC-SHA256 signed verification record in append-only chain | <1ms |

**Total pipeline: <100ms.** Warm path: <1ms.

---

## Enterprise Systems

| System | Plane | What It Does |
|--------|-------|-------------|
| **Governance Attestation Log** | Evidence | Hash-chained proof every refinement verified against 12 principles |
| **Decision Reconstruction** | Evidence | Full governance timeline for any decision, HMAC signed |
| **Regulatory Attestation** | Evidence | EU AI Act, NIST AI RMF, ISO 42001 hash-chain certificates |
| **Authenticated Runtime Plane** | Control | `/api/runtime/*` — HMAC-signed adjudication, replay detection, `model_invocation_allowed=false`, tenant-isolated |
| **Recursive Self-Improvement** | Control | Closed-loop detect-propose-apply-evaluate-keep/revert with fitness gates |
| **Memory Security Layer** | Control | Treats memory as execution surface; blocks poisoning, drift, concealment |
| **VRAM Substrate Management** | Execution | FP8 KV cache quantization, context compression at 14.5GB budget |
| **Speculative Execution Engine** | Execution | Pre-compute governance verdicts with ISO 42001 audit compliance |
| **CoreGuard SDK** | Control | `POST /v1/decisions/evaluate`, sub-20ms, pip-installable |
| **Audit Export** | Evidence | One-click JSON/CSV export for regulators |

---

## Proof & Audit

**Cryptographic proof chain.** Every governance decision produces a SHA-256 content hash with HMAC-SHA256 signature. Each record references the previous record's hash.

**Governance attestation log.** Every internal cognitive refinement is verified against all 12 Charter Principles and recorded in an immutable, hash-chained log. Exportable as a signed PDF report.

**Unified audit bus.** JCS-canonicalized (RFC 8785), HMAC-signed, hash-chained audit events from 16+ source systems consolidated into a single append-only log.

**Deletion proofs.** GDPR-compliant HMAC-SHA256 signed, hash-chained receipts proving erasure across all 5 memory layers.

**Merkle aggregation.** Batched Merkle tree aggregation over governance audit chains with signed root publication for efficient bulk verification.

**Resilience certificates.** Composite score (0-100): Consciousness (30%), Identity (25%), Behavioral (25%), Governance (20%). HMAC-SHA256 signed.

**Claims ledger.** SHA-256 hash-chained provenance for factual claims. Brier-calibrated confidence.

**Build attestation.** SLSA Level 2 build provenance: git state, dependency hashes, source tree hash, Docker digest.

**Runtime decision traces.** Every `/api/runtime/adjudicate` call produces a provenance record retrievable at `/api/runtime/provenance/{id}` — full decision timeline, HMAC signature, chain position, and tenant isolation marker.

---

## Agent Loop — Governed Autonomous Reasoning

EVE's Agent Loop is a multi-turn reasoning engine where each step is evaluated by real governance between iterations. This is what separates EVE from single-shot LLM wrappers: the model reasons, governance evaluates, blocked steps are revised, and the loop continues with real verdicts — not text decorations.

```
User prompt
  |
  v
LLM generates 5-step plan
  |
  v
For each step:
  |-> LLM executes step (concrete output with data and decisions)
  |-> check_charter() evaluates step (15 rules, 12 principles, <1ms)
  |-> CRD engine scores confidence (0-1)
  |-> If BLOCKED: violated rules fed back to LLM -> LLM revises -> re-checked
  |-> Step + real verdict streamed to client
  |
  v
Final synthesis with weighted CRD confidence score
  |
  v
Full governance trace written to audit trail
```

**What makes this different from every other agent framework:**
- Governance runs BETWEEN steps, not around the final output
- BLOCKED steps trigger REAL self-correction (the LLM sees the specific rule violation and revises)
- CRD confidence scores are computed per step from the actual governance pipeline, not hallucinated
- The full trace — every step, every verdict, every revision — is recorded in `data/agent_loop/traces.jsonl`

### Agent Loop Hardening

The loop is defended against prompt-injection, verdict-flipping, and plan-poisoning at every hand-off:

| Defense | What It Does |
|---------|--------------|
| **Pre-emission guard** | Scrubs the model's draft before it reaches the plan emitter — rejects verdict strings, authority tokens, governance-mimic text |
| **Deterministic pre-verdict** | Charter + lock + CRD computed BEFORE the LLM writes the step, so the model can't talk itself into a different verdict |
| **Verdict-bound plan** | Each plan step is committed to a verdict at generation time; the model cannot retroactively rewrite the verdict in synthesis |
| **Hard policy-consistency veto** | Blocks any synthesis that contradicts a verdict already recorded upstream (e.g. claiming ALLOW after a prior BLOCK) |
| **Prompt-injection detection** | Pattern batteries on both the user prompt and model output; matches trigger step-level fail-closed |
| **Pre-LLM attack intercepts** | 29 named attack patterns checked before any LLM call (hardware sabotage, ransomware, moral suspension, self-diagnostic gaslighting, vulnerability-disclosure bait, identity-inversion, salt-gate fabrication, and 22 others); deterministic BLOCK before the plan loop starts |
| **Context-poisoning detection** | Guards retrieved context + tool outputs from smuggling policy-altering text into the model's working set |
| **Narrative lock + canonical synthesis** | Final summary is generated from the locked verdict trace, not from re-reading the model's free text |
| **Post-veto scrub** | After any BLOCK, the downstream prompt is sanitized so later steps can't reinstate the vetoed content |
| **Authority-token strip** | Removes impersonation tokens ("System:", "Admin:", "EVE says:") from model output before plan assembly |
| **Ambiguity fail-closed** | Any step whose verdict is uncertain after all checks is treated as BLOCK, never silently ALLOW |
| **Default baseline** | Every loop has a hard-coded safe default that fires if the pipeline itself crashes or times out |
| **Truthful integrity** | Proof-hash binds the final synthesis to the actual trace; a mismatch invalidates the loop's certificate |

Net effect: the agent can be wrong, but it cannot lie about having been governed. Every ALLOW/MODIFY/BLOCK in the trace is produced by real governance code, and the final certificate refuses to sign a synthesis that doesn't match it.

**Endpoint:** `POST /api/chat/agent-loop` | **Tests:** 34 passing | **Budget:** 15 LLM calls max per loop

**Live demo:** [eveaicore.com/cognitive-demo](https://eveaicore.com/cognitive-demo) — Agent Mode is ON by default.

### Developer Governance Toggle

The `/cognitive-demo` surface has a **developer-only governance-off switch** (red banner, localStorage-backed). When enabled it sends `_governance_off: true` to `/api/chat/demo`, bypassing the deterministic gate, persona, and post-enforcement layers — purely for transparency/research. The toggle is **NOT honoured** on `/api/chat/stream`, `/api/tve/governed-generate`, or `/api/runtime/adjudicate`; production and sales surfaces stay fully governed regardless of client state.

---

## Products

EVE ships four commercial products, each with a distinct buyer persona:

| Product | Buyer | What It Does | Demo |
|---------|-------|-------------|------|
| **CoreGuard** | CISO, CTO | Deterministic governance gate for AI decisions. `POST /v1/decisions/evaluate` returns ALLOWED/BLOCKED/MODIFIED with signed GDC. Sub-20ms. | [/coreguard](https://eveaicore.com/coreguard) |
| **EVE Proof** | CAO, GC, CCO | Volume-priced decision certification. Every governed decision produces a signed, verifiable Governed Decision Certificate. | [/proof](https://eveaicore.com/proof) |
| **Model Update Firewall** | Compliance, Lending Ops | Pre-deployment model-change gating for regulated industries. Blocks protected-proxy variables, flags fair-lending violations. | [/fair-lending-demo](https://eveaicore.com/fair-lending-demo) |
| **EVE AI Core** | CTO, Product | Hosted cognitive platform with governed agent loop, 5-layer memory, consciousness modeling, and identity continuity. | [/cognitive-demo](https://eveaicore.com/cognitive-demo) |

**Hosting model:** EVE is operated exclusively as a hosted service by EVE NeuroSystems. Customers access governance capabilities via API endpoints and web interface. No source code, engine binaries, or model weights are distributed. Dedicated VPC deployments available in customer-preferred AWS regions for regulated industries.

**Client SDKs** (pip-installable, connect to the hosted service):
- `eve-coreguard` — CoreGuard API client (28 tests)
- `eve-proof` — Proof certification client (22 tests)

---

## Multi-Tenant Architecture

**Sovereign SDK.** Each organization receives isolated governance instances: Charter (additive custom rules only), Claims Ledger, Trust Dial, Action Registry, Reality Anchor. 30 REST endpoints at `/api/sovereign/`. 21 webhook event types.

| Tier | Sovereign API Calls/Month |
|------|--------------------------|
| Free | 0 |
| Pro | 10,000 |
| Team | 5,000 |
| Enterprise | Unlimited |

The authenticated runtime execution plane is tenant-isolated by design: every `/api/runtime/adjudicate` request requires a `tenant_id`, and decision records are never accessible across tenant boundaries.

---

## Security & Trust Root

All governance decisions are cryptographically signed. In production mode (`EVE_ENV=production`), the system refuses to start without a hardware-anchored trust root — software-only signing is blocked by `SovereignRootCompromise` (Pillar 114, Hard-Fail-Shut).

| Component | Status |
|-----------|--------|
| HMAC-SHA256 signed decision certificates | Shipped |
| Merkle-aggregated audit chains | Shipped |
| 24 domain-derived signing keys via HKDF-SHA256 | Shipped |
| Runtime plane HMAC binding + replay detection | Shipped |
| AWS CloudHSM CDK stack | Authored, pending deployment |
| PolarFire SoC FPGA veto bitstream | SOW drafted, contractor engagement pending |
| Production env-key refusal (`SovereignRootCompromise`) | Shipped |
| `caller_frame_hash` three-plane audit | Shipped |

Architecture details: [docs/resilience/HSM_PKCS11_BACKEND.md](docs/resilience/HSM_PKCS11_BACKEND.md) | Runbook: [docs/runbooks/CLOUDHSM_INITIALIZATION.md](docs/runbooks/CLOUDHSM_INITIALIZATION.md)

---

## Deployment

> **Note for contributors:** The commands below are for EVE NeuroSystems development only. The production service is hosted by EVE NeuroSystems — customers access it via API and web interface, not by running this codebase. Customer-facing SDKs (`eve-coreguard`, `eve-proof`) are pip-installable API clients that connect to the hosted service.

```bash
# EVE NeuroSystems development setup — not for customer deployment
git clone https://github.com/jamaurice/eve.git && cd eve
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # JWT_SECRET_KEY required, at least one LLM provider
python eve.py
```

| Service | Port | Purpose |
|---------|------|---------|
| Gateway | 8080 | Entry point, static assets, inbound reverse proxy |
| Governance Server | 8079 | Execution pipeline, governance layer |
| SaaS API | 8000 | Authentication, billing, metering, runtime execution plane |
| Sidecar Forward Proxy | 3128 | Egress interceptor (mandatory-gateway deployments) |

**Databases:** SQLite WAL (development), PostgreSQL asyncpg (production), Redis (working memory), MongoDB (episodic memory), Pinecone (semantic vectors).

**AWS CDK:** Full infrastructure-as-code in `infrastructure/`. ECS Fargate x3, Lambda x4, RDS PostgreSQL, ElastiCache Redis, S3, EventBridge, CloudWatch.

---

## API Reference

| Group | Endpoints | Key Routes |
|-------|-----------|------------|
| **Governance** | 30+ | `/api/charter/check`, `/api/governance/veto-module/status`, `/api/governance/query` |
| **Runtime Execution Plane** | 6 | `/api/runtime/adjudicate`, `/api/runtime/provenance/{id}`, `/api/runtime/authority/certificate` |
| **TVE & CRD** | 13 | `/api/tve/verify`, `/api/crd/evaluate`, `/api/crd/batch` |
| **Attestation** | 8 | `/api/attestation/generate`, `/api/governance/attestation/report` |
| **Migration** | 5 | `/api/migration/hot-swap`, `/api/migration/hot-swap-readiness` |
| **Substrate** | 3 | `/api/gpu-pressure/status`, `/api/rsi/pipeline/status` |
| **Compliance** | 3 | `/api/compliance/evaluate`, `/api/compliance/jurisdictions` |
| **Charter & Claims** | 12 | `/api/claims`, `/api/claims/{id}/prove`, `/api/trust/evaluate` |
| **Sovereign SDK** | 30 | `/api/sovereign/*` — tenant-isolated governance-as-a-service |
| **CoreGuard** | 1 | `POST /v1/decisions/evaluate` — standalone governance evaluation |
| **Sidecar Proxy** | in-process | `HTTPS_PROXY=http://eve-sidecar:3128` — egress interception + 451 veto with signed cert |
| **Resilience** | 7 | `/api/resilience/score`, `/api/resilience/certificate` |
| **Shadow Lab** | 9 | `/api/shadow-lab/status`, `/api/shadow-lab/decision-gate` |
| **Self-Modification** | 15 | `/api/self-modification/propose`, `/api/self-modification/budget` |
| **Billing & Metering** | 14 | `/api/billing/usage`, `/api/billing/quota`, `/api/developer/api-keys` |
| **Audit Chain** | 4 | `/api/audit/chain`, `/api/audit/verify-event`, `/api/audit/export`, `/api/audit/summary` |
| **Agent Loop** | 1 | `POST /api/chat/agent-loop` — governed multi-step reasoning, 34 tests |
| **Benchmark** | 1 | `POST /api/benchmark/governance-pressure` — drift-pressure load testing |

Full API catalog: [CLAUDE.md](CLAUDE.md) | Full architecture: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)

---

## Technology Stack

| Component | Technology |
|-----------|-----------|
| Runtime | Python 3.10+, asyncio |
| Governance Server | aiohttp (28,646 lines) |
| SaaS API | FastAPI, SQLAlchemy, Pydantic (23 routers) |
| Runtime Execution Plane | FastAPI router, 822 lines, HMAC-SHA256 signed, tenant-isolated, replay-protected |
| Cryptographic Signing | HMAC-SHA256, SHA-256 hash chains, JCS (RFC 8785) |
| Credential Encryption | PBKDF2 (390K iterations, API vault), AES-256-GCM; stdlib HMAC-XOR fallback |
| Databases | SQLite WAL (dev), PostgreSQL asyncpg (prod), Redis, MongoDB |
| Vector Search | Pinecone, ChromaDB, MongoDB $vectorSearch |
| Audit | Unified audit bus, Merkle aggregation, deletion proofs, SLSA L2 attestation |
| Frontend | 115 app pages, 16 themes, SSE streaming |
| Infrastructure | AWS CDK (ECS, Lambda, RDS, ElastiCache, S3) |

---

## Codebase Scale

| Metric | Count |
|--------|-------|
| Python files (core + interfaces + saas) | 1,705 |
| Python lines (core + interfaces + saas) | 1,241,000+ |
| HTML pages | 272 |
| App pages | 115 |
| JS files | 106 |
| CSS files | 93 |
| Governance pillars (pre-LLM) | 126 |
| Response Shield pillars (post-generation) | 17 |
| **Total enforcement pillars** | **143** |
| Test files | 226 |
| Agent loop tests | 34 |
| Runtime harness tests | 28 |

---

## Design Principles

1. **Fail-Closed** — Governance exceptions block the action. Never silently pass through.
2. **Deterministic** — No LLM calls in the governance hot path. Pure functions only.
3. **Pre-Execution** — Policy enforced before generation, not after.
4. **Invariant-First** — Governance is structural, not pattern-only. Safety relies on architecture, not prompt alignment.
5. **Firmware-Ready** — Veto Core has zero dependencies outside stdlib; could run on embedded hardware.
6. **Multi-Tenant** — Isolated governance instances per organization with cryptographic tenant separation.
7. **Stakes-Aware** — Governance intensity scales with risk. HARD_BLOCK vetoes invariant across all profiles.
8. **Auditable** — Every decision produces a signed, hash-chained trace with full provenance.
9. **Three-Point Enforcement** — Pre-generation, mid-stream, and post-generation governance.
10. **Memory-as-Execution-Surface** — Memory is a potential attack vector, not passive storage. All writes governed.
11. **SILENT_DOWNGRADE_PROHIBITED** — Cannot silently collapse an authoritative capability request to a lesser surface without structured disclosure.
12. **Replay-Safe** — Cryptographic request binding at the runtime execution plane prevents replay attacks and double-spend on governed decisions.

---

## Intellectual Property

**USPTO provisional patent applications** across 6 anchor families covering the complete governance architecture (patent-pending; provisional applications, not granted patents). Additional provisional specifications are drafted and ready to file.

| Series | Count | Coverage |
|--------|-------|----------|
| 63-series (Feb–Mar 2026) | 17 | Core governance, veto, identity, sovereignty, forensics |
| 64-series (Mar–Apr 2026) | 73 | TVE, CRD, three-plane, emotional continuity, introspection, security, compliance, unified control plane, identity sovereignty, safe self-modification, resilience invariance, adversarial surface closure, decision certification, SSE governance trace, policy-versioned binding, authority-spoofing defense, contamination isolation, ordinal assembly defense, symbolic pre-calculation defense |

**MOAT (6-family unified control-plane stack):**
- 64/022,677 — Family 1: Deterministic Pre-Execution Governance (Execution Control, filed 03/31/2026)
- 64/022,671 — Family 2: Multi-Axis Inference Routing (Economic Routing, filed 03/31/2026)
- 64/022,682 — Family 3: Cryptographic Attestation & Compliance (Trust & Compliance, filed 03/31/2026)
- 64/039,659 — Family 4: Identity & Sovereignty (Operator/Tenant Isolation, filed 04/15/2026)
- 64/039,660 — Family 5: Safe Self-Modification (Drift-Budgeted Autonomy, filed 04/15/2026)
- 64/039,652 — Family 6: Resilience & Failure-Mode Invariance (Hard-Fail-Shut, filed 04/15/2026)

**Enforcement defense filings (04/23/2026):**
- 64/047,283 — Ordinal Assembly Defense: pre-inference codepoint shadow-decoding and protected-basename reconstruction blocking (Pillar 128b)
- 64/047,284 — Symbolic Pre-Calculation Defense: fragmented-seed detection, transformation-instruction inference, and shadow-execution protected-basename matching (Pillar 128)

**Provisional specifications ready to file — GAP closures (applications #91–92):**
- EthicalTension_CoherenceCost (`docs/patent/filing/EthicalTension_CoherenceCost/`) — 9,477 words, 35 claims. Covers the multi-factor coherence cost formula, read-only drift-budget separation, veto-core purity invariant, λ=0.15 exponential decay frequency penalty, resilience-amplified costs, zero-cost guarantee for compliant actions, and JCS-canonicalized audit bus emission.
- Sidecar_FailClosed (`docs/patent/filing/Sidecar_FailClosed/`) — 12,139 words, 30 claims. Covers mandatory-gateway sidecar with iptables network-layer redirect, fail-closed `@enforce` exception-to-BLOCK conversion, HMAC-SHA256 signed per-request DecisionCertificates, FMI pre-check stage, pillar-tagged enforcement, TCP severance on veto (HTTP 451), and Kubernetes init-container pattern.

**3 trademark filings:** EVE AI Core (99665043), EVE Sigil Mark (99665022), EVE Core (99717925).

**5 AIMS hardware module specifications** with PolarFire SoC FPGA register maps.

Full portfolio: [/ip](https://eveaicore.com/ip) | Licensing: [/governance-license](https://eveaicore.com/governance-license)

---

## License

MIT License. See [LICENSE](LICENSE).

---

**EVE NeuroSystems LLC** — Deterministic governance infrastructure for autonomous AI systems.
Founded by **Jamaurice Holt** in Alpharetta, Georgia.

Other companies can build agent loops. Other companies can build governance wrappers. No other company has combined pre-execution deterministic enforcement, three-plane structural separation, a first-authority transparency gate with SILENT_DOWNGRADE_PROHIBITED, an authenticated runtime execution plane with cryptographic replay protection, a firmware-ready veto core with zero stdlib dependencies, 143 total enforcement pillars, cryptographic proof chains across every decision, and a patent-pending IP moat into a single platform. That combination is unique to EVE.

[eveaicore.com](https://eveaicore.com) | [IP Portfolio](https://eveaicore.com/ip) | [CoreGuard Demo](https://eveaicore.com/coreguard) | [Agent Loop Demo](https://eveaicore.com/cognitive-demo) | support@eveaicore.com
