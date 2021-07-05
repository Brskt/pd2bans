_G.PD2Bans = _G.PD2Bans or {}

Hooks:PostHook(HUDManager, "set_teammate_name", "CheaterListPostHUDManagerset_teammate_name", function(hud, i, teammate_name)
	local peer_id0 = managers.network:session():peer(i)
	if not peer_id0 or peer_id0 == managers.network:session():local_peer() then
		return
	end
	local _user_id = tostring(peer_id0:user_id())
	if PD2Bans.Ban_list_SteamID64[_user_id] then
		local reason = "'" .. peer_id0:name() .. "' [".. _user_id .."] is in your cheater list"
		managers.chat:feed_system_message(ChatManager.GAME, reason, ""	)
		managers.hud:mark_cheater(i)
	end	
end )