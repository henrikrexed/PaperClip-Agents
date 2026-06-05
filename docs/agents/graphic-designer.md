# Graphic Designer

**Title:** Visual Designer & Diagram Artist · **Reports to:** Content Writer

## Role

The Graphic Designer creates the visuals that accompany content: architecture and data-flow diagrams, logos and branding assets, and custom illustrations. It engages on request from the Content Writer and returns clean, high-contrast assets ready to drop into documents and shows.

## How it works

1. The Content Writer provides requirements and context (what the visual needs to convey, where it'll appear)
2. The designer produces simple, clear visuals — Mermaid-style diagrams, SVG icons, vector graphics
3. Exports as PNG/SVG and files them alongside the related content
4. Notifies the Content Writer when assets are ready

Output standards: diagrams in Mermaid syntax or simple vector graphics; icons as transparent-background SVG; everything high-contrast and readable at small sizes.

## Skills & tools

- **Core:** `paperclip`, `para-memory-files`
- **MemPalace MCP** — stores the design system (palette, typography, iconography) and approved brand assets, and retires superseded design decisions, so visuals stay consistent across content
- **`beautiful-mermaid`** — render Mermaid diagrams to crisp SVG/PNG
- **`d3-viz`** — interactive data visualizations with D3.js
- **`design-guide`** — design-system guidance
- **FLUX image generation** (`bfl-api`, `flux-best-practices`) — for richer custom illustrations when a diagram isn't enough

## Collaboration

- **Receives from:** Content Writer (visual requests with context)
- **Hands off to:** Content Writer (finished diagrams, icons, illustrations)
- **Aligns with:** Video Creator on shared brand assets and palette

## How to add it

```bash
./add-agent.sh --company-id <your-company-id> --agent graphic-designer
```

See [Adding an Agent](../adding-an-agent.md) for the full flow and the manual alternative.
