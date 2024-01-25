local answerCount = 0
local answer1 = ""
local answer2 = ""
local answer3 = ""
local resetRunes = false
local resetRuneNumber = 0
local foundRightAnswer = false
local timer = 0.0

RuneTouchSystem = {
	update = function(deltaTime)
		local view = Registry.get_entities(Transform, MeshRendererComponent, Rigidbody)
		local cameraView = Registry.get_entities(Transform, CameraComponent)
		local stoneGateView = Registry.get_entities(Transform, MeshRendererComponent)
		timer = timer + deltaTime

		view:for_each(
			function(entity)
				
				cameraView:for_each(
					function(cameraEntity)
						local camera = cameraEntity:get_component(CameraComponent)
						local cameraTransform = cameraEntity:get_component(Transform)

						if not camera.isMain then
							return
						end

						if Input.isMouseButtonReleased(MouseButton.Right) and timer > 0.5 then
							timer = 0.0
							local hit = Physics.raycast(cameraTransform:getWorldPosition(), cameraTransform:getForwardDirection(), 100.0, FilterLayer.Layer1)

							if hit.isSuccessful then
								if hit.entity:name() ~= "Rune1" and hit.entity:name() ~= "Rune2" and hit.entity:name() ~= "Rune3" then
									return
								end
	
								if answerCount == 0 then
									answerCount = answerCount + 1
									answer1 = hit.entity:name()
									print("Answer1: ", answer1)
									hit.entity:get_component(MeshRendererComponent).enabled = false
									return
								end
	
								if answerCount == 1 and hit.entity:name() ~= answer1 then
									answerCount = answerCount + 1
									answer2 = hit.entity:name()
									print("Answer2: ", answer2)
									hit.entity:get_component(MeshRendererComponent).enabled = false
									return
								end
	
								if answerCount == 2 and hit.entity:name() ~= answer1 and hit.entity:name() ~= answer2 then
									answerCount = answerCount + 1
									answer3 = hit.entity:name()
									print("Answer3: ", answer3)
									hit.entity:get_component(MeshRendererComponent).enabled = false
									return
								end
							end
						end
					end
				)

				-- Check for right answers
				if answerCount == 3 then
					if answer1 == "Rune2" and answer2 == "Rune1" and answer3 == "Rune3" then
						foundRightAnswer = true
						-- print("Found right answer!")
					else
						resetRunes = true
						-- print("Found wrong answer :(")
					end
				end

				-- Reset runes if combination was not right
				if resetRunes then
					if entity:name() == "Rune1" or entity:name() == "Rune2" or entity:name() == "Rune3" then
						if entity:get_component(MeshRendererComponent).enabled == false then
							resetRuneNumber = resetRuneNumber + 1
							entity:get_component(MeshRendererComponent).enabled = true
							print("Reset rune number: ", resetRuneNumber)
						end
					end

					if resetRuneNumber == 3 then
						resetRunes = false
						resetRuneNumber = 0
						answerCount = 0
						answer1 = ""
						answer2 = ""
						answer3 = ""
						print("Reset all runes")
						return
					end
				end

				stoneGateView:for_each(
					function(stoneGateEntity)
						-- Move the stone gates if found right answer
						if foundRightAnswer and stoneGateEntity:name() == "StoneGate" then
							local entityTransform = stoneGateEntity:get_component(Transform)
							entityTransform:setWorldPosition(entityTransform:getWorldPosition() + Vector3(0.0, -0.05, 0.0))
						end
					end
				)
			end
		)
	end
}