local LastGameTimer; noclipmode = false; isRadarExtended = false; isScoreboardShowing = false
local fps = 0; prevframes = 0; curframes = 0; prevtime = 0; curtime = 0; player = -1, radioname
speedoDefault = 1; autoparachute = true; heatvision = false; nightvision = false; CoordsOverMap = true
HideHUD = false; HideRadar = false; HideHUDCount = 0; freezeradio = false; nocinecam = true; 
dfps = true; simpleSpeedo = true; RadioFreezePosition = 1

Citizen.CreateThread(function() --Misc Menu
	local allowNoClip = false
	
	while true do
		if (miscMenu) then
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionmiscMenu
			else
				lastSelectionmiscMenu = currentOption
			end
		
			if WorldAndNoClipOnlyAdmins then if IsAdmin then allowNoClip = true end else allowNoClip = true end
			
			
			
			TriggerEvent("FMODT:Title", "~y~" .. MiscMenuTitle)

			TriggerEvent("FMODT:Bool", AlwaysParachuteTitle, autoparachute, function(cb)
				autoparachute = cb
				if autoparachute then
					drawNotification("~g~" .. AlwaysParachuteEnableMessage .. "!")
				else
					drawNotification("~r~" .. AlwaysParachuteDisableMessage .. "!")
				end
			end)

		

			TriggerEvent("FMODT:Bool", CoordsOverMapTitle, CoordsOverMap, function(cb)
				CoordsOverMap = cb
				if CoordsOverMap then
					drawNotification("~g~" ..CoordsOverMapEnableMessage  .. "!")
				else
					drawNotification("~r~" .. CoordsOverMapDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", DisableCinematicCamButtonTitle, nocinecam, function(cb)
				nocinecam = cb
				if nocinecam then
					drawNotification("~g~" .. DisableCinematicCamButtonDisableMessage .. "!")
				else
					drawNotification("~r~" .. DisableCinematicCamButtonEnableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", DrawFPSTitle, dfps, function(cb)
				dfps = cb
				if dfps then
					drawNotification("~g~" .. DrawFPSEnableMessage .. "!")
				else
					drawNotification("~r~" .. DrawFPSDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", HeatvisionTitle, heatvision, function(cb)
				heatvision = cb
				if heatvision then
					nightvision = false
					drawNotification("~g~" .. HeatvisionEnableMessage .. "!")
				else
					drawNotification("~r~" .. HeatvisionDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", HideHUDRadarTitle, HideHUD, function(cb)
				HideHUD = cb
				if HideHUD then
					HideHUDCount = 1
					drawNotification("~g~" .. HideHUDRadarEnableMessage .. "!")
				else
					HideHUDCount = 0
					drawNotification("~r~" .. HideHUDRadarDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", HideOnlyRadarTitle, HideRadar, function(cb)
				HideRadar = cb
				if HideRadar then
					drawNotification("~g~" .. HideOnlyRadarEnableMessage .. "!")
				else
					drawNotification("~r~" .. HideOnlyRadarDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", NightvisionTitle, nightvision, function(cb)
				nightvision = cb
				if nightvision then
					heatvision = false
					drawNotification("~g~" .. NightvisionEnableMessage .. "!")
				else
					drawNotification("~r~" .. NightvisionDisableMessage .. "!")
				end
			end)

			if allowNoClip then
				TriggerEvent("FMODT:Bool", NoClipModeTitle, noclipmode, function(cb)
					noclipmode = cb
					if noclipmode then
						HideHUD = true
						drawNotification("~g~" .. NoClipModeEnableMessage .. "!")
					else
						if (HideHUDCount == 0) then HideHUD = false end
						ResetPedRagdollBlockingFlags(GetPlayerPed(-1), 2)
						ResetPedRagdollBlockingFlags(GetPlayerPed(-1), 3)
						SetEntityCollision(GetPlayerPed(-1), true, true)
						FreezeEntityPosition(GetPlayerPed(-1), false)
						drawNotification("~r~" .. NoClipModeDisableMessage .. "!")
					end
				end)
			end


			TriggerEvent("FMODT:Option", "~y~>> ~s~" .. SpeedometerTitle, function(cb)
				if (cb) then
					miscMenu = false
					speedoMenu = true
				end
			end)

			TriggerEvent("FMODT:Update")
		end

		Citizen.Wait(0)
	end
end)



Citizen.CreateThread(function() --Speedometer Menu
	local speedoUnitArray = {"KM/H", "MPH"}
	while true do
		if (speedoMenu) then
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionspeedoMenu
			else
				lastSelectionspeedoMenu = currentOption
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. SpeedometerTitle)

			TriggerEvent("FMODT:Bool", SimpleSpeedometerTitle, simpleSpeedo, function(cb)
				simpleSpeedo = cb
				if simpleSpeedo then
					drawNotification("~g~" .. SimpleSpeedometerEnableMessage .. "!")
				else
					drawNotification("~r~" .. SimpleSpeedometerDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:StringArray", UnitTitle .. ":", speedoUnitArray, speedoDefault, function(cb)
				speedoDefault = cb
			end)

			TriggerEvent("FMODT:Update")
		end
		
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function() --Always Parachute
	while true do
		Citizen.Wait(0)
		if autoparachute and allowed then
			GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("gadget_parachute"), 1, false, false)
		end
	end
end)

Citizen.CreateThread(function() --PvP
	while true do
		Citizen.Wait(0)
		if allowed then
			if PvP then
				SetCanAttackFriendly(GetPlayerPed(-1), true, false)
				NetworkSetFriendlyFireOption(true)
			else
				SetCanAttackFriendly(GetPlayerPed(-1), false, false)
				NetworkSetFriendlyFireOption(false)
			end
		end
	end
end)


Citizen.CreateThread(function() --Count FPS (Thanks To siggyfawn [forum.FiveM.net])
	while not NetworkIsPlayerActive(PlayerId()) or not NetworkIsSessionStarted() do
		Citizen.Wait(0)
		prevframes = GetFrameCount()
		prevtime = GetGameTimer()
	end

	while true do
		Citizen.Wait(0)
		curtime = GetGameTimer()
		curframes = GetFrameCount()

	    if((curtime - prevtime) > 1000) then
			fps = (curframes - prevframes) - 1				
			prevtime = curtime
			prevframes = curframes
	    end
	end
end)

Citizen.CreateThread(function() --Draw FPS
    while true do
        Citizen.Wait(0)
		if dfps and allowed then
			if fps == 0 or fps > 1000 then
				Draw(FPSCountFailed, 255, 0, 0, 127, 0.95, 0.97, 0.35, 0.35, 1, true, 0)
			elseif fps >= 1 and fps <= 29 then
				Draw("" .. fps .. "", 255, 0, 0, 127, 0.99, 0.97, 0.35, 0.35, 1, true, 0)
				_DrawRect(0.99, 0.984, 0.0175, 0.025, 0, 0, 0, 127, 0)
			elseif fps >=30 and fps <= 49 then
				Draw("" .. fps .. "", 255, 255, 0, 127, 0.99, 0.97, 0.35, 0.35, 1, true, 0)
				_DrawRect(0.99, 0.984, 0.0175, 0.025, 0, 0, 0, 127, 0)
			elseif fps >= 50 then
				Draw("" .. fps .. "", 0, 255, 0, 127, 0.99, 0.97, 0.35, 0.35, 1, true, 0)
				_DrawRect(0.99, 0.984, 0.0175, 0.025, 0, 0, 0, 127, 0)
			end
		end
	end
end)

Citizen.CreateThread(function() --Simple Speedometer
	local x
	local speed
	local unit
    while true do
        Citizen.Wait(0)
		if simpleSpeedo and allowed then
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				if isRadarExtended then
					x = 0.290
				else
					x = 0.205
				end
				if speedoDefault == 1 then
					speed = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6)
					unit = "KM/H"
				else
					speed = math.ceil(GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 2.236936)
					unit = "MPH"
				end
				_DrawRect(x, 0.964, 0.07, 0.04, 0, 0, 0, 127, 0)
				Draw(speed .. " " .. unit, 255, 255, 255, 127, x, 0.95, 0.4, 0.4, 1, true, 0)
			end
		end
	end
end)

Citizen.CreateThread(function() --Heatvision, Nightvision, Hide HUD, Hide Radar, Coords Over Map
	while true do
		Citizen.Wait(0)
		if allowed then	
			SetSeethrough(heatvision)
			SetNightvision(nightvision)
			DisplayRadar(not HideRadar)
			if HideHUD then
				HideHudAndRadarThisFrame()
			end
			if CoordsOverMap then
				local playerPos = GetEntityCoords(GetPlayerPed(-1))
				local playerHeading = GetEntityHeading(GetPlayerPed(-1))
				if isRadarExtended then	
					Draw("X: " .. math.ceil(playerPos.x) .." Y: " .. math.ceil(playerPos.y) .." Z: " .. math.ceil(playerPos.z) .." Heading: " .. math.ceil(playerHeading) .."", 0, 0, 0, 255, 0.0175, 0.53, 0.378, 0.378, 1, false, 1)
				else
					Draw("X: " .. math.ceil(playerPos.x) .." Y: " .. math.ceil(playerPos.y) .." Z: " .. math.ceil(playerPos.z) .." Heading: " .. math.ceil(playerHeading) .."", 0, 0, 0, 255, 0.0175, 0.76, 0.378, 0.378, 1, false, 1)
				end
			end
		end
	end
end)

Citizen.CreateThread(function() --No Clip Mode (Miscellaneous)
	while true do
		Citizen.Wait(0)

		if noclipmode and allowed then
			SetEntityCollision(GetPlayerPed(-1), false, false)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			Citizen.InvokeNative(0x0AFC4AF510774B47)
			if not IsControlPressed(1, 32) and not IsControlPressed(1, 33) and not IsControlPressed(1, 90) and not IsControlPressed(1, 89) then
				FreezeEntityPosition(GetPlayerPed(-1), true)
			end
		end
	end
end)

Citizen.CreateThread(function() --No Clip Mode (Forward/ Backward)
	while true do
		Citizen.Wait(0)

		if noclipmode and allowed then
			local coords = GetEntityForwardVector(GetPlayerPed(-1))
			if IsControlPressed(1, 32) then --Forward
				FreezeEntityPosition(GetPlayerPed(-1), false)
				ApplyForceToEntity(GetPlayerPed(-1), 1, coords.x * 3, coords.y * 3, 0.27, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			elseif IsControlPressed(1, 33) then --Backward
				FreezeEntityPosition(GetPlayerPed(-1), false)
				ApplyForceToEntity(GetPlayerPed(-1), 1, coords.x * -3, coords.y * -3, 0.27, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			end
		end
	end
end)

Citizen.CreateThread(function() --No Clip Mode (Up/ Down)
	while true do
		Citizen.Wait(0)

		if noclipmode and allowed then
			if IsControlPressed(1, 52) then --Up
				FreezeEntityPosition(GetPlayerPed(-1), false)
				ApplyForceToEntity(GetPlayerPed(-1), 1, 0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			elseif IsControlPressed(1, 86) then --Down
				FreezeEntityPosition(GetPlayerPed(-1), false)
				ApplyForceToEntity(GetPlayerPed(-1), 1, 0.0, 0.0, -5.0, 0.0, 0.0, 0.0, 1, false, true, true, true, true)
			end
		end
	end
end)

Citizen.CreateThread(function() --No Clip Mode (Rotation)
	while true do
		Citizen.Wait(0)
		local camRot = GetGameplayCamRot(5)
		if noclipmode and allowed then
			SetEntityRotation(GetPlayerPed(-1), 0.0, 0.0, camRot.z, 1, true)
		end
	end
end)

Citizen.CreateThread(function() --Cinematic Cam Disabled
	while true do
		Citizen.Wait(0)
		if allowed then
			if nocinecam then
				SetCinematicButtonActive(false)
			else
				SetCinematicButtonActive(true)
			end
		end
	end
end)













