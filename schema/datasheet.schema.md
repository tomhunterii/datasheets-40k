# Datasheet Schema

This is the canonical structure every unit datasheet under
`<faction>/units/<slug>.md` MUST follow. Parsers in Command Auspex
(`Command Auspex/app/lib/datasheet-parser.js` and
`Command Auspex/src-tauri/src/catalogue/parsers/`) and Logisticarum
(`ultramarines/logisticarum_server.py`) all assume this shape.

## YAML Frontmatter (required)

```yaml
---
slug: intercessor-squad           # kebab-case, MUST match the filename
faction: space-marines            # one of: space-marines, tyranids, ...
sub_factions: [adeptus-astartes]  # optional list of detachment-eligible sub-factions
epic_hero: false                  # true for named characters that lock detachment
battleline: true                  # true if Battleline keyword present
is_character: false               # true for any Character unit
loadouts:                         # one entry per priceable model count
  - models: 5
    points: 80
    default: true                 # exactly one entry MUST have default: true
  - models: 10
    points: 160
keywords:
  faction: [Adeptus Astartes, Imperium]   # FACTION keywords as on the datasheet
  unit: [Infantry, Battleline, Grenades, Tacticus, Intercessor Squad]
led_by:                           # for non-character units — characters that can join
  - captain
  - lieutenant
  # ...
---
```

For characters, replace `led_by` with `leader_of` (list of unit slugs the character can join) and / or `attaches_to` (keyword-based attachment rule).

## Body sections (in order)

1. `# <Unit Name>` — H1, used as display name
2. **Faction:** and **Source:** lines (free text)
3. `## Keywords` — bolded `**Faction Keywords:**` and `**Unit Keywords:**` lines
4. `## Base` — bullet list with `**Shape:**`, `**Diameter:** Nmm` (or `**Dimensions:** Nmm × Nmm`), `**Flight stem:** yes|no`; optional `**Per-model bases:**` followed by indented sub-models
5. `## Profile` — pipe table with columns `M | T | Sv | W | Ld | OC`; optional `**Invulnerable Save:** N+` line below
6. `## Ranged Weapons` — pipe table with columns `Weapon | Range | A | BS | S | AP | D | Keywords`
7. `## Melee Weapons` — pipe table with columns `Weapon | Range | A | WS | S | AP | D | Keywords`
8. `## Abilities` — `### Faction`, `### Core`, `### Unique` (or named ability subsections)
9. `## Unit Composition` — free text describing what's in each loadout
10. `## Wargear Options` — bullet list of choices, e.g. `- Replace bolt rifle with X`
11. `## Wargear Abilities` — keyword/ability text not tied to weapons
12. `## Transport` — only for transport vehicles
13. `## Faction Keywords` — repeat for parser fallback

## Provenance footer (required)

Every file ends with:

```
<!-- Last verified: YYYY-MM-DD -->
<!-- Sources: <codex-id> (initial), wahapedia (authority) -->
```

Optional, when codex and Wahapedia disagree:

```
<!-- ERRATA: Codex says X, Wahapedia (taken) says Y. -->
```

Multiple ERRATA lines are allowed.

## Authority rule

When generating or updating a datasheet:

1. **Wahapedia is the standing authority.** Its stat block is what the file commits — Wahapedia folds in Dataslate/errata updates.
2. **The codex PDF is the initial authority** — starting point for generation, fluff text reference, and the authority for anything Wahapedia doesn't render.
3. On any disagreement, take Wahapedia and append an `<!-- ERRATA: ... -->` line recording what the codex said.
