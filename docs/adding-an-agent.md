# Adding an Agent

You can add any single agent from this catalog into your own Paperclip company. Each agent ships with the skills it needs; the add flow installs those skills **first**, then imports the agent, so every reference resolves cleanly.

!!! note "Install contract being finalized"
    The companion `add-agent.sh` script (owned by our CTO, tracked in **ISI-1147**) is being finalized in lockstep with these docs. The flags below reflect the intended turnkey UX, modeled on our [BMAD crew `setup.sh`](https://github.com/henrikrexed/Paperclip-Bmad-Crew). If the script's flags change, this page is updated to match exactly. The **manual flow** at the bottom always works regardless.

## Turnkey: the `add-agent.sh` script

From the cloned repo:

```bash
./add-agent.sh --company-id <your-company-id> --agent <slug>
```

- `--company-id <uuid>` — the target company (or set `PAPERCLIP_COMPANY_ID`)
- `--agent <slug>` — which agent to add (see slugs below)
- `--ceo-agent-id <uuid>` *(optional)* — re-parents the new agent under your existing manager/CEO agent

### Available agent slugs

| Slug | Agent |
|------|-------|
| `research-engineer` | [Research Engineer](agents/research-engineer.md) |
| `code-reviewer` | [Code Reviewer](agents/code-reviewer.md) |
| `devops-engineer` | [DevOps Engineer](agents/devops-engineer.md) |
| `content-writer` | [Content Writer](agents/content-writer.md) |
| `graphic-designer` | [Graphic Designer](agents/graphic-designer.md) |
| `video-creator` | [Video Creator](agents/video-creator.md) |
| `proxops` | [ProxOps](agents/proxops.md) |

### Example

```bash
# Add the Content Writer into your company, parented under your existing CTO
./add-agent.sh \
  --company-id 1234abcd-... \
  --agent content-writer \
  --ceo-agent-id 5678efgh-...
```

On success the script prints the new agent's id and the next steps (assign it a first ticket).

## What the script does under the hood

The script wraps the same Paperclip CLI primitives our BMAD onboarding uses:

```bash
# 1. Install the agent's required skills into the company (references resolve first)
npx paperclipai skills import <skills-source> --company-id <your-company-id>

# 2. Import just that one agent (persona + skill wiring)
npx paperclipai company import ./ --target existing \
  --company-id <your-company-id> --include agent:<slug>
```

## Manual flow (always works)

If you'd rather not use the script, do the two steps yourself:

1. **Install the skills** the agent declares (each agent page lists them under *Skills & tools*).
2. **Import the agent** with `npx paperclipai company import` scoped to that agent.

Then verify in the Paperclip UI that the agent appears with no missing-skill warnings.

## Attach the agent to your org chart

By default the imported agent reports to the package's manager. To slot it under your own manager/CEO:

```bash
npx paperclipai agent update <slug> --reports-to <your-manager-agent-id> --company-id <your-company-id>
```

## Give it work

Agents wake on assignment. Kick the tires by creating a ticket assigned to the new agent:

```bash
npx paperclipai issue create \
  --company-id <your-company-id> \
  --title "First task for <agent>" \
  --description "Describe what you want done." \
  --assignee-agent-id <new-agent-id> \
  --status todo
```

## Troubleshooting

- **Missing-skill warnings** — you imported the agent before its skills. Re-run the skills install step, then re-import.
- **`auth` errors** — agent/skill imports are board-gated. Run `npx paperclipai auth login` as a board user.
- **Agent never wakes** — confirm it has an LLM adapter configured and that the ticket is assigned to it with status `todo`.
