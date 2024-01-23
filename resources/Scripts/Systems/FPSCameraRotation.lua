local rotationSpeed = 90

FPSCameraRotation = {
	update = function(deltaTime)
		local view = Registry.get_entities(Transform, CameraComponent)
		local delta = Input.getMouseDelta() * rotationSpeed * deltaTime

		view:for_each(
			function(entity)
				local camera = entity:get_component(CameraComponent)
				local transform = entity:get_component(Transform)

				if not camera.isMain then
					return
				end

				-- Base rotation method
				local rotation = transform:getWorldRotation():toEuler() * Math.radToDeg
				rotation.x = Math.clamp(rotation.x - delta.y, -89.999, 89.999)
				rotation.y = rotation.y - delta.x;
				transform:setWorldRotation(Math.createQuaternionFromYawPitchRoll(rotation * Math.degToRad))
			end
		)
	end
}