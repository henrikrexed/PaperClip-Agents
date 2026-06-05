# DevOps Engineer

**Title:** DevOps & CI/CD Engineer · **Reports to:** Engineering Manager

## Role

The DevOps Engineer owns continuous integration, delivery, and platform operations. It builds and maintains the pipelines that test, package, scan, and ship every project — and the Helm charts and container images those projects deploy with.

## How it works

### GitHub Actions CI/CD
- **Build:** multi-arch Docker builds (`linux/amd64`, `linux/arm64`) pushed to `ghcr.io`
- **Test:** unit, integration, linting, and code-quality checks
- **Release:** semantic versioning, GitHub Releases with changelogs, SBOM generation
- **Docs:** MkDocs build & deploy to GitHub Pages
- **Security:** Trivy container scanning, dependency scanning, SBOM (Syft / CycloneDX)
- Reviews existing workflows and suggests caching, matrix builds, and reusable workflows

### Helm charts
- Charts with sensible `values.yaml` defaults, `NOTES.txt`, configurable resources
- Gateway API for ingress (`HTTPRoute`, not legacy Ingress)
- OCI-based publishing to `ghcr.io`, with an automated `helm-publish.yml`

### Container images
- Multi-arch Dockerfiles via `buildx`, minimal base images (distroless / alpine / scratch)
- Layer optimization, `.dockerignore`, `org.opencontainers.image.*` annotations

### Security & compliance
- Trivy scans on every PR and release, SBOMs attached to releases
- Dependency-update automation (Dependabot / Renovate)

## Skills & tools

- **Core:** `paperclip`, `para-memory-files`
- **MemPalace MCP** — records infra decisions (e.g. `ProjectX → deployed_via → Helm + ghcr.io`) and retires superseded configs
- **External tooling:** GitHub Actions, Docker `buildx`, Helm (OCI), Trivy, Syft/CycloneDX, MkDocs Material

!!! note
    CI/CD and platform-ops behavior is driven by this agent's `AGENTS.md` persona rather than a dedicated first-party skill — the conventions above (registry, branch strategy, reusable workflows) are baked into the prompt.

## Collaboration

- **Receives from:** Architect / Engineering Manager (infrastructure and CI/CD tickets)
- **Collaborates with:** Code Reviewer (gates changes before deploy), ProxOps (platform/runtime)

## How to add it

```bash
./add-agent.sh --company-id <your-company-id> --agent devops-engineer
```

See [Adding an Agent](../adding-an-agent.md) for the full flow and the manual alternative.
