local QBCore = exports['qb-core']:GetCoreObject()
local scoreboardOpen = false
local playerOptin = {}
local IllegalActionsName = {}

local playMinute, playHour = 0, 0

Config.IllegalActions = Config.IllegalActions or {}
Config.availableJobs = Config.availableJobs or {}

-- Functions

local function DrawText3D(x, y, z, text)
	SetTextScale(0.55, 0.55)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(167, 112, 253, 255)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    ClearDrawOrigin()
end

local function GetPlayers()
    local players = {}
    local activePlayers = GetActivePlayers()
    for i = 1, #activePlayers do
        local player = activePlayers[i]
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            players[#players+1] = player
        end
    end
    return players
end

local function GetPlayersFromCoords(coords, distance)
    local players = GetPlayers()
    local closePlayers = {}

	coords = coords or GetEntityCoords(PlayerPedId())
    distance = distance or  5.0

    for i = 1, #players do
        local player = players[i]
		local target = GetPlayerPed(player)
		local targetCoords = GetEntityCoords(target)
		local targetdistance = #(targetCoords - vector3(coords.x, coords.y, coords.z))
		if targetdistance <= distance then
            closePlayers[#closePlayers+1] = player
		end
    end

    return closePlayers
end


-- Events

RegisterNetEvent('qb-scoreboard:client:SetActivityBusy', function(activity, busy)
    local action = Config.IllegalActions[IllegalActionsName[activity]]
    if action then
        action.busy = busy
    end
end)


-- Command

if Config.Toggle then
    RegisterCommand('scoreboard', function()
        if not scoreboardOpen then
            QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetScoreboardData', function(players, cops, jobs, playerList)
                playerOptin = playerList

                SendNUIMessage({
                    action = "open",
                    PlayerId = GetPlayerServerId(PlayerId()),
                    players = players,
                    maxPlayers = Config.MaxPlayers,
                    IllegalActions = Config.IllegalActions,
                    currentCops = cops,
                    availableJobs = jobs,
                    playTime = string.format("%02dh %02dm", playHour, playMinute),
                })

                scoreboardOpen = true
            end)
        else
            SendNUIMessage({
                action = "close",
            })

            scoreboardOpen = false
        end
    end, false)

    RegisterKeyMapping('scoreboard', 'Open Scoreboard', 'keyboard', Config.OpenKey)
else
    RegisterCommand('+scoreboard', function()
        if scoreboardOpen then return end
        QBCore.Functions.TriggerCallback('qb-scoreboard:server:GetScoreboardData', function(players, cops, jobs, playerList)
            playerOptin = playerList

            SendNUIMessage({
                action = "open",
                PlayerId = GetPlayerServerId(PlayerId()),
                players = players,
                maxPlayers = Config.MaxPlayers,
                IllegalActions = Config.IllegalActions,
                currentCops = cops,
                availableJobs = jobs,
                playTime = string.format("%02dh %02dm", playHour, playMinute),
            })

            scoreboardOpen = true
        end)
    end, false)

    RegisterCommand('-scoreboard', function()
        if not scoreboardOpen then return end
        SendNUIMessage({
            action = "close",
        })

        scoreboardOpen = false
    end, false)

    RegisterKeyMapping('+scoreboard', 'Open Scoreboard', 'keyboard', Config.OpenKey)
end


-- Threads

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000 * 60) -- every minute
		playMinute = playMinute + 1
        
        while playMinute == 60 do
            playMinute = 0
            playHour = playHour + 1
        end
	end
end)

CreateThread(function()
    Wait(1000)
    local actions = {}
    local availableJobs = {}
    local illegalActions = Config.IllegalActions or {}
    local jobList = Config.availableJobs or {}

    for k, v in pairs(illegalActions) do
        actions[k] = {v.name, v.label}
        IllegalActionsName[v.name] = k
    end

    for k, v in pairs(jobList) do
        availableJobs[k] = {v.name, v.label}
    end

    SendNUIMessage({
        action = 'setup',
        creminalJobs = actions,
        availableJobs = availableJobs
    })
end)

CreateThread(function()
    while true do
        local loop = 100
        if scoreboardOpen then
            for _, player in pairs(GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), 10.0)) do
                local playerId = GetPlayerServerId(player)
                local playerPed = GetPlayerPed(player)
                local playerCoords = GetEntityCoords(playerPed)
                if Config.ShowIDforALL or (playerOptin[playerId] and playerOptin[playerId].optin) then
                    loop = 0
                    DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.0, playerId)
                end
            end
        end
        Wait(loop)
    end
end)