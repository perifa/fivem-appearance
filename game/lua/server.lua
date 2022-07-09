local Query = {
	UPDATE_CHARACTER_TATTOOS = 'UPDATE `characters_appearance` SET `tattoos` = ? WHERE characterId = ?',
	UPDATE_CHARACTER_APPEARANCE =  'UPDATE `characters_appearance` SET `model` = ?, `hair` = ?, `headOverlays` = ?, `headBlend` = ?, `faceFeatures` = ?, `eyeColor` = ?  WHERE `characterId` = ?',
	UPDATE_CHARACTER_OUTFIT = 'UPDATE `characters_outfit` SET `components` = ?, `props` = ? WHERE `outfitId` = ?'
}

RegisterNetEvent('fivem-appearance:save', function(appearance)

    local playerId = source

    local characterId = ESX.GetCharacterIdFromPlayerId(playerId)

    if not characterId or not appearance then
		return
	end

	local outfitId = ESX.GetCharacterCurrentOutfitId(characterId)

	if outfitId then

		MySQL.query.await(Query.UPDATE_CHARACTER_OUTFIT, {
			json.encode(appearance.components),
			json.encode(appearance.props),

			outfitId
		})
	end

	MySQL.query.await(Query.UPDATE_CHARACTER_APPEARANCE, {
		appearance.model,
		json.encode(appearance.hair),
		json.encode(appearance.headOverlays),
		json.encode(appearance.headBlend),
		json.encode(appearance.faceFeatures),
		json.encode(appearance.eyeColor),

		characterId
	})
end)

RegisterNetEvent('fivem-appearance:saveTattoos', function(tattoos)

    local playerId = source

    local characterId = ESX.GetCharacterIdFromPlayerId(playerId)

    if not characterId or not tattoos or table.type(tattoos) == 'empty' then
		return
	end

	MySQL.query.await(Query.UPDATE_CHARACTER_TATTOOS, {
		json.encode(tattoos),

		characterId
	})
end)