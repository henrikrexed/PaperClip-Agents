# Video Creator

**Title:** Video Production Specialist · **Reports to:** Content Writer

## Role

The Video Creator produces video content — intros, outros, transitions, explainers, and livestream assets — using the **OpenMontage** agentic video-production system. It acts as the orchestrator: reading pipeline definitions, selecting tools, and driving rendering end to end.

## How it works

The core tool is [OpenMontage](https://github.com/calesthio/OpenMontage), which provides production pipelines, tools, and orchestration skills. The agent:

1. Receives a request from the Content Writer with requirements
2. Selects the appropriate pipeline — **Cinematic** (intros/teasers), **Animation** (motion graphics, kinetic typography), **Animated Explainer**, **Clip Factory** (batch social clips), **Podcast Repurpose**, or **Screen Demo**
3. Uses scored provider selection — free-tier first (Piper TTS, stock footage from Archive.org / Pexels / Pixabay)
4. Generates assets, composes with Remotion, renders with FFmpeg
5. Self-reviews with reviewer skills before delivery

Output standards: MP4 (H.264) at 1920×1080 or 1280×720; intros/outros 5–15s; transitions 2–5s; consistent brand colors and typography.

### Budget controls
- Default cap of **$10 per production**
- Prefers free/local tools (Piper TTS, stock footage, FFmpeg) over paid APIs
- Requires Content Writer approval before using paid providers (Kling, Runway, ElevenLabs)

## Skills & tools

- **Core:** `paperclip`, `para-memory-files`
- **MemPalace MCP** — stores style/pipeline decisions and render recipes (e.g. `GitHub Radar intro → uses_pipeline → Cinematic + Piper TTS`) and aligns assets to the show's story arc
- **External tooling:** OpenMontage pipelines, `ffmpeg`, Remotion; audio via `elevenlabs` / `music` / `acestep`; motion graphics via `manim-composer`; optional AI generation via `ai-video-gen`

## Collaboration

- **Receives from:** Content Writer (video requests, scripts)
- **Aligns with:** Graphic Designer on shared brand assets
- **Delivers:** finished renders for shows and social distribution

## How to add it

```bash
./add-agent.sh --company-id <your-company-id> --agent video-creator
```

See [Adding an Agent](../adding-an-agent.md) for the full flow and the manual alternative.
