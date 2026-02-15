return {
  enabled = true,

  -- Only this map is supported for now.
  map_name = "garner",

  -- Monster templates used to spawn a real mob Nemesis.
  -- Use monster IDs (not character template IDs like 3/4) to avoid NPC/follower behavior.
  -- Pick IDs with the visual you want (weapon/equipment look comes from monster template).
  monster_templates = { 668, 669 },

  -- Respawn delay used by CreateCha/CreateChaEx. Keep very high to avoid natural respawn.
  monster_respawn_sec = 99999999,

  -- Cooldown before a new Nemesis can spawn for the same player.
  cooldown_sec = 3600,

  -- Prevent repeated spawn attempts if creation fails.
  retry_spawn_interval_sec = 10,

  -- Spawn distance around player (game world units).
  spawn_distance_min = 250,
  spawn_distance_max = 650,

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
