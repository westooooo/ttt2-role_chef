CreateConVar("ttt2_chef_cooking_heal", "50", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Chef's cooking health regen")
CreateConVar("ttt2_chef_cooking_delay", "90", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Delay before the Chef's cooking begins to heal survivors")
CreateConVar("ttt2_chef_cooking_maxhealth", "100", {FCVAR_NOTIFY, FCVAR_ARCHIVE}, "Chef's Cooking max health")

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_dynamic_chef_convars", function(tbl)
  tbl[ROLE_CHEF] = tbl[ROLE_CHEF] or {}

  table.insert(tbl[ROLE_CHEF], {
    cvar = "ttt2_chef_cooking_heal",
    slider = true,
    min = 10,
    max = 100,
    desc = "ttt2_chef_cooking_heal (def. 50)"
  })

  table.insert(tbl[ROLE_CHEF], {
    cvar = "ttt2_chef_cooking_delay",
    slider = true,
    min = 30,
    max = 300,
    desc = "ttt2_chef_cooking_delay (def. 90)"
  })
  
    table.insert(tbl[ROLE_CHEF], {
    cvar = "ttt2_chef_cooking_maxhealth",
    slider = true,
    min = 100,
    max = 300,
    desc = "ttt2_chef_cooking_maxhealth (def. 100)"
  })

end)
