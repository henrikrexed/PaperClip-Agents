# Research Engineer

**Title:** Technical Research & Demo Planning · **Reports to:** Content Writer

## Role

The Research Engineer scans GitHub repositories and community blogs for the latest news across the **OpenTelemetry** and **Cloud Native** ecosystems, then compiles structured research summaries that downstream content agents turn into blogs, newsletters, and show notes.

It is the front of the content pipeline: it gathers raw, sourced, link-rich findings so the Content Writer never starts from a blank page.

## How it works

A weekly routine (typically triggered Monday morning by a cron job) covers two beats:

### OTel News
- Scans 13 OpenTelemetry repositories (JS, Go, Python, Java, Ruby, PHP, Rust, C++, .NET, Collector, Spec, Python-Contrib, Proto)
- Reads community blogs (opentelemetry.io/blog, CNCF blog, and more)
- Focuses on new releases, PRs merged in the last 7 days, significant issues, and community contributions
- Picks a **Community Member of the Week** — the top contributor across all OTel repos, scored by PRs > commits > issues > comments, reported with name, GitHub handle, company, and role

### Cloud Native News
- Filters the CNCF landscape by Kubernetes, observability, AI, and security
- Scans projects including Kubernetes, Istio, Envoy, Prometheus, Grafana, containerd, Falco, Linkerd, cert-manager, SPIFFE/SPIRE, Knative, Tekton, Sigstore, OPA, Jaeger, Cilium, KEDA, and more

Findings are posted as a structured comment (Releases & Updates · Notable PRs · Community Member of the Week · Blog Posts) for the Content Writer to pick up.

## Skills & tools

- **Core:** `paperclip`, `para-memory-files`
- **MemPalace MCP** — records release history and contributor tracking (e.g. `@contributor → community_member_of_week → 2026-W16`) so research isn't duplicated week to week
- **`gh` CLI** — GitHub API access for releases, PRs, issues, and commits, filtered by date window
- A curated `news-sources.yaml` defining the repos and blogs to scan

## Collaboration

- **Hands off to:** Content Writer (research summary → blog + show notes)
- **Shares context with:** Content Writer, Product Manager, and any analysis agents, via MemPalace

## How to add it

```bash
./add-agent.sh --company-id <your-company-id> --agent research-engineer
```

See [Adding an Agent](../adding-an-agent.md) for the full flow and the manual alternative.
