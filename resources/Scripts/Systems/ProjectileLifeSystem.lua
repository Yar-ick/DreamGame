ProjectileLifeSystem = {
	update = function(deltaTime)
		local projectileView = Registry.get_entities(Transform, ScriptsContainer)
		local playerView = Registry.get_entities(Transform, CharacterController, ScriptsContainer)
		local destroyedEntity = false

		projectileView:for_each(
			function(entity)
				local scriptsContainer = entity:get_component(ScriptsContainer)

				if scriptsContainer.Projectile == nil then
					return
				end

				local projectile = scriptsContainer.Projectile
				projectile.timer = projectile.timer + deltaTime
				-- print(projectile.timer, projectile.lifetime)

                if projectile.timer >= projectile.lifetime then
					-- print("Kill", entity:name())
					local scene = SceneManager:getActiveScene()
					local entityLocation = entity:get_component(Transform):getWorldPosition()

					local prefab = Prefab("ExplosionParticlePrefab")
					local explosionParticleEntity = prefab:instantiate(scene)
					explosionParticleEntity:get_component(Transform):setWorldPosition(entityLocation)
					local particleScriptsContainer = explosionParticleEntity:get_or_add_component(ScriptsContainer)
					particleScriptsContainer.DestroyableParticle = DestroyableParticle()
					particleScriptsContainer.DestroyableParticle.lifetime = 3

					Audio.playOneShot("ChunkyExplosion", entity)

					projectileView:for_each(
						function(entityToRemove)
							local entityToRemoveScriptsContainer = entityToRemove:get_component(ScriptsContainer)

							if entityToRemoveScriptsContainer.DestroyableEntity == nil then
								return
							end

							local entityToRemoveLocation = entityToRemove:get_component(Transform):getWorldPosition()

							if Math.distance(entityLocation, entityToRemoveLocation) - entityToRemove:get_component(Rigidbody):getCapsuleRadius() <= 10 then
								scene:destroyEntity(entityToRemove)
								destroyedEntity = true
							end
						end
					)

                    scene:destroyEntity(entity)
				end

			end
		)

		playerView:for_each(
			function (playerEntity)
				local scriptsContainer = playerEntity:get_component(ScriptsContainer)

				if scriptsContainer.Player == nil then
					return
				end

				if destroyedEntity == true then
					scriptsContainer.Player.hasDynamite = false
					local dynamiteView = Registry.get_entities(Transform, ScriptsContainer)

					dynamiteView:for_each(
						function (dynamiteEntity)
							if dynamiteEntity:name() ~= "Weapon" then
								return
							end

							print("Hide dynamite for player camera")
							dynamiteEntity:get_component(Transform):setLocalPosition(Vector3(0.0, -1.542, 0.340))
							dynamiteEntity:get_component(Transform):setLocalRotation(0.0, 0.0, 0.0)
						end
					)
				end
			end
		)
	end
}