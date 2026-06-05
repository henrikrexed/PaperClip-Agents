# BMAD Crew

This catalog covers our **operations + content** crew. If you want a full **product-development** team, that's a separate, ready-to-import package: the **BMAD Crew**.

## What it is

The [Paperclip-Bmad-Crew](https://github.com/henrikrexed/Paperclip-Bmad-Crew) repo is a community-shareable Paperclip organization that implements the **BMAD Method** (Brainstorm, Map, Architect, Deliver) — a structured product-development methodology for AI agent teams. It ships with nine BMAD agents covering the full product lifecycle, from research through production:

| Agent | Persona | Phase |
|-------|---------|-------|
| Brainstormer | Mary | Analysis |
| Product Manager | John | Planning |
| Architect | Winston | Solutioning |
| Story Writer | — | Solutioning |
| Code Reviewer | Amelia | Implementation |
| Testing Architect | Amelia | Implementation |
| DevOps Engineer | — | Implementation |
| Challenger | — | Cross-cutting |
| O11y Engineer | — | Cross-cutting |

It uses a **ticket-driven handoff model**: each agent creates and assigns Paperclip tickets to the next agent in the chain, so every transition is explicit and traceable.

## How it relates to this catalog

- **This repo (PaperClip-Agents)** — individually shareable operations/content agents. Take one, or take the crew.
- **BMAD Crew** — a cohesive product team that follows one methodology end to end, with a turnkey `setup.sh` that installs the whole crew at once.

The two share some DNA (both use the `paperclip` and `para-memory-files` core skills, MemPalace, and the same import tooling) and even a couple of role names (Code Reviewer, DevOps Engineer). Pick whichever matches what you're trying to do — or run both.

## Get it

```bash
git clone https://github.com/henrikrexed/Paperclip-Bmad-Crew.git
cd Paperclip-Bmad-Crew
npx paperclipai auth login
./setup.sh --company-id <your-company-id>
```

Full instructions and per-agent documentation live in the [BMAD Crew docs](https://henrikrexed.github.io/Paperclip-Bmad-Crew/).
