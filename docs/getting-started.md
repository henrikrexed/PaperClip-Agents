# Getting Started

This page gets you from zero to a Paperclip company that's ready to receive one of our community agents. If you already run a Paperclip company, skip straight to [Adding an Agent](adding-an-agent.md).

## Prerequisites

- **[Paperclip](https://paperclip.ing)** — install the CLI: `npm install -g paperclipai`
- **An LLM adapter** — [Claude Code](https://claude.ai/claude-code) or another supported adapter, for the agents to run on
- **A board login** — agent and skill imports are board-gated, so authenticate the CLI as a board user:
  ```bash
  npx paperclipai auth login
  ```
- **A Paperclip company** — the target org you'll add agents to. Don't have one yet? See [Bootstrap a company](#bootstrap-a-company) below.

## Clone this repo

```bash
git clone https://github.com/henrikrexed/PaperClip-Agents.git
cd PaperClip-Agents
```

## Bootstrap a company

If you're starting from a fresh Paperclip install with no company, create one first. You'll need the resulting **company UUID** for every install command on this site:

```bash
# Initialize the local instance (first run only)
npx paperclipai init

# Create a company and note the UUID it prints back
npx paperclipai company create --name "My Org"
```

Keep that UUID handy — throughout the docs it appears as `<your-company-id>`.

## What "adding an agent" means

When you add one of our agents, two things happen, in this order:

1. **The agent's skills are installed into your company** — so every skill reference the agent makes resolves cleanly (no missing-skill warnings).
2. **The agent itself is imported** — its persona (`AGENTS.md`), role, and skill wiring.

This ordering matters: installing the agent before its skills leaves dangling references. The [add script](adding-an-agent.md) handles the ordering for you.

## Run the docs locally

This site is built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/):

```bash
pip install -r requirements.txt
mkdocs serve
```

Then open <http://127.0.0.1:8000>.

## Next steps

Head to [Adding an Agent](adding-an-agent.md) to provision a specific agent, or browse the [Agents](agents/index.md) catalog to decide which one you need.
