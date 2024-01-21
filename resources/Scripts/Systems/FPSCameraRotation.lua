
local rotationSpeed = 90

FPSCameraRotation = {

	update = function(deltaTime)
		local view = Registry.get_entities(Transform, CameraComponent)

		local mouse = Input.getMouseDelta()
		
		local delta = mouse * rotationSpeed * deltaTime

		view:for_each(
			function(entity)
				local camera = entity:get_component(CameraComponent)

				if not camera.isMain then
					return
				end
				
				local transform = entity:get_component(Transform)

				-- local rotation = transform:getWorldRotation():toEuler() * Math.radToDeg
				-- local resultRotation = rotation
				-- resultRotation.x = rotation.x - delta.y
				-- resultRotation.x = Math.clamp(rotation.x, -89.999, 89.999)
				-- resultRotation.y = rotation.y - delta.x;

				-- local x = Math.lerp(rotation.x, resultRotation.x, deltaTime)
				-- local y = Math.lerp(rotation.y, resultRotation.y, deltaTime)
				-- local z = Math.lerp(rotation.z, resultRotation.z, deltaTime)
				-- local addRotation = Vector3(x, y, z)
				-- local newQuaternion = Math.createQuaternionFromYawPitchRoll(addRotation * Math.degToRad)
				-- transform:setWorldRotation(newQuaternion)

				local rotation = transform:getWorldRotation():toEuler() * Math.radToDeg
				rotation.x = rotation.x - delta.y
				rotation.x = Math.clamp(rotation.x, -89.999, 89.999)
				rotation.y = rotation.y - delta.x;
				transform:setWorldRotation(Math.createQuaternionFromYawPitchRoll(rotation * Math.degToRad))
			end
		)
	end
}