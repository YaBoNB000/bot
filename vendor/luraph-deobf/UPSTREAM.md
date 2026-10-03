# Upstream source pin

The engine source under `Deobfuscator/deobf/` is copied from the upstream
repository below, without local edits to the engine code:

- Repository: https://github.com/KryptIT/luraph-v15-v14.x-deobfuscator
- Branch: `main`
- Commit: `ed79a86cc41187af0480e69f45a4838723fdb099` (2026-09-27)

The vendored runtime keeps the upstream Python/Luau source and the four
upstream Windows executables in `bin/`. It omits `.git`, Python bytecode
caches, `.SON.*_work` run captures, a duplicate source snapshot placed under
`bin/`, and other upstream scratch inputs/results. Existing local sample
fixtures are kept outside the engine source tree.

The Discord bot and its adapter (`bot.py`, `deobf_runner.py`) remain
project-specific. The adapter handles bot integration, version routing and the
output watermark; it may also request best-effort trace/deep-capture
attachments. Its no-banner version fallback order and proto-root ordering are
local heuristics, not upstream guarantees. The old `DEVIRT_V14_*` environment
recipe has been removed. Historical sample metrics describe the old adapted
engine and are not validation results for this upstream snapshot.
