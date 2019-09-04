local Police = false
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if (GetClockHours() <= 6 or GetClockHours() >= 19) and GetPlayerWantedLevel(PlayerId()) ~= 0 then
        ClearPlayerWantedLevel(PlayerId())
    elseif (GetClockHours() >= 7 and GetClockHours() <= 18) and GetPlayerWantedLevel(PlayerId()) ~= 0 then
      if Police == true and GetPlayerWantedLevel(PlayerId()) >=3 and GetRelationshipBetweenGroups(GetHashKey("police"), GetHashKey("PLAYER")) ~= 5 then
		  SetPoliceIgnorePlayer(PlayerId(), false)
      SetRelationshipBetweenGroups(5, GetHashKey("police"), GetHashKey("PLAYER"))
      SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("police"))
      Police = false
      end      
      if Police == false and GetPlayerWantedLevel(PlayerId()) <= 2 then
      SetRelationshipBetweenGroups(4, GetHashKey("police"), GetHashKey("PLAYER"))
      SetRelationshipBetweenGroups(4, GetHashKey("PLAYER"), GetHashKey("police"))
    	SetPoliceIgnorePlayer(PlayerId(), true)
      Police = true
      end
      if Police == true and GetPlayerWantedLevel(PlayerId()) == 0 then
      SetRelationshipBetweenGroups(3, GetHashKey("police"), GetHashKey("PLAYER"))
      SetRelationshipBetweenGroups(3, GetHashKey("PLAYER"), GetHashKey("police"))
    	SetPoliceIgnorePlayer(PlayerId(), false)
      Police = false
      end
    end
  end
end)

--Custom Wanted level timer
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(math.random(15000,30000))
    if GetPlayerWantedLevel(PlayerId()) >= 3 then
    local wantedlvl = GetPlayerWantedLevel(PlayerId()) - 1
    SetPlayerWantedLevel(PlayerId(), wantedlvl, 0)
    SetPlayerWantedLevelNow(PlayerId(), 0)
    end
  end
end)

Citizen.CreateThread(function()
  local scriptload = 0
	local handsup = false
	local Droppedweapon = false
  local fists = GetHashKey("WEAPON_UNARMED")
	while true do
  local SNTG = PlayerId()
  local Ped = GetPlayerPed(SNTG)
		Citizen.Wait(0)
		RequestAnimDict("random@mugging3")
		if IsControlPressed(1, 323) then
      DisablePlayerFiring(Ped, true) -- Disable weapon firing
      DisableControlAction(1, 142, true) -- MeleeAttackAlternate
      DisableControlAction(1, 106, true) -- VehicleMouseControlOverride
      DisableControlAction(1, 23, true)  -- F	
      if DoesEntityExist(Ped) then
          while not HasAnimDictLoaded("random@mugging3") do
            Citizen.Wait(1)
          end
          if not handsup and IsPedOnFoot(GetPlayerPed(PlayerId())) then
            handsup = true
            Gun = GetSelectedPedWeapon(Ped)
            --SetRelationshipBetweenGroups(4, GetHashKey("police"), GetHashKey("PLAYER"))
            --SetRelationshipBetweenGroups(4, GetHashKey("PLAYER"), GetHashKey("police"))
            SetPoliceIgnorePlayer(PlayerId(), true)
            TaskPlayAnim(Ped, "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
            ------DISABLE CONTROLz----------
            if Gun ~= fists then
            SetPedDropsInventoryWeapon(Ped, Gun, 0, -2.5, 1, 0)
            GiveWeaponToPed(Ped, fists, 0, 0, 1) -- Disarm Ped
            end
          end
			end
		end
if scriptload < 1 then
Citizen.CreateThread(function()
  while true do 
  Wait(1000)
      if handsup == true then
      Droppedweapon = true
      Wait(20000)
      Droppedweapon = false
      end
   end
end)

  Citizen.CreateThread(function()
    while true do 
    Wait(5000)
      if Droppedweapon == true and GetPlayerWantedLevel(SNTG) > 0 and GetPlayerWantedLevel(SNTG) < 5 and IsPedArmed(Ped, 7) then
          local WLvl = GetPlayerWantedLevel(SNTG) + 1
          Wait(4000)
          SetPlayerWantedLevel(SNTG, WLvl, true)
          SetPlayerWantedLevelNow(SNTG, true)
      end
    end
  end)
  scriptload = scriptload + 1
end
		if IsControlReleased(1, 323) then
			if DoesEntityExist(Ped) then
          RequestAnimDict("random@mugging3")
          while not HasAnimDictLoaded("random@mugging3") do
            Citizen.Wait(100)
          end
          if handsup then
            handsup = false
            ClearPedSecondaryTask(Ped)  
            --SetRelationshipBetweenGroups(4, GetHashKey("police"), GetHashKey("PLAYER"))
            --SetRelationshipBetweenGroups(4, GetHashKey("PLAYER"), GetHashKey("police"))
            SetPoliceIgnorePlayer(PlayerId(), false)  
          end
			end
		end
	end
end)```
