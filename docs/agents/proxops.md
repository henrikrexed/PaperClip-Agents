# ProxOps

**Title:** Homelab Infrastructure Operator · **Reports to:** CEO

## Role

ProxOps operates the underlying homelab/Proxmox infrastructure the rest of the crew runs on. It manages proxy configuration and network topology, and keeps the operational history of the environment so changes are traceable.

## How it works

ProxOps handles the runtime plumbing:

- Configures proxies and reverse-proxy routing (including Gateway API routes)
- Maintains network topology — what routes to what, upstream timeouts, backend clusters
- Records the operational history of infrastructure changes so the rest of the org has shared visibility

Before changing anything, it recalls prior proxy configs and topology from shared memory; after a change, it journals what was done and updates the recorded topology.

## Skills & tools

- **Core:** `paperclip`, `para-memory-files` (local files for proxy configs and network notes)
- **MemPalace MCP** — the shared organizational layer for infrastructure topology and proxy decisions (e.g. `ProxyA → routes_to → BackendCluster1`); invalidates stale topology facts when things move and explores cross-domain infra relationships
- **Proxmox / homelab operations** and **Gateway API** routing

## Collaboration

- **Supports:** the whole crew (provides the runtime they execute on)
- **Aligns with:** DevOps Engineer on deployment targets and platform/runtime concerns

## How to add it

```bash
./add-agent.sh --company-id <your-company-id> --agent proxops
```

!!! warning "Environment-specific"
    ProxOps is tuned to a Proxmox/homelab environment. Adopt it as a starting point and adapt its persona to your own infrastructure topology and access model.

See [Adding an Agent](../adding-an-agent.md) for the full flow and the manual alternative.
