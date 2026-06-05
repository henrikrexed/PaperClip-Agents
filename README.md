# PaperClip Agents — Community Crew

**A catalog of production [Paperclip](https://paperclip.ing) AI agents you can add to your own organization.**

These are real agents from **IsItObservable Labs** — they research, review code, ship infrastructure, and produce content every week. Lift one (or the whole crew) into your own Paperclip company, complete with its skills and persona.

[![Docs](https://img.shields.io/badge/docs-live-blue)](https://henrikrexed.github.io/PaperClip-Agents/)

## The crew

| Agent | Role |
|-------|------|
| Research Engineer | Weekly OpenTelemetry & Cloud Native ecosystem scans, contributor tracking |
| Code Reviewer | Adversarial, multi-layer code review as a merge gate |
| DevOps Engineer | GitHub Actions, multi-arch Docker, Helm, container scanning, docs deploys |
| Content Writer | Blogs, newsletters, show notes, slide decks |
| Graphic Designer | Diagrams, icons, branded visuals |
| Video Creator | Intros, explainers, social clips, livestream assets |
| ProxOps | Proxmox/homelab operations, proxy & network topology |

## Quick start

```bash
# 1. Clone
git clone https://github.com/henrikrexed/PaperClip-Agents.git
cd PaperClip-Agents

# 2. Authenticate the CLI as a board user (imports are board-gated)
npx paperclipai auth login

# 3. Add the agent you want (installs its skills first, then imports the agent)
./add-agent.sh --company-id <your-company-id> --agent content-writer
```

Full instructions: <https://henrikrexed.github.io/PaperClip-Agents/>

> **Note:** the `add-agent.sh` script is finalized in lockstep with the docs (tracked in ISI-1147). The docs always include a manual install flow that works regardless.

## Looking for a product team?

This catalog is our operations + content crew. For a full BMAD product-development team (Brainstormer, PM, Architect, Story Writer, Testing Architect, …), see the companion [Paperclip-Bmad-Crew](https://github.com/henrikrexed/Paperclip-Bmad-Crew) repo.

## Build the docs locally

```bash
pip install -r requirements.txt
mkdocs serve
```

## License

See repository for license details.
