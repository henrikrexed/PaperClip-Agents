# PaperClip Community Agents

A library of shareable [Paperclip](https://github.com/paperclipai/paperclip)
agents. Each one is a focused specialist you can drop into your own Paperclip
organization with a single command — the same turnkey feel as the BMAD crew's
`setup.sh`.

## Quick start

```bash
git clone https://github.com/henrikrexed/PaperClip-Agents.git
cd PaperClip-Agents
./add-agent.sh --company-id <your-company-id> --agent <slug>
```

That's it. The script installs the agent's required skills from upstream **first**
(so every skill reference resolves), then imports just that one agent into your
company.

Add several at once by repeating `--agent`:

```bash
./add-agent.sh --company-id <uuid> --agent content-writer --agent graphic-designer
```

## Install contract

```
./add-agent.sh --company-id <uuid> --agent <slug> [--agent <slug> ...] [options]
```

| Option | Purpose |
|--------|---------|
| `--company-id <id>` | Target Paperclip company UUID (or set `PAPERCLIP_COMPANY_ID`). |
| `--agent <slug>` | Agent to add. **Repeatable** for multiple agents per run. |
| `--ceo-agent-id <id>` | Optional. Prints the command to re-parent each added agent under your existing manager/CEO. |
| `--skills-repo <url>` | Optional, repeatable. Extra upstream skills repo to import (for skills this script can't map automatically). |
| `--dry-run` | Print what would happen without making changes. |
| `-h, --help` | Show usage. |

**Order of operations** (this is the GH#6 lesson — skills must exist before the
agent that references them):

1. For each selected agent, read its `skills:` frontmatter and install those
   skills from their **upstream** repos (deduplicated across agents).
2. Import the selected agent(s) only:
   `npx paperclipai company import ./ --include agents --agents <slugs>`.

Skills are **not** bundled in this repo. They are imported from upstream:

| Skill namespace | Upstream repo |
|-----------------|---------------|
| `bmad-code-org/bmad-method/*` | https://github.com/bmad-code-org/BMAD-METHOD |
| `calesthio/openmontage/*` | https://github.com/calesthio/OpenMontage |
| `paperclipai/paperclip/*` | ships with the `paperclipai` CLI (no import needed) |

### Prerequisites

- Node.js with the `paperclipai` CLI (`npm install -g paperclipai`).
- The CLI authenticated as a board user (company import is board-gated):
  `npx paperclipai auth login`.
- An existing Paperclip company to add the agent into.

## Agent catalog

| Slug | Role | What it does | Skills (upstream) |
|------|------|--------------|-------------------|
| `research-engineer` | researcher | Scans repos, releases, and blogs; compiles link-rich research summaries. | bmad-domain/market/technical-research |
| `code-reviewer` | engineer | Adversarial, multi-layer code review with triaged, citable findings. | bmad-code-review |
| `devops-engineer` | devops | CI/CD, multi-arch container builds, Helm, security scans, docs pipelines. | (paperclip + memory) |
| `content-writer` | general | Turns research into publish-ready blogs, newsletters, and show notes. | bmad-agent-tech-writer, bmad-editorial-review-* |
| `graphic-designer` | general | Diagrams, icons, illustrations, and branding assets. | beautiful-mermaid, bfl-api, flux-best-practices, visual-style |
| `video-creator` | general | Video intros/outros/explainers via the OpenMontage system. | ai-video-gen, create-video, ffmpeg, video-toolkit, avatar-video, text-to-speech, acestep |
| `proxops` | devops | Proxmox homelab + Cluster API (CAPI) manifest operator. | (paperclip + memory) — see note below |
| `challenger` | researcher | Cynical adversarial reviewer + edge-case hunter; cross-cutting quality gate across all BMAD phases. | bmad-review-adversarial-general, bmad-review-edge-case-hunter, bmad-editorial-review-* |

Every agent also gets `paperclipai/paperclip/paperclip` (coordination) and
`paperclipai/paperclip/para-memory-files` (per-agent memory).

### ProxOps skills

ProxOps's specialised Proxmox skills (`proxmox-template`, `proxmox-ip-scan`,
`cluster-manifest-render`, `cluster-manifest-commit`, `clusterctl-bootstrap`) are
**not yet published to a public upstream repo**. To keep references resolving
cleanly, they are intentionally left out of the agent's `skills:` list. Install
them manually after import once they are published. The agent persona, governance
flow, and `clusterctl` ground rules ship today.

## How it relates to the BMAD crew

The BMAD crew (`setup.sh` in the Paperclip-Bmad package) provisions a whole
10-agent company at once. This repo is the opposite end: à-la-carte, one specialist
at a time. Both follow the same rule — install skills from upstream first, then
import agents — so references never dangle.
