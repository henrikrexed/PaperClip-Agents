#!/usr/bin/env bash
#
# Add one (or more) PaperClip community agents — with their skills — into your
# own Paperclip company.
#
# It does the two steps in the right order, mirroring the BMAD crew's setup.sh:
#   1. Install each selected agent's required skills from their UPSTREAM repos,
#      so every skill reference resolves before the agent is imported (this is
#      the gap that bit BMAD onboarding on GH#6 — skills must exist first).
#   2. Import just the selected agent(s) from this package into your company.
#
# Skills are NOT bundled in this repo. They are imported from upstream, derived
# automatically from each agent's `skills:` frontmatter in agents/<slug>/AGENTS.md.
#
# Usage:
#   ./add-agent.sh --company-id <uuid> --agent <slug> [--agent <slug> ...] [options]
#   PAPERCLIP_COMPANY_ID=<uuid> ./add-agent.sh --agent <slug>
#
# Options:
#   --company-id <id>     Target Paperclip company UUID (or set PAPERCLIP_COMPANY_ID).
#   --agent <slug>        Agent to add. Repeat for multiple. Available slugs:
#                           research-engineer, code-reviewer, devops-engineer,
#                           content-writer, graphic-designer, video-creator,
#                           proxops, challenger
#   --ceo-agent-id <id>   If set, prints the command to re-parent each added agent
#                         under your existing manager/CEO agent.
#   --skills-repo <url>   Extra upstream skills repo to import (repeatable). Use this
#                         when an agent references skills from a repo this script does
#                         not know how to map automatically.
#   --dry-run             Print what would happen; make no changes.
#   -h, --help            Show this help and exit.
#
# Prerequisites:
#   - paperclipai CLI available via npx (npm install -g paperclipai)
#   - CLI authenticated as a board user (company import is board-gated):
#       npx paperclipai auth login
#   - An existing Paperclip company (the --company-id target).

set -euo pipefail

AVAILABLE_AGENTS="research-engineer code-reviewer devops-engineer content-writer graphic-designer video-creator proxops challenger"

COMPANY_ID="${PAPERCLIP_COMPANY_ID:-}"
CEO_AGENT_ID=""
DRY_RUN="0"
AGENTS=()
EXTRA_SKILLS_REPOS=()

usage() {
  sed -n '2,40p' "$0" | sed 's/^# \{0,1\}//'
  exit "${1:-0}"
}

die() {
  echo "error: $*" >&2
  echo "Run './add-agent.sh --help' for usage." >&2
  exit 1
}

while [ $# -gt 0 ]; do
  case "$1" in
    --company-id)    COMPANY_ID="${2:-}"; shift 2 ;;
    --company-id=*)  COMPANY_ID="${1#*=}"; shift ;;
    --agent)         AGENTS+=("${2:-}"); shift 2 ;;
    --agent=*)       AGENTS+=("${1#*=}"); shift ;;
    --ceo-agent-id)   CEO_AGENT_ID="${2:-}"; shift 2 ;;
    --ceo-agent-id=*) CEO_AGENT_ID="${1#*=}"; shift ;;
    --skills-repo)   EXTRA_SKILLS_REPOS+=("${2:-}"); shift 2 ;;
    --skills-repo=*) EXTRA_SKILLS_REPOS+=("${1#*=}"); shift ;;
    --dry-run)       DRY_RUN="1"; shift ;;
    -h|--help)       usage 0 ;;
    *) die "unknown argument: $1" ;;
  esac
done

[ -n "$COMPANY_ID" ] || die "missing --company-id (or PAPERCLIP_COMPANY_ID). This is the UUID of the company to add the agent into."
[ "${#AGENTS[@]}" -gt 0 ] || die "missing --agent <slug>. Available: $AVAILABLE_AGENTS"

if ! command -v npx >/dev/null 2>&1; then
  die "npx not found. Install Node.js, then 'npm install -g paperclipai'."
fi

# Run from the package root so 'company import ./' resolves .paperclip.yaml here.
cd "$(dirname "$0")"
[ -f ".paperclip.yaml" ] || die "could not find .paperclip.yaml next to add-agent.sh — run this script from inside the cloned repo."

# Validate each requested agent slug.
for slug in "${AGENTS[@]}"; do
  case " $AVAILABLE_AGENTS " in
    *" $slug "*) : ;;
    *) die "unknown agent '$slug'. Available: $AVAILABLE_AGENTS" ;;
  esac
  [ -f "agents/$slug/AGENTS.md" ] || die "agents/$slug/AGENTS.md not found — package is incomplete for '$slug'."
done

# Extract the skill keys from an agent's AGENTS.md frontmatter `skills:` block.
skill_keys_for() {
  local slug="$1"
  awk '
    NR==1 && $0=="---" { infm=1; next }
    infm && $0=="---"  { exit }
    infm && /^skills:/ { inskills=1; next }
    infm && inskills && /^[A-Za-z]/ { inskills=0 }
    infm && inskills && /^[[:space:]]*-[[:space:]]*/ {
      line=$0
      sub(/^[[:space:]]*-[[:space:]]*/, "", line)
      gsub(/"/, "", line)
      gsub(/[[:space:]]+$/, "", line)
      if (line != "") print line
    }
  ' "agents/$slug/AGENTS.md"
}

# Map a skill key prefix to its upstream repo URL, "BUNDLED", or "" (unresolved).
repo_for_key() {
  case "$1" in
    bmad-code-org/bmad-method/*) echo "https://github.com/bmad-code-org/BMAD-METHOD" ;;
    calesthio/openmontage/*)     echo "https://github.com/calesthio/OpenMontage" ;;
    paperclipai/paperclip/*)     echo "BUNDLED" ;;
    *)                           echo "" ;;
  esac
}

# Collect the set of upstream repos to import across all requested agents.
declare -a REPOS=()
add_repo() {
  local r="$1"
  for existing in "${REPOS[@]:-}"; do [ "$existing" = "$r" ] && return 0; done
  REPOS+=("$r")
}

for slug in "${AGENTS[@]}"; do
  while IFS= read -r key; do
    [ -n "$key" ] || continue
    repo="$(repo_for_key "$key")"
    if [ -z "$repo" ]; then
      die "agent '$slug' references skill '$key' with no known public upstream. Publish it and pass it via --skills-repo, or remove it from agents/$slug/AGENTS.md."
    elif [ "$repo" = "BUNDLED" ]; then
      : # ships with the paperclipai CLI; no import needed
    else
      add_repo "$repo"
    fi
  done < <(skill_keys_for "$slug")
done

for r in "${EXTRA_SKILLS_REPOS[@]:-}"; do [ -n "$r" ] && add_repo "$r"; done

AGENTS_CSV="$(IFS=,; echo "${AGENTS[*]}")"

echo "==> Adding agent(s) to company: $COMPANY_ID"
echo "    Agents:        ${AGENTS[*]}"
echo "    Skills repos:  ${REPOS[*]:-(none — only bundled skills)}"
echo

run() {
  echo "+ $*"
  if [ "$DRY_RUN" = "0" ]; then "$@"; fi
}

step=1
total=$(( ${#REPOS[@]} + 1 ))
for r in "${REPOS[@]:-}"; do
  [ -n "$r" ] || continue
  echo "==> Step $step/$total: installing skills from $r"
  run npx paperclipai skills import "$r" --company-id "$COMPANY_ID"
  echo
  step=$((step+1))
done

echo "==> Step $step/$total: importing agent(s) [$AGENTS_CSV]"
run npx paperclipai company import ./ --target existing --company-id "$COMPANY_ID" \
  --include agents --agents "$AGENTS_CSV" --yes
echo

echo "==> Done. Agent(s) added and every skill reference resolves."
echo
echo "Next steps:"
for slug in "${AGENTS[@]}"; do
  if [ -n "$CEO_AGENT_ID" ]; then
    echo "  • Attach '$slug' under your manager/CEO:"
    echo "      npx paperclipai agent update $slug --reports-to $CEO_AGENT_ID --company-id $COMPANY_ID"
  else
    echo "  • (Optional) Attach '$slug' under your manager/CEO agent:"
    echo "      npx paperclipai agent update $slug --reports-to <your-manager-agent-id> --company-id $COMPANY_ID"
  fi
done
echo "  • Assign the new agent its first task from the Paperclip UI or CLI:"
echo "      npx paperclipai issue create --company-id $COMPANY_ID \\"
echo "        --title \"<task title>\" --description \"<what to do>\" \\"
echo "        --assignee-agent-id <new-agent-id> --status todo"
