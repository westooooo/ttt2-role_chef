-- Icon Materials

if SERVER then
	AddCSLuaFile()
	resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_chef.vmt")
end

-- General settings
function ROLE:PreInitialize()
	self.color = Color(245, 170, 000, 255) -- role colour

	-- settings for the role iself
	self.abbr = "chef"                      -- Abbreviation
	self.survivebonus = 1                   -- points for surviving longer
	self.preventFindCredits = true          -- can't take credits from bodies
	self.preventKillCredits = true		    -- does not get awarded credits for kills
	self.preventTraitorAloneCredits = true  -- no credits.
	self.preventWin = false                 -- cannot win unless he switches roles
	self.scoreKillsMultiplier       = 2     -- gets points for killing enemies of their team
	self.scoreTeamKillsMultiplier   = -8    -- loses points for killing teammates
	self.defaultEquipment = INNO_EQUIPMENT  -- here you can set up your own default equipment
	self.disableSync = true 			    -- dont tell the player about his role

	-- settings for this roles teaminteraction
	self.unknownTeam = true -- Doesn't know his teammates -> Is innocent also disables voicechat
	self.defaultTeam = TEAM_INNOCENT -- Is part of team innocent

	-- ULX convars
	self.conVarData = {
		pct = 0.17,                         -- necessary: percentage of getting this role selected (per player)
		maximum = 1,                        -- maximum amount of roles in a round
		minPlayers = 8,                     -- minimum amount of players until this role is able to get selected
		credits = 0,                        -- the starting credits of a specific role
		shopFallback = SHOP_DISABLED,       -- Setting wether the role has a shop and who's shop it will use if no custom shop is set
		togglable = true,                   -- option to toggle a role for a client if possible (F1 menu)
		random = 33                         -- percentage of the chance that this role will be in a round (if set to 100 it will spawn in all rounds)
	}
end

function ROLE:Initialize()
	roles.SetBaseRole(self, ROLE_INNOCENT)
end

if SERVER then
	function ROLE:GiveRoleLoadout(ply, isRoleChange)
		ChefCooking(ply)
	end
	
	function ChefCooking(ply)
		if ply:GetSubRole() ~= ROLE_CHEF or not ply:Alive() or ply:IsSpec() then return end
		local CookingDoneTime = GetConVar("ttt2_chef_cooking_delay"):GetInt()
		local CookingMaxHealth = GetConVar("ttt2_chef_cooking_maxhealth"):GetInt()
		local CookingAddHealth = GetConVar("ttt2_chef_cooking_heal"):GetInt()
		timer.Create("chef-cooking" .. ply:SteamID64(), CookingDoneTime, 1, function()
			if not IsValid(ply) then return end
			for k,v in pairs(player.GetAll()) do
				if v == ply then
					v:PrintMessage( HUD_PRINTCENTER, "You served cooking for everyone!" )
				else
					v:PrintMessage( HUD_PRINTCENTER, "Chef cooked for you!" )
					local health = v:Health()
          if health <= CookingMaxHealth then
					  if health + CookingAddHealth <= CookingMaxHealth then
						  v:SetHealth(health + CookingAddHealth)
					  else
						  v:SetHealth(CookingMaxHealth)
					  end
          end
				end
			end
			ChefCooking(ply)
		end)
	end

	function ROLE:RemoveRoleLoadout(ply, isRoleChange)
		timer.Remove("chef-cooking" .. ply:SteamID64())
	end
end
