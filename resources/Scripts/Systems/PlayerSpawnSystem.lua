

PlayerSpawnSystem = {

	init = function(deltaTime)

		local view = Registry.get_entities(ScriptsContainer)
		local playerStartPosition = Vector3(0.0, 1.0, -15.0)

		-- Check if player already exists

		local alreadyExists = false

		view:for_each(
			function(entity)
				local scriptsContainer = entity:get_component(ScriptsContainer)

				if scriptsContainer.Player ~= nil then
					alreadyExists = true
				end

				if scriptsContainer.PlayerStart ~= nil then
					playerStartPosition = entity:get_component(Transform):getWorldPosition()
				end
			end
		)

		if alreadyExists then
			return
		end

		-- Spawn Prefab and add Player Component to ScriptsContainer
				
		local scene = SceneManager:getActiveScene()
		local prefab = Prefab("PrefabPlayer")
		local playerEntity = prefab:instantiate(scene)
		
		local playerTransform = playerEntity:get_component(Transform)
		playerTransform:setWorldPosition(playerStartPosition)

		local scriptsContainer = playerEntity:get_or_add_component(ScriptsContainer)
		
		scriptsContainer.Player = Player(15.0, false)
	end
}