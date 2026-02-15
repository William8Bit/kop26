print("Loading custom Nemesis module")

Nemesis = Nemesis or {}
Nemesis.cfg = dofile(GetResPath("../lua/plugin/custom/Nemesis/config.lua"))
Nemesis.state = Nemesis.state or {
  cooldown_by_id = {},
  active_by_player = {},
  player_by_nemesis = {},
  last_attempt_by_id = {},
  last_player_attacker_by_nemesis = {},
}

local function nnow()
  return os.time()
end

local function tcount(t)
  return table.getn(t)
end

local function valid_char(c)
  return c ~= nil and ValidCha(c) == 1
end

local function is_living(c)
  return valid_char(c) and IsChaLiving(c) == 1
end

local function get_player_id(role)
  if role == nil then
    return nil
  end
  if GetRoleID ~= nil then
    local ok, id = pcall(GetRoleID, role)
    if ok then
      return id
    end
  end
  local ply = GetChaPlayer(role)
  if ply == nil then
    return nil
  end
  return GetPlayerID(ply)
end

local function tolower(s)
  if s == nil then
    return ""
  end
  return string.lower(s)
end

local function in_target_map(role)
  return tolower(GetChaMapName(role)) == tolower(Nemesis.cfg.map_name)
end

local function notice(role, msg)
  if Nemesis.cfg.show_system_notices and msg and msg ~= "" and valid_char(role) then
    SystemNotice(role, msg)
  end
end

local function apply_money(role, amount)
  if not valid_char(role) or amount == nil or amount == 0 then
    return
  end

  -- Most builds accept AddMoney(role, 0, amount).
  local ok = pcall(AddMoney, role, 0, amount)
  if ok then
    return
  end

  -- Fallbacks for other cores.
  if amount > 0 then
    pcall(AddMoney, role, amount)
  else
    if TakeMoney ~= nil then
      pcall(TakeMoney, role, math.abs(amount))
    end
  end
end

local function apply_exp(role, amount)
  if not valid_char(role) or amount == nil or amount <= 0 then
    return false
  end
  if AddExp == nil then
    return false
  end
  if pcall(AddExp, role, nil, amount, amount) then
    return true
  end
  if pcall(AddExp, role, 0, amount, amount) then
    return true
  end
  if pcall(AddExp, role, amount, amount) then
    return true
  end
  if pcall(AddExp, role, amount) then
    return true
  end
  return false
end

local function set_cooldown(player_id)
  if player_id == nil then
    return
  end
  Nemesis.state.cooldown_by_id[player_id] = nnow() + Nemesis.cfg.cooldown_sec
end

local function clear_active_record(rec)
  if rec == nil then
    return
  end
  Nemesis.state.active_by_player[rec.player] = nil
  Nemesis.state.player_by_nemesis[rec.nemesis] = nil
  Nemesis.state.last_player_attacker_by_nemesis[rec.nemesis] = nil
end

local function kill_nemesis_if_alive(rec)
  if rec == nil then
    return
  end
  if is_living(rec.nemesis) then
    Hp_Endure_Dmg(rec.nemesis, Mxhp(rec.nemesis))
  end
end

local function clear_player_active(role, kill_nemesis)
  local rec = Nemesis.state.active_by_player[role]
  if rec == nil then
    return
  end
  if kill_nemesis then
    kill_nemesis_if_alive(rec)
  end
  clear_active_record(rec)
end

local function pick_template_id()
  local list = Nemesis.cfg.monster_templates or Nemesis.cfg.character_templates or { 668 }
  if tcount(list) <= 0 then
    return 668
  end
  return list[math.random(1, tcount(list))]
end

local function get_spawn_pos_near(role)
  local px, py = GetChaPos(role)
  local min_d = Nemesis.cfg.spawn_distance_min or 250
  local max_d = Nemesis.cfg.spawn_distance_max or 650
  if max_d < min_d then
    max_d = min_d
  end
  local dist = math.random(min_d, max_d)
  local ang = math.random() * 6.28318
  return math.floor(px + (math.cos(ang) * dist)), math.floor(py + (math.sin(ang) * dist))
end

local function create_nemesis_mob(role, template_id, x, y)
  local respawn_sec = Nemesis.cfg.monster_respawn_sec or 99999999
  local nem = nil
  if CreateChaEx ~= nil and GetChaMapCopy ~= nil then
    local ok, map_copy = pcall(GetChaMapCopy, role)
    if ok and map_copy ~= nil then
      nem = CreateChaEx(template_id, x, y, 145, respawn_sec, map_copy)
    end
  end
  if not valid_char(nem) then
    nem = CreateCha(template_id, x, y, 145, respawn_sec)
  end
  return nem
end

local function resolve_killer(dead_role)
  local killer = GetFirstAtker(dead_role)
  if valid_char(killer) then
    return killer
  end

  if GetChaHarmByNo == nil then
    return nil
  end

  local best = nil
  local best_dmg = -1
  for i = 0, 4 do
    local ok, atker, dmg = pcall(GetChaHarmByNo, dead_role, i)
    if ok and valid_char(atker) and dmg ~= nil and dmg > best_dmg then
      best = atker
      best_dmg = dmg
    end
  end
  return best
end

local function spawn_near_player(role)
  local pid = get_player_id(role)
  if pid == nil then
    return false
  end

  local now = nnow()
  if Nemesis.state.last_attempt_by_id[pid] ~= nil and now < Nemesis.state.last_attempt_by_id[pid] then
    return false
  end

  if Nemesis.state.cooldown_by_id[pid] ~= nil and now < Nemesis.state.cooldown_by_id[pid] then
    return false
  end

  local template_id = pick_template_id()
  local nx, ny = get_spawn_pos_near(role)
  local nem = create_nemesis_mob(role, template_id, nx, ny)
  Nemesis.state.last_attempt_by_id[pid] = now + Nemesis.cfg.retry_spawn_interval_sec

  if not valid_char(nem) then
    return false
  end

  SetChaAIType(nem, AI_ATK)
  SetChaLifeTime(nem, Nemesis.cfg.nemesis_lifetime_ms)

  local rec = {
    nemesis = nem,
    player = role,
    player_id = pid,
    created_at = now,
  }

  Nemesis.state.active_by_player[role] = rec
  Nemesis.state.player_by_nemesis[nem] = rec
  Nemesis.state.last_player_attacker_by_nemesis[nem] = nil

  notice(role, Nemesis.cfg.notice_spawn)
  return true
end

local function ensure_spawn(role)
  if Nemesis.cfg.enabled ~= true then
    return
  end
  if IsPlayer(role) ~= 1 then
    return
  end
  if not in_target_map(role) then
    return
  end

  local rec = Nemesis.state.active_by_player[role]
  if rec ~= nil and is_living(rec.nemesis) then
    return
  end

  if rec ~= nil then
    clear_active_record(rec)
  end

  spawn_near_player(role)
end

local function pick_farm_target(rec)
  if GetChaByRange == nil then
    return nil
  end
  local x, y = GetChaPos(rec.nemesis)
  local range = Nemesis.cfg.farm_scan_distance or 1000
  local t = GetChaByRange(rec.nemesis, x, y, range, 10)
  if not is_living(t) then
    return nil
  end
  if t == rec.player or t == rec.nemesis then
    return nil
  end
  if ATTR_CHATYPE ~= nil and GetChaAttr ~= nil then
    local ctype = GetChaAttr(t, ATTR_CHATYPE)
    if ctype == 2 then
      return nil
    end
  end
  return t
end

local function tick_active(role)
  local rec = Nemesis.state.active_by_player[role]
  if rec == nil then
    return
  end

  if not is_living(rec.nemesis) then
    clear_active_record(rec)
    if Nemesis.cfg.apply_cooldown_on_despawn then
      set_cooldown(rec.player_id)
    end
    return
  end

  if not in_target_map(role) then
    clear_player_active(role, true)
    if Nemesis.cfg.apply_cooldown_on_despawn then
      set_cooldown(rec.player_id)
    end
    notice(role, Nemesis.cfg.notice_left_map)
    return
  end

  local owner_close = is_near(rec.nemesis, role, Nemesis.cfg.engage_player_distance or 900) == 1
  local current_target = nil
  if GetChaTarget ~= nil then
    current_target = GetChaTarget(rec.nemesis)
  end

  if owner_close then
    if current_target ~= role then
      SetChaTarget(rec.nemesis, role)
    end
  else
    if not is_living(current_target) or current_target == role then
      local farm_target = pick_farm_target(rec)
      if is_living(farm_target) then
        SetChaTarget(rec.nemesis, farm_target)
      else
        SetChaTarget(rec.nemesis, 0)
      end
    end
  end

  if is_near(rec.nemesis, role, Nemesis.cfg.leash_distance) ~= 1 then
    local x, y = GetChaPos(role)
    local nx = x + (120 - Rand(240))
    local ny = y + (120 - Rand(240))
    ChaMove(rec.nemesis, nx, ny)
  end
end

local function handle_player_death(dead_role)
  local rec = Nemesis.state.active_by_player[dead_role]
  if rec == nil then
    return
  end

  local killer = resolve_killer(dead_role)
  if killer == rec.nemesis then
    apply_money(dead_role, -math.abs(Nemesis.cfg.penalty_gold_on_player_death or 0))
    notice(dead_role, Nemesis.cfg.notice_penalty)
    set_cooldown(rec.player_id)
    clear_player_active(dead_role, true)
  end
end

local function handle_nemesis_death(dead_nemesis)
  local rec = Nemesis.state.player_by_nemesis[dead_nemesis]
  if rec == nil then
    return
  end

  local killer = Nemesis.state.last_player_attacker_by_nemesis[dead_nemesis]
  if not valid_char(killer) then
    killer = resolve_killer(dead_nemesis)
  end
  local owner = rec.player

  if valid_char(owner) then
    if killer == owner then
      if Nemesis.cfg.give_reward_only_to_owner then
        apply_money(owner, math.abs(Nemesis.cfg.reward_gold_on_player_kill or 0))
        apply_exp(owner, math.abs(Nemesis.cfg.reward_exp_on_player_kill or 0))
      end
      notice(owner, Nemesis.cfg.notice_reward)
    else
      notice(owner, Nemesis.cfg.notice_other_kill)
    end
  end

  set_cooldown(rec.player_id)
  clear_active_record(rec)
end

function Nemesis.AfterCastSkill(_, atker, defer, skill, lv)
  if atker == nil or defer == nil then
    return
  end

  local rec = Nemesis.state.player_by_nemesis[defer]
  if rec ~= nil and IsPlayer(atker) == 1 then
    Nemesis.state.last_player_attacker_by_nemesis[defer] = atker
  end
end

function Nemesis.AfterEnterMap(_, role)
  ensure_spawn(role)
end

function Nemesis.BeforeLeaveMap(_, role)
  clear_player_active(role, true)
end

function Nemesis.OnPlayerTick(_, role)
  if IsPlayer(role) ~= 1 then
    return
  end

  if in_target_map(role) then
    ensure_spawn(role)
    tick_active(role)
  else
    tick_active(role)
  end
end

function Nemesis.OnDeath(_, role)
  if role == nil then
    return
  end

  if Nemesis.state.active_by_player[role] ~= nil then
    handle_player_death(role)
    return
  end

  if Nemesis.state.player_by_nemesis[role] ~= nil then
    handle_nemesis_death(role)
  end
end

-- Debug helper: &lua Nemesis_ForceSpawn("PlayerName")
function Nemesis_ForceSpawn(player_name)
  local role = GetPlayerByName(player_name)
  if role == nil then
    return
  end
  if in_target_map(role) then
    clear_player_active(role, true)
    spawn_near_player(role)
  else
    SystemNotice(role, "[Nemesis] You must be in Garner.")
  end
end

Hook:AddPostHook("AfterEnterMap", Nemesis.AfterEnterMap, 50)
Hook:AddPostHook("BeforeLeaveMap", Nemesis.BeforeLeaveMap, 50)
Hook:AddPostHook("OnDeath", Nemesis.OnDeath, 50)
Hook:AddPostHook("cha_timer", Nemesis.OnPlayerTick, 50)
Hook:AddPostHook("AfterCastSkill", Nemesis.AfterCastSkill, 50)
