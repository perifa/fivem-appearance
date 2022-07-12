local config = {

	shops = {

		clothing = {
			vec(72.3, -1399.1, 28.4),
			vec(-708.71, -152.13, 36.4),
			vec(-165.15, -302.49, 38.6),
			vec(428.7, -800.1, 28.5),
			vec(-829.4, -1073.7, 10.3),
			vec(-1449.16, -238.35, 48.8),
			vec(11.6, 6514.2, 30.9),
			vec(122.98, -222.27, 53.5),
			vec(1696.3, 4829.3, 41.1),
			vec(618.1, 2759.6, 41.1),
			vec(1190.6, 2713.4, 37.2),
			vec(-1193.4, -772.3, 16.3),
			vec(-3172.5, 1048.1, 19.9),
			vec(-1108.4, 2708.9, 18.1)
			-- add 4th argument to create vector4 and disable blip
			-- ex: vec(0.0, 0.0, 0.0, 0.0)
		},

		barber = {
			vec(-814.3, -183.8, 36.6),
			vec(136.8, -1708.4, 28.3),
			vec(-1282.6, -1116.8, 6.0),
			vec(1931.5, 3729.7, 31.8),
			vec(1212.8, -472.9, 65.2),
			vec(-34.31, -154.99, 55.8),
			vec(-278.1, 6228.5, 30.7)
		},

		tattoos = {
			vec(1322.6, -1651.9, 51.2),
			vec(-1153.6, -1425.6, 4.9),
			vec(322.1, 180.4, 103.5),
			vec(-3170.0, 1075.0, 20.8),
			vec(1864.6, 3747.7, 33.0),
			vec(-293.7, 6200.0, 31.4)
		}

	},

    clothing = {
		components = true,
		props = true
	},

	barber = {
		headOverlays = true
	},

    tattoos = {
        tattoos = true
    }

}

local function CreateBlip(name, sprite, colour, scale, location)
	if not location.w then
		local blip = AddBlipForCoord(location.x, location.y)
		SetBlipSprite(blip, sprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, scale)
		SetBlipColour(blip, colour)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(name)
		EndTextCommandSetBlipName(blip)
	end
end

CreateThread(function()

	for i = 1, #config.shops.clothing do
		CreateBlip('Loja de roupas', 73, 47, 0.7, config.shops.clothing[i])
	end

	for i = 1, #config.shops.barber do
		CreateBlip('Barbearia', 71, 47, 0.7, config.shops.barber[i])
	end

	for i = 1, #config.shops.tattoos do
		CreateBlip('Loja de tatuagem', 71, 47, 0.7, config.shops.tattoos[i])
	end

	while true do

		local playerPed = PlayerPedId()

		local playerPosition = GetEntityCoords(playerPed)

		local nearShop = false

		for shopType, shopPositions in pairs(config.shops) do

			for positionIdx = 1, #shopPositions do

				local shopPosition = shopPositions[positionIdx]

				if #(shopPosition.xyz - playerPosition) < 5 then

					if IsControlJustReleased(0, 38) then

						exports['fivem-appearance']:startPlayerCustomization(function(appearance)

							if appearance then

								if shopType ~= 'tattoos' then
									TriggerServerEvent('fivem-appearance:save', appearance)
								else
									TriggerServerEvent('fivem-appearance:saveTattoos', appearance.tattoos)
								end
							end

						end, config[shopType])
					end

					nearShop = true
				end
			end
		end

		Wait(nearShop and 0 or 1000)
	end
end)