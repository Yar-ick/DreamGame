ProjectileLifeSystem = {
	update = function(deltaTime)
		local projectileView = Registry.get_entities(Transform, ScriptsContainer)

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

							if Math.distance(entityLocation, entityToRemoveLocation) <= 10 then
								scene:destroyEntity(entityToRemove)
							end
						end
					)

                    scene:destroyEntity(entity)
				end

			end
		)
	end
}