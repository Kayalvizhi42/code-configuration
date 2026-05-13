---
name: disk-cleanup
description: Safe local disk cleanup workflow focused on Docker artifacts, Python .venv directories, and uv cache; always summarize usage first and require explicit yes/no before deletions.
---

# Disk Cleanup Skill

Use this skill when the user wants to recover local disk space from development tooling.

## Goals
- Show what is consuming space before cleanup.
- Ask for explicit user confirmation before destructive actions.
- Prefer targeted cleanup steps over blind deletion.

## Default Targets
- Docker data (images, containers, build cache, optional volumes)
- Python virtual environments under a user-selected workspace (default: `~/Documents/insurgence`)
- `uv` cache at `~/.cache/uv`

## Workflow
1. Inspect and summarize disk usage:
   - `docker system df -v` (if Docker daemon is available)
   - `find <workspace> -type d -name '.venv' -prune` + size aggregation
   - `du -sh ~/.cache/uv`
2. Propose cleanup actions and expected impact.
3. Prompt user with a clear yes/no for each cleanup area.
4. Run cleanup commands only for approved areas.
5. Re-run summaries and report before/after.

## Commands

### Docker
- Summary:
  - `docker system df`
  - `docker system df -v`
- Cleanup:
  - `docker system prune -a`
  - Optional volumes: `docker system prune --volumes`
  - Build cache: `docker builder prune -a`

### .venv
- List:
  - `find <workspace> -type d -name '.venv' -prune -print`
- Delete all:
  - `find <workspace> -type d -name '.venv' -prune -exec rm -rf {} +`

### uv cache
- Summary:
  - `du -sh ~/.cache/uv`
- Cleanup:
  - `uv cache clean`
  - Fallback: `rm -rf ~/.cache/uv`

## Safety Rules
- Never run `rm -rf` without explicit user confirmation in the same turn.
- If Docker is not running, skip Docker cleanup and explain why.
- Always provide a dry-run/preview command option first when user seems unsure.

## Output Style
- Keep responses concise and practical.
- Include exact commands in copy-paste form.
- End with a short before/after size summary when cleanup runs.
