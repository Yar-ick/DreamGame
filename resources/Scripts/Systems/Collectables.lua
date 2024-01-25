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

				-- Collectable floating animation
				local collectableLocalPosition = collectableEntity:get_component(Transform):getLocalPosition()

				if scriptsContainer.CollectableTNT.animationUpDirection == true then
					collectableEntity:get_component(Transform):setLocalPosition(collectableLocalPosition + Vector3(0.0, 0.1, 0.0))
				elseif scriptsContainer.CollectableTNT.animationUpDirection == false then
					collectableEntity:get_component(Transform):setLocalPosition(collectableLocalPosition + Vector3(0.0, -0.1, 0.0))
				end

				if collectableLocalPosition.y > 5.0 then
					scriptsContainer.CollectableTNT.animationUpDirection = false
				elseif collectableLocalPosition.y < 2.5 then
					scriptsContainer.CollectableTNT.animationUpDirection = true
				end
				-- Collectable floating animation end


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
									if playerDynamiteEntity:name() ~= "Weapon" then
										return
									end

									print("Show dynamite for player camera")
									playerDynamiteEntity:get_component(Transform):setLocalPosition(Vector3(0.4, -0.568, -1.491))
									playerDynamiteEntity:get_component(Transform):setLocalRotation(0.0, 0.0, 0.0)
								end
							)

							Audio.playOneShot("DynamitePickup", playerEntity)

							-- Destroy collectable
							scene:destroyEntity(collectableEntity)
						end
					end
				)
			end
		)
	end
}