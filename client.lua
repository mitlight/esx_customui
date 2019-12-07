--[[
	file: client.lua
	resource: esx_customui
	author: Newtonsoft.Json
	contact: https://steamcommunity.com/id/Newtonsoft_Json/
	warning: หากนำไปขายต่อหรือแจกจ่าย หรือใช้ร่วมกันเกิน 1 server จะถูกยกเลิก license ทันที !!
]]

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local status = nil
local r,g,b,a = 30,136,229,255 -- สี R G B
local voice = {default = 7.0, shout = 20.0, whisper = 1.5, current = 0} -- ร ะ ย ะ ไ ม ค์

---------------------------------
--- ห ล อ ด ค ว า ม เ ห นื่ อ ย ---
---------------------------------
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(100)
        
        SendNUIMessage({
            show = IsPauseMenuActive(),
            health = (GetEntityHealth(GetPlayerPed(-1))-100),
            stamina = 100-GetPlayerSprintStaminaRemaining(PlayerId()),
            st = status,
        })
    end
end)
------------
-- E N D ---
------------

-------------------------
--- ห ล อ ด อ า ห า ร ---
-------------------------
RegisterNetEvent('esx_customui:updateStatus')
AddEventHandler('esx_customui:updateStatus', function(Status)
    status = Status
    SendNUIMessage({
        action = "updateStatus",
        st = Status,
    })
end)
------------
-- E N D ---
------------

-----------------------
--- ห ล อ ด เ ลื อ ด ---
-----------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(10)
     local ped = GetPlayerPed(-1)
     local health = GetEntityHealth(ped)
     local armor = GetPedArmour(ped)
     SendNUIMessage({
        heal = health,
        armor = armor
     });
  end
end)
------------
-- E N D ---
------------

---------------------------------------
--- ทำ ง า น เ มื่ อ เ ซิ ฟ เ ว อ ร์ เ ริ่ ม ---
---------------------------------------
AddEventHandler('onClientMapStart', function()
  NetworkSetTalkerProximity(voice.default)
end)
------------
-- E N D ---
------------

----------------------------
--- ร ะ บ บ เ สี ย ง ห ลั ก ---
----------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local coords = GetEntityCoords(PlayerPedId())
    if IsControlJustPressed(0, Keys['H']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
      voice.current = (voice.current + 1) % 3
      if voice.current == 0 then
        NetworkSetTalkerProximity(voice.default)
        SendNUIMessage({voiceheal = 50});
      elseif voice.current == 1 then
        NetworkSetTalkerProximity(voice.shout)
        SendNUIMessage({voiceheal = 100});
      elseif voice.current == 2 then
        NetworkSetTalkerProximity(voice.whisper)
        SendNUIMessage({voiceheal = 25});
      end
    end
    if IsControlJustPressed(0, Keys['H']) and IsControlPressed(1, Keys['LEFTSHIFT']) then
      if voice.current == 0 then
        voiceS = voice.default
      elseif voice.current == 1 then
        voiceS = voice.shout
      elseif voice.current == 2 then
        voiceS = voice.whisper
      end
      Marker(1, coords.x, coords.y, coords.z, voiceS * 2.0)
    end
    if NetworkIsPlayerTalking(PlayerId()) then
      SendNUIMessage({talking = true})
    elseif not NetworkIsPlayerTalking(PlayerId()) then
      SendNUIMessage({talking = false})
    end
  end
end)
------------
-- E N D ---
------------

------------------
--- อ ย่ า แ ต ะ ---
------------------
function Marker(type, x, y, z, voiceS)
  DrawMarker(type, x, y, z - 1.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, voiceS, voiceS, 1.0, r, g, b, a, false, true, 2, false, false, false, false)
end
------------
-- E N D ---
------------