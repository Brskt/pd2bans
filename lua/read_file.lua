_G.PD2Bans = _G.PD2Bans or {}

PD2Bans.Ban_list_SteamID64 = PD2Bans.Ban_list_SteamID64 or {}
PD2Bans.ModPath = ModPath
PD2Bans.Old_Name = PD2Bans.Old_Name or {}
PD2Bans.Old_Steam = PD2Bans.Old_Steam or {}

function PD2Bans:RefreshList(_cleanall)
	if not _G or not _G.PD2Bans or not PD2Bans then
		return
	end
	if _cleanall then
		PD2Bans.Ban_list_SteamID64 = {}
		PD2Bans.Old_Name = {}
		PD2Bans.Old_Steam = {}
	end
	local _file, err = io.open(PD2Bans.ModPath .. "/list/cheaterlist.ini", "r")
	if not _file then
		return
	end	
	local line = _file:read()
	local _txt = tostring(line)
	local count = 0
	while line do
		count = count + 1
		if not PD2Bans.Ban_list_SteamID64[_txt] then
			PD2Bans.Ban_list_SteamID64[_txt] = count
		end
		line = _file:read()
		_txt = tostring(line)
	end	
	_file:close()
end

function PD2Bans:WriteIntoList(data)
	if data == nil or not data then
		return
	end
	local _file = io.open(PD2Bans.ModPath .. "/list/cheaterlist.ini", "a")
	if not _file then
		return false
	end
	_file:write("" .. data, "\n")
	_file:close()
	PD2Bans:RefreshList(false)
	if managers.hud and managers.network then
		local peers = managers.network:session():peers() or {}
		local reason = ""
		local _txt = ""
		for k, v in pairs(peers) do
			if v then
				_txt = tostring(v:user_id())
			end
			if PD2Bans.Ban_list_SteamID64[_txt] then
				reason = v:name() .. " is in your cheater list"
				managers.chat:feed_system_message(ChatManager.GAME, reason, ""	)
				managers.hud:mark_cheater(v:id())
			end
		end
	end
end

PD2Bans:RefreshList(true)