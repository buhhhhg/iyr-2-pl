local Player = Players.LocalPlayer
local Character, Humanoid, RootPart

local Camera = workspace.CurrentCamera

local IsVoiding = false

local AnimCheck = true

local AbMagnitude = 2

local AbDelay = 1

local RanTP = false

local VoidDepth = -499

local GetNearestPlayers = function()
	if RootPart then
		for _, x in next, Players:GetPlayers() do
			if x ~= Player then
				local x_Character = x.Character
				local x_Humanoid = x_Character and x_Character:FindFirstChildWhichIsA("Humanoid")
				local x_RootPart = x_Humanoid and x_Humanoid.RootPart

				if x_RootPart and (RootPart.Position - x_RootPart.Position).Magnitude < AbMagnitude then
					if (AnimCheck) then
						for _, x in next, x_Humanoid:GetPlayingAnimationTracks() do
							if x.Animation and x.Animation.AnimationId:match("148840371") or x.Animation.AnimationId:match("5918726674") then
								return true
							end
						end

						return false
					else
						return true
					end
				end
			end
		end
	end

	return false
end

spawn(function()
	while true do
		if (AntiBangEnabled) then
			Character = Player.Character
			Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
			RootPart = Humanoid and Humanoid.RootPart

			if GetNearestPlayers() and Humanoid and RootPart and not IsVoiding then
				if (RanTP) then
					RootPart.CFrame = RootPart.CFrame + Vector3.new(math.random(1,50), 0, math.random(1,50))
				else
					IsVoiding = true

					local CurrentPosition = RootPart.Velocity.Magnitude < 50 and RootPart.CFrame or Camera.Focus
					local Timer = tick()
					local OldDH = workspace.FallenPartsDestroyHeight

					
					repeat
						workspace["\x46\x61\x6C\x6C\x65\x6E\x50\x61\x72\x74\x73\x44\x65\x73\x74\x72\x6F\x79\x48\x65\x69\x67\x68\x74"] = 0 / 0
						RootPart.CFrame = CFrame.new(0, VoidDepth, 0) * CFrame.Angles(math.rad(90), 0, 0)
						RootPart.AssemblyLinearVelocity = Vector3.new()
						task.wait()
					until tick() > Timer + AbDelay

					RootPart.AssemblyLinearVelocity = Vector3.new()
					RootPart.CFrame = CurrentPosition

					Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)


					workspace["\x46\x61\x6C\x6C\x65\x6E\x50\x61\x72\x74\x73\x44\x65\x73\x74\x72\x6F\x79\x48\x65\x69\x67\x68\x74"] = OldDH
					IsVoiding = false
				end
			end
		end

		task.wait()
	end
end)

local canOpenServerIist = true

local Plugin = {
	["PluginName"] = "IYR 2 PL",
	["PluginDescription"] = "Porting IYR to a plugin. - This is completely open source!",
	["Commands"] = {
		["serverlist"] = {
			["ListName"] = "serverlist / slist",
			["Description"] = "Open a list of servers for the current game",
			["Aliases"] = { "slist" },
			["Function"] = function(args, speaker)
				if httprequest then
					PlaceId = game.PlaceId

					local listreq = httprequest({Url = string.format("https://api.infiniteyieldreborn.xyz/servers?gameId=%d", PlaceId)})
					local listbody = HttpService:JSONDecode(listreq.Body)
					if listbody and listbody.data then
						if not canOpenServerIist then return end
						canOpenServerIist = false
						local FRAME = Instance.new("Frame")
						local shadow = Instance.new("Frame")
						local PopupText = Instance.new("TextLabel")
						local Exit = Instance.new("TextButton")
						local ExitImage = Instance.new("ImageLabel")
						local background = Instance.new("Frame")
						local refreshbutton = Instance.new("TextButton")
						local ScrollingFrame = Instance.new("ScrollingFrame")
						local UIListLayout = Instance.new("UIListLayout")

						FRAME.Name = randomString()
						FRAME.Parent = PARENT
						FRAME.Active = true
						FRAME.BackgroundTransparency = 1
						FRAME.Position = UDim2.new(0.5, -225, 0, -500)
						FRAME.Size = UDim2.new(0, 450, 0, 20)
						FRAME.ZIndex = 10
						dragGUI(FRAME)

						shadow.Name = "shadow"
						shadow.Parent = FRAME
						shadow.BackgroundColor3 = currentShade2
						shadow.BorderSizePixel = 0
						shadow.Size = UDim2.new(0, 450, 0, 20)
						shadow.ZIndex = 10
						table.insert(shade2,shadow)

						PopupText.Name = "PopupText"
						PopupText.Parent = shadow
						PopupText.BackgroundTransparency = 1
						PopupText.Size = UDim2.new(1, 0, 0.95, 0)
						PopupText.ZIndex = 10
						PopupText.Font = Enum.Font.SourceSans
						PopupText.TextSize = 14
						PopupText.Text = "Servers List"
						PopupText.TextColor3 = currentText1
						PopupText.TextWrapped = true
						table.insert(text1,PopupText)

						Exit.Name = "Exit"
						Exit.Parent = shadow
						Exit.BackgroundTransparency = 1
						Exit.Position = UDim2.new(1, -20, 0, 0)
						Exit.Size = UDim2.new(0, 20, 0, 20)
						Exit.Text = ""
						Exit.ZIndex = 10

						ExitImage.Parent = Exit
						ExitImage.BackgroundColor3 = Color3.new(1, 1, 1)
						ExitImage.BackgroundTransparency = 1
						ExitImage.Position = UDim2.new(0, 5, 0, 5)
						ExitImage.Size = UDim2.new(0, 10, 0, 10)
						ExitImage.Image = "rbxassetid://5054663650"
						ExitImage.ZIndex = 10

						refreshbutton.Name = "RefreshButton"
						refreshbutton.Parent = shadow
						refreshbutton.Text = "Refresh"
						refreshbutton.BackgroundColor3 = currentShade3
						refreshbutton.Position = UDim2.new(1, -80, 0.14, 0)
						refreshbutton.Size = UDim2.new(0, 50, 0, 14)
						refreshbutton.ZIndex = 10
						refreshbutton.Font = Enum.Font.SourceSans
						refreshbutton.TextSize = 14
						refreshbutton.TextColor3 = currentText1
						refreshbutton.TextWrapped = true
						refreshbutton.BorderSizePixel = 0

						background.Name = "background"
						background.Parent = FRAME
						background.Active = true
						background.BackgroundColor3 = currentShade1
						background.BorderSizePixel = 0
						background.Position = UDim2.new(0, 0, 1, 0)
						background.Size = UDim2.new(0, 450, 0, 250)
						background.ZIndex = 10
						table.insert(shade1,background)

						ScrollingFrame.Name = "ScrollingFrame"
						ScrollingFrame.Parent = background
						ScrollingFrame.Active = true
						ScrollingFrame.Size = UDim2.new(1,0,1,0)
						ScrollingFrame.ZIndex = 10
						ScrollingFrame.BackgroundTransparency = 1
						ScrollingFrame.ScrollBarImageColor3 = Color3.new(255,255,255)
						ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

						UIListLayout.Parent = ScrollingFrame
						UIListLayout.Name = "UIListLayout"
						UIListLayout.Padding = UDim.new(0,5)
						local function addservertemplate()
							for i,v in ipairs(listbody.data) do
								local frame1 = Instance.new("Frame")
								local textlabel = Instance.new("TextLabel")
								local textlabel2 = Instance.new("TextLabel")
								local textlabel3 = Instance.new("TextLabel")
								local textlabel4 = Instance.new("TextLabel")
								local textlabel5 = Instance.new("TextLabel")
								local textlabel6 = Instance.new("TextLabel")
								local frame2 = Instance.new("Frame")
								local UIGradient = Instance.new("UIGradient")
								local joinbutton = Instance.new("TextButton")

								frame1.Name = "Server"..tostring(i)
								frame1.ZIndex = 10
								frame1.BackgroundColor3 = currentShade3
								frame1.BorderSizePixel = 0
								frame1.Size = UDim2.new(0,438,0,125)
								frame1.Parent = ScrollingFrame

								textlabel.ZIndex = 10
								textlabel.Size = UDim2.new(1,0,1,0)
								textlabel.Text = "Server "..tostring(i)
								textlabel.TextXAlignment = Enum.TextXAlignment.Right
								textlabel.TextWrapped = true
								textlabel.TextScaled = true
								textlabel.TextColor3 = currentText1
								textlabel.BackgroundTransparency = 1
								textlabel.TextTransparency = 0.85
								textlabel.Parent = frame1

								frame2.ZIndex = 11
								frame2.BorderSizePixel = 0
								frame2.Size = UDim2.new(1,0,1,0)
								frame2.Parent = frame1

								UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0,0,0),NumberSequenceKeypoint.new(0.312,0,0),NumberSequenceKeypoint.new(1,1,0)}
								UIGradient.Rotation = 15
								UIGradient.Color = ColorSequence.new(currentShade3)
								UIGradient.Parent = frame2

								if v.id ~= game.JobId then
									joinbutton.Name = "JoinButton"
									joinbutton.ZIndex = 11
									joinbutton.BorderSizePixel = 0
									joinbutton.Size = UDim2.new(0,200,0,50)
									joinbutton.Position = UDim2.new(0.475,0,0.32,0)
									joinbutton.BackgroundColor3 = currentShade1
									joinbutton.Text = "Join"
									joinbutton.TextColor3 = currentText1
									joinbutton.MouseButton1Click:Connect(function()
										game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId,v.id)
									end)
									joinbutton.Parent = frame2
								end

								textlabel2.ZIndex = 11
								textlabel2.Size = UDim2.new(0,116,0,35)
								if v.id ~= game.JobId then
									textlabel2.Text = "Server "..tostring(i)
								else
									textlabel2.Text = "Server "..tostring(i).." (Joined)"
								end
								textlabel2.TextSize = 14
								textlabel2.TextColor3 = currentText1
								textlabel2.TextWrapped = true
								textlabel2.BackgroundTransparency = 1
								textlabel2.Parent = frame2

								textlabel3.ZIndex = 11
								textlabel3.Size = UDim2.new(0,100,0,35)
								textlabel3.Position = UDim2.new(0,0,0.16,0)
								textlabel3.Text = "Players: "..v.playing.."/"..v.maxPlayers

								textlabel3.TextColor3 = currentText1
								textlabel3.BackgroundTransparency = 1
								textlabel3.Parent = frame2

								textlabel4.ZIndex = 11
								textlabel4.Size = UDim2.new(0,100,0,35)
								textlabel4.Position = UDim2.new(0,0,0.304,0)
								textlabel4.Text = "Fps: "..v.fps
								textlabel4.TextColor3 = currentText1
								textlabel4.BackgroundTransparency = 1
								textlabel4.Parent = frame2

								textlabel5.ZIndex = 11
								textlabel5.Size = UDim2.new(0,100,0,35)
								textlabel5.Position = UDim2.new(0,0,0.44,0)
								textlabel5.Text = "Ping: "..v.ping
								textlabel5.TextColor3 = currentText1
								textlabel5.BackgroundTransparency = 1
								textlabel5.Parent = frame2

								textlabel6.ZIndex = 11
								textlabel6.Size = UDim2.new(0,265,0,35)
								textlabel6.Position = UDim2.new(0,0,0.72,0)
								textlabel6.Text = "Jobid: "..v.id
								textlabel6.TextWrapped = true
								textlabel6.TextColor3 = currentText1
								textlabel6.BackgroundTransparency = 1
								textlabel6.Parent = frame2
							end
						end
						addservertemplate()
						refreshbutton.MouseButton1Click:Connect(function()
							for i,v in pairs(ScrollingFrame:GetChildren()) do
								if v:IsA("Frame") then
									v:Destroy()
								end
							end
							listreq = httprequest({Url = string.format("https://api.infiniteyieldreborn.xyz/servers?gameId=%d", PlaceId)})
							listbody = HttpService:JSONDecode(listreq.Body)
							task.wait(.5)
							addservertemplate()
						end)

						FRAME:TweenPosition(UDim2.new(0.5, -225, 0, 100), "InOut", "Quart", 0.5, true, nil) 
						task.wait(0.5)
						Exit.MouseButton1Click:Connect(function()
							FRAME:TweenPosition(UDim2.new(0.5, -225, 0, -500), "InOut", "Quart", 0.5, true, nil) 
							task.wait(0.6)
							FRAME:Destroy()
							canOpenServerIist = true
						end)
					end
				else
					notify("Incompatible Exploit", "Your exploit does not support this command (missing request)")
				end
			end,
		},
		["unantibang"] = {
			["ListName"] = "unantibang / unantirape"
			["Description"] = "why",
			["Aliases"] = { "unantirape" },
			["Function"] = function(args, speaker)
				AntiBangEnabled = false
				notify("Anti Bang","Anti bang has been turned off.")
			end
		},
		["toggleantibang"] = {
			["ListName"] = "toggleantibang / toggleantirape"
			["Description"] = "why",
			["Aliases"] = { "toggleantirape" },
			["Function"] = function(args, speaker)
				AntiBangEnabled = not AntiBangEnabled
				if (AntiBangEnabled) then 
					notify("Anti Bang","Anti bang has been toggled on.")
				else 
					notify("Anti Bang","Anti bang has been toggled off.") 
				end
			end
		},
		["mantibang"] = {
			["ListName"] = "mantibang / mantirape"
			["Description"] = "Manually triggers the anti bang sequence (Not subjectible to animcheck)",
			["Aliases"] = { "mantirape" },
			["Function"] = function(args, speaker)
				if not IsVoiding then
					Character = Player.Character
					Humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
					RootPart = Humanoid and Humanoid.RootPart
					IsVoiding = true

					local CurrentPosition = RootPart.Velocity.Magnitude < 50 and RootPart.CFrame or Camera.Focus
					local Timer = tick()

					repeat
						RootPart.CFrame = CFrame.new(0, VoidDepth, 0) * CFrame.Angles(math.rad(90), 0, 0)
						RootPart.AssemblyLinearVelocity = Vector3.new()
						task.wait()
					until tick() > Timer + AbDelay

					RootPart.AssemblyLinearVelocity = Vector3.new()
					RootPart.CFrame = CurrentPosition

					Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

					IsVoiding = false
				end
			end
		},
		["abmethod"] = {
			["ListName"] = "abmethod / armethod",
			["Description"] = "Toggles between random TP and voiding for preventing from getting banged",
			["Aliases"] = { "armethod" },
			["Function"] = function(args, speaker)
				RanTP = not RanTP
				if (RanTP) then 
					notify("Anti-Bang Method", "Set to random TP.")
				else 
					notify("Anti-Bang Method", "Set to voiding.") 
				end
			end
		},
		["abdistance"] = {
			["ListName"] = "abdistance / ardistance [distance]",
			["Description"] = "Sets the distance in-between that anti-bang should trigger to when someone is banging you",
			["Aliases"] = { "ardistance" }
			["Function"] = function(args, speaker)
				local dist = args[1]
				AbMagnitude = tonumber(dist)
				notify("Anti-Bang Distance", "The distance has been set to "..AbMagnitude)
			end
		},
		["abdepth"] = {
			["ListName"] = "abdepth / ardepth [void depth]",
			["Description"] = "Set how deep you go into the void when someone bangs you",
			["Aliases"] = { "ardepth" },
			["Function"] = function(args, speaker)
				local vdepth = args[1]
				VoidDepth = vdepth
				notify("Anti-Bang Depth", "The depth has been set to "..VoidDepth)
			end
		},
		["abdelay"] = {
			["ListName"] = "abdelay / ardistance [distance]",
			["Description"] = "Sets the delay for how long to be voided until the person banging you should be nullified.",
			["Aliases"] = { "ardistance" },
			["Function"] = function(args, speaker)
				local rdelay = args[1]
				AbDelay = tonumber(rdelay) or AbDelay
				Message = "The delay has been set to "..AbDelay
				if tonumber(rdelay) ~= "number" then
					Message = "The delay hasn't changed due to an invalid number"
				end

				notify("Anti-Bang Delay", Message)
			end
		},
		--[[
		["facebang"] = {
			["ListName"] = ""
		}
		]]-- coming soon
	}
}

return Plugin
