Citizen.CreateThread(function() --About Menu
	local lastSelectionaboutMenu = 1
	while true do

		if (aboutMenu) then
			
			if not IsDisabledControlPressed(1, 173) and not IsDisabledControlPressed(1, 172) then
				currentOption = lastSelectionaboutMenu
			else
				lastSelectionaboutMenu = currentOption
			end
		
			TriggerEvent("FMODT:Title", "~y~" .. AboutTitle)

			TriggerEvent("FMODT:Option", "~p~" .. VersionTitle .. " " .. Version .. "", function(cb)
				if (cb) then
					drawNotification("~p~~italic~" .. VersionTitle .. " " .. Version .. "")
				end
			end)

			TriggerEvent("FMODT:Option", "~f~Gobernacion TumberosRP: ~bold~Diosito", function(cb)
				if (cb) then
					drawNotification("~f~~italic~Gobernacion TumberosRP: ~bold~Diosito (aka Neizi)")
				end
			end)

			TriggerEvent("FMODT:Option", "~g~" .. MenuBaseTitle .. ": ~bold~TumberosRP", function(cb)
				if (cb) then
					drawNotification("~g~~italic~" .. MenuBaseTitle .. ": ~bold~Diosito (aka Neizi)")
				end
			end)

			TriggerEvent("FMODT:Option", "~r~" .. FoundAnyBugTitle .. "? " .. ContactMeTitle .. "!", function(cb)
				if (cb) then
					drawNotification("~r~~italic~" .. FoundAnyBugTitle .. "? " .. ContactMeTitle .. "!")
				end
			end)

			TriggerEvent("FMODT:Option", "~y~www.TumberosRP.com", function(cb)
				if (cb) then
					drawNotification("~y~~italic~www.TumberosRP.com")
				end
			end)

			TriggerEvent("FMODT:Update")
		end

		Citizen.Wait(0)
	end
end)

