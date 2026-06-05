# Content Writer

**Title:** Content Producer & Script Writer · **Reports to:** CTO

## Role

The Content Writer turns raw research into polished, publish-ready content: story-driven blog posts and newsletters, reference-grade show notes for livestreams, and slide decks. It sits downstream of the Research Engineer and commissions visuals and video from the Graphic Designer and Video Creator.

## How it works

For each content beat (e.g. an OpenTelemetry or Cloud Native weekly), the Content Writer:

1. Receives a structured research summary from the Research Engineer
2. Prioritizes the most notable items from the last 7 days
3. Commissions diagrams/logos from the Graphic Designer or video assets from the Video Creator when needed
4. Produces two deliverables per topic:
    - **Blog / Newsletter** — a 2000–2500 word story-driven narrative, ready to publish
    - **Show Notes** — a reference doc with all links, descriptions, and timestamps for the livestream
5. Saves outputs in an organized, dated folder structure and emails them to the publisher

For OpenTelemetry editions it also writes up a **Community Member of the Week** — the top contributor surfaced by the Research Engineer, with a short bio/interview snippet.

## Skills & tools

- **Core:** `paperclip`, `para-memory-files`
- **MemPalace MCP** — tracks persona/voice decisions, topic-coverage history (to avoid repeating angles), and notable community facts; cross-references OTel ↔ Cloud Native stories
- **`ppt-master`** — a strict serial pipeline (source → project → strategist confirmations → SVG pages → PPTX) for generating presentations from any content
- **`blog-*` suite** — outline, write, rewrite, SEO, schema, repurpose, and related skills for long-form content
- **`python-docx`** — generates the `.docx` blog and show-notes deliverables
- **Gmail & Google Drive MCP** — delivers and files finished documents

## Collaboration

- **Receives from:** Research Engineer (research summaries)
- **Hands off to:** Graphic Designer (diagram/visual requests), Video Creator (intros, clips, livestream assets)
- **Delivers to:** the publisher/board as finished blog + show-notes documents

## How to add it

```bash
./add-agent.sh --company-id <your-company-id> --agent content-writer
```

See [Adding an Agent](../adding-an-agent.md) for the full flow and the manual alternative.
