return {
  enabled = true,

  -- Only this map is supported for now.
  map_name = "garner",

  -- Nemesis by player level (inclusive ranges).
  -- You can tune these ranges any time without changing code.
  -- 1     Long Haired Guy
  -- 868   Lance Newbie Phantom
  -- 869   Lance Hunter Phantom
  -- 870   Lance Crusader Phantom
  -- 871   Lance Voyager Phantom
  -- 883   Black Dragon Lance
  monster_by_level = {
    { min = 1,  max = 5,   mob = 1   },
    { min = 6,  max = 10,  mob = 868 },
    { min = 11, max = 40,  mob = 869 },
    { min = 41, max = 55,  mob = 870 },
    { min = 56, max = 75,  mob = 871 },
    { min = 76, max = 255, mob = 883 },
  },

  -- Fallback if no range matches.
  fallback_monster_template = 883,

  -- Respawn delay used by CreateCha/CreateChaEx. Keep very high to avoid natural respawn.
  monster_respawn_sec = 99999999,

  -- Cooldown before a new Nemesis can spawn for the same player.
  cooldown_sec = 3600,

  -- Prevent repeated spawn attempts if creation fails.
  retry_spawn_interval_sec = 10,

  -- Spawn distance around player (game world units).
  spawn_distance_min = 1250,
  spawn_distance_max = 1650,

  -- If Nemesis is farther than this, it is moved near the owner.
  leash_distance = 2200,

  -- If owner is within this distance, Nemesis prioritizes attacking owner.
  engage_player_distance = 900,

  -- While owner is farther than engage range, Nemesis can seek nearby mobs to fight.
  farm_scan_distance = 1000,

  -- Nemesis lifetime in milliseconds.
  nemesis_lifetime_ms = 1800000,

  -- Economy test values.
  reward_gold_on_player_kill = 5000000,
  reward_exp_on_player_kill = 0,
  penalty_gold_on_player_death = 0,

  -- If true, only owner gets reward when killing own Nemesis.
  give_reward_only_to_owner = true,

  -- If true, a passive despawn (map leave/invalid) also starts cooldown.
  apply_cooldown_on_despawn = false,

  -- Text feedback
  show_system_notices = true,
  notice_spawn = "[Nemesis] A dimensional hunter has appeared.",
  notice_reward = "[Nemesis] You defeated your Nemesis.",
  notice_penalty = "[Nemesis] Your Nemesis defeated you.",
  notice_other_kill = "[Nemesis] Your Nemesis was destroyed by another player.",
  notice_left_map = "[Nemesis] Nemesis dissipated after leaving Garner.",
}
