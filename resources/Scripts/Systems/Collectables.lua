Collectables = {
	update = function(deltaTime)
		local scene = SceneManager.getActiveScene()
		local collectablesView = Registry.get_entities(Transform, ScriptsContainer)
		
		collectablesView:for_each(
			function(collectableEntity)
				local scriptsContainer = collectableEntity:get_component(ScriptsContainer)

				if scriptsContainer.CollectableTNT == nil then
					return
				end

				local collectablePosition = collectableEntity:get_component(Transform):getWorldPosition()

				collectablesView:for_each(
					function(playerEntity)
						if playerEntity:get_component(ScriptsContainer).Player == nil then
							return
						end

						local playerLocation = playerEntity:get_component(Transform):getWorldPosition()

						if Math.distance(collectablePosition, playerLocation) <= 5 then
							-- Enable dynamite throwing
							playerEntity:get_component(ScriptsContainer).Player.hasDynamite = true

							-- Set dynamite visuals for player camera
							collectablesView:for_each(
								function(playerDynamiteEntity)
									-- if playerDynamiteEntity:get_component(ScriptsContainer).PlayerDynamite == nil then
									-- 	print("Entity \"", playerDynamiteEntity:name(), "\" has no PlayerDynamiteComponent")
									-- 	return
									-- end
									if playerDynamiteEntity:name() ~= "Weapon" then
										return
									end

									print("Set dynamite visuals for player camera")

									playerDynamiteEntity:get_component(Transform):setLocalPosition(Vector3(0.4, -0.568, -1.491))
									print("Set dynamite position for player camera")
									playerDynamiteEntity:get_component(Transform):setLocalRotation(0.0, 0.0, 0.0)
								end
							)

							-- Destroy collectable
							scene:destroyEntity(collectableEntity)
						end
					end
				)
			end
		)
	end
}