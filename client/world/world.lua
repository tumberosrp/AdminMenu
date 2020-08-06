local explodevehicles = false; 
	  jumpmode = false; nonpcstraffic = false

Citizen.CreateThread(function() --World Menu
	while true do
		if (worldMenu) then
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionworldMenu
			else
				lastSelectionworldMenu = currentOption
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. WorldMenuTitle)



			TriggerEvent("FMODT:Bool", ExplodeNearestVehicleTitle, explodevehicles, function(cb)
				explodevehicles = cb
				if explodevehicles then
					if jumpmode then
						jumpmode = false
					end
					drawNotification("~g~" .. ExplodeNearestVehicleEnableMessage .. "!")
				else
					drawNotification("~r~" .. ExplodeNearestVehicleDisableMessage .. "!")
				end
			end)

			TriggerEvent("FMODT:Bool", JumpModeTitle, jumpmode, function(cb)
				jumpmode = cb
				if jumpmode then
					if explodevehicles then
						explodevehicles = false
					end
					drawNotification("~g~" .. JumpModeEnableMessage .. "!")
				else
					drawNotification("~r~" .. JumpModeDisableMessage .. "!")
				end
			end)

	
			
		

			
		
			TriggerEvent("FMODT:Update")
		end

		Citizen.Wait(0)
	end
end)




Citizen.CreateThread(function() --Explode Nearest Vehicle
	while true do
		Citizen.Wait(0)
		local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(GetVehiclePedIsIn(GetPlayerPed(-1), false))
		local explode
		if explodevehicles and allowed then
			for vehicle in EnumerateVehicles() do
				if (vehicle ~= GetVehiclePedIsIn(GetPlayerPed(-1), false)) and (not GotTrailer or (GotTrailer and vehicle ~= TrailerHandle)) then
					NetworkRequestControlOfEntity(vehicle)
					NetworkExplodeVehicle(vehicle, true, true, false)
				end
			end
		end
	end
end)



Citizen.CreateThread(function() --Jump Mode Audio
    while true do
        Citizen.Wait(0)
		if jumpmode and allowed then	
			SendNUIMessage({
				stopJumpMode = false,
			})
			SendNUIMessage({
				playJumpMode = true,
			})
		else
			SendNUIMessage({
				playJumpMode = false,
			})
			SendNUIMessage({
				stopJumpMode = true,
			})
		end
	end
end)

Citizen.CreateThread(function() --Jump Mode
    while true do
        Citizen.Wait(0)
		if jumpmode and allowed then	
			for vehicle in EnumerateVehicles() do
				if vehicle ~= GetVehiclePedIsIn(GetPlayerPed(-1), false) and vehicle ~= GetVehiclePedIsTryingToEnter(GetPlayerPed(-1)) then
					if IsVehicleOnAllWheels(vehicle) then
						ApplyForceToEntity(vehicle, 1, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0, 1, true, true, true, true, true)
						SetEntityAsNoLongerNeeded(vehicle)
					end
				end
			end
		end
	end
end)





