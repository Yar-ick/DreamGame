ParticleDestroySystem = {
	update = function(deltaTime)
		local particleView = Registry.get_entities(Transform, ScriptsContainer)

		particleView:for_each(
			function(entity)
				local scriptsContainer = entity:get_component(ScriptsContainer)

				if scriptsContainer.DestroyableParticle == nil then
					return
				end

				local particle = scriptsContainer.DestroyableParticle
				particle.timer = particle.timer + deltaTime

                if particle.timer >= particle.lifetime then
					print("Kill", entity:name())
                    SceneManager:getActiveScene():destroyEntity(entity)
				end
			end
		)
	end
}