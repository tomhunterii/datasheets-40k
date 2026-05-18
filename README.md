# datasheets-40k

10th-Edition Warhammer 40,000 datasheets — the markdown source of truth for [Command Auspex](https://github.com/tomhunterii/command_auspex) and [Logisticarum](https://github.com/tomhunterii/warhammer-40k).

## Structure

```
space-marines/
├── units/         (one .md per unit datasheet)
├── weapons/       (common-melee.md, common-ranged.md)
├── detachments/   (gladius-task-force.md, etc.)
└── faction-rules.md
tyranids/...
schema/
└── datasheet.schema.md
manifest.json      (file list + content hashes; regenerated on every commit)
```

## Authority

**Wahapedia is the standing authority** for every stat block here. The relevant codex PDF is the *initial* authority — the starting point for generation and the reference for fluff text. On disagreement, Wahapedia wins and an `<!-- ERRATA: ... -->` line is appended to the file.

See `schema/datasheet.schema.md` for the full schema and authority rule.

## How consumers use it

Both Command Auspex and Logisticarum add this repo as a submodule at `datasheets/`. They refresh on launch:

- **Command Auspex** does an HTTPS sync against `manifest.json` and pulls changed files via `raw.githubusercontent.com` (works in packaged Windows installs).
- **Logisticarum** does `git fetch --depth=1 && git reset --hard origin/main` on its submodule at server startup.

A datasheet edit committed and pushed here appears in both apps on next launch — no rebuild.

## Editing a datasheet

Clone this repo standalone (separately from the consumer apps), edit the markdown, commit, push. The pre-commit hook regenerates `manifest.json`.

```bash
git clone git@github-command-auspex:tomhunterii/datasheets-40k.git
cd datasheets-40k
# ...edit space-marines/units/intercessor-squad.md...
git add -A && git commit -m "fix: intercessor-squad bolt rifle range"
git push
```