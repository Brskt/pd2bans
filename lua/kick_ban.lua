_G.PD2Bans = _G.PD2Bans or {}

if RequiredScript == "lib/network/handlers/unitnetworkhandler" then
	--Kick him when he is joining
	Hooks:Add("NetworkManagerOnPeerAdded", "NetworkManagerOnPeerAdded_CheaterList", function(peer, peer_id)
		if Network:is_server() and PD2Bans then
			DelayedCalls:Add("DelayedModCheaterList" .. tostring(peer_id), 1, function()
				if peer then
					local _user_id = tostring(peer:user_id())
					if PD2Bans.Ban_list_SteamID64[_user_id] then
						managers.network:session():on_peer_kicked(peer, peer:id(), 0)
						managers.network:session():send_to_peers("kick_peer", peer:id(), 2)
					end
				end
			end)
		end
	end)
end

if RequiredScript == "lib/network/matchmaking/networkmatchmakingsteam" then
	--Banned his lobby
	local _is_server_ok_orgg = NetworkMatchMakingSTEAM.is_server_ok
	function NetworkMatchMakingSTEAM:is_server_ok(friends_only, room, ...)
		if PD2Bans.Ban_list_SteamID64[room] then
			return false
		end
		return _is_server_ok_orgg(self, friends_only, room, ...)
	end
end