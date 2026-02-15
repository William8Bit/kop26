# Nemesis Lua Module (Garner-only MVP)

This module is isolated in `lua/plugin/custom/Nemesis/`.

## What it does (MVP)
- Spawns one Nemesis per player when entering `garner`.
- Nemesis is spawned as a real monster (not follower/NPC type).
- If owner is close, Nemesis prioritizes owner.
- If owner is far, Nemesis can pick nearby targets (mobs) to fight.
- Has configurable spawn distance and cooldown.
- If owner kills Nemesis: reward (gold/exp config).
- If Nemesis kills owner: penalty (gold, optional).
- If another player kills your Nemesis: no reward.

## Files
- `lua/plugin/custom/Nemesis/config.lua`
- `lua/plugin/custom/Nemesis/main.lua`

## Configuration
Edit `config.lua`:
- `map_name`
- `cooldown_sec`
- `spawn_distance_min`
- `spawn_distance_max`
- `leash_distance`
- `engage_player_distance`
- `farm_scan_distance`
- `monster_templates`
- `monster_respawn_sec`
- `reward_gold_on_player_kill`
- `reward_exp_on_player_kill`
- `penalty_gold_on_player_death`

## Load mode
Loaded by:
- `lua/plugin/custom/index.lua` -> `dofile(GetResPath('../lua/plugin/custom/Nemesis/main.lua'))`

## Test command
- `&lua Nemesis_ForceSpawn("YourName")`

## Notes
- This is a pure Lua test module.
- Cooldown is memory-based (resets on GameServer restart).
- Visual "equipment" depends on the chosen monster template IDs.
- For Lance/Carsise-like visuals, set monster IDs in `monster_templates` that match your client DB.
