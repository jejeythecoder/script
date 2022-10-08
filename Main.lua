local module = require(game.ServerScriptService:WaitForChild('Main'):WaitForChild('Functions'))
local status = game.ReplicatedStorage:WaitForChild('Status')
local Time1 = 10
local Time2 = 500



while true do

	status.Value = '4 players needed!'
	repeat wait(.1) until game.Players.NumPlayers >= 1
	wait(5)

	-- choose random map

	local maps = game.ReplicatedStorage.Maps:GetChildren()
	local randomMap = maps[math.random(1, #maps)]
	local chosenMap = randomMap:Clone()
	chosenMap.Parent = workspace
	chosenMap.Name = 'Map'



	module.update2()
	local players = {}

	for i, v in pairs(players) do
		if #players ~= 0 then
			table.remove(players, i)
		end
	end

	for i, v in pairs(game.Players:GetPlayers()) do
		if v then
			table.insert(players, v)
		end
	end
	local map = workspace.Map 
	local tppart = map:FindFirstChild('TPpart')
	for i = Time1, 0, -1 do
		status.Value = 'Starting in '..i
		wait(1)
	end
	for i, v in pairs(players) do
		if v then
			local character = v.Character
			if character then
				local ingame = Instance.new('IntValue', character)
				ingame.Name = 'InGame'
				character.HumanoidRootPart.CFrame = workspace.Map.MapSpawns['Spawn'..i].CFrame
			else
				table.remove(players, v)
			end
		else
			table.remove(players, v)
		end
	end
	module.ChooseImposter()
	for i = Time2, 0, -1 do
		status.Value = i..' Seconds left!'
		game.ReplicatedStorage.TimeLeft.Value = i
		for index, v in pairs(players) do
			if v then
				local character = v.Character
				if character then
					if character:FindFirstChild('InGame') then

					else
						table.remove(players, index)
					end
				else
					table.remove(players, index)

				end
			else
				table.remove(players, index)
			end
		end
		local thereIsImposter = false

		for i, v in pairs(game.Players:GetPlayers()) do
			if v:FindFirstChild('ImposterValue') then
				thereIsImposter = true
			end
		end

		wait()

		local done = false

		local playersLeft = #players - 1





		print(playersLeft)

		-- Add all your tasks here

		for i, v in pairs(players) do
			if v.Tasks.DownloadData.Value == true and v.Tasks.Scan.Value == true and v.Tasks.PressTheButton.Value == true and v.Tasks.SetNumber.Value == true and v.Tasks.Wifi.Value == true and v.Tasks.FixPc.Value == true and v.Tasks.FixWiring.Value == true and v.Tasks.DivertPower.Value == true and v.Tasks.PrimeShields.Value == true  then
				v.AllTasksCompleted.Value = true
			end
		end


		for i, v in pairs(players) do
			if v.AllTasksCompleted.Value == true then
				playersLeft = playersLeft - 1
			end
		end

		if playersLeft == 0 then
			for i, v in pairs(game.Players:GetPlayers()) do
				if v then
					if v:FindFirstChild('ImposterValue') then
						v.ImposterValue:Destroy()
					end
				end
			end
			break
		end

		if thereIsImposter == false then
			break
		end

		if #players <= 2 then
			break
		end
		wait(1)
		thereIsImposter = false
	end


	for i,v in pairs(game.Players:GetPlayers()) do
		if v then
			for x, c in pairs(v.Tasks:GetChildren()) do
				c.Value = false
			end
		end
	end


	for i, v in pairs(game.Players:GetPlayers()) do
		for index, v in pairs(workspace:GetChildren()) do
			if v.Name == 'Body' then
				v:Destroy()
			end
		end



		local character = v.Character

		for i, v in pairs(game.Players:GetPlayers()) do
			if v then
				character.HumanoidRootPart.CFrame = workspace.Lobby.LobbySpawns["Spawn"..i].CFrame
			end
		end




		if character:FindFirstChild('InGame') then
			character:FindFirstChild('InGame'):Destroy()
		end

		game.ReplicatedStorage.TimeLeft.Value = 0



		local imposter = game.ReplicatedStorage.Imposter.Value




		for i, v in pairs(game.Players:GetPlayers()) do
			if v then
				if v:FindFirstChild('ImposterValue') then
					module.update()
				end
			end
		end



		game.ReplicatedStorage.Imposters:FireAllClients()



		game.ReplicatedStorage.Crewmates:FireAllClients()

		for i, v in pairs(players) do
			if v then
				if game.ReplicatedStorage.Imposter.Value == true then
					if v:FindFirstChild('ImposterValue') then
						if not v:FindFirstChild('Crewmate') then
							v.leaderstats.Wins.Value = v.leaderstats.Wins.Value + 1
							v.leaderstats.Cash.Value = v.leaderstats.Cash.Value + 10
						end
					end
				else
					if not v:FindFirstChild('ImposterValue') then
						if v:FindFirstChild('Crewmate') then
							v.leaderstats.Wins.Value = v.leaderstats.Wins.Value + 1
							v.leaderstats.Cash.Value = v.leaderstats.Cash.Value + 10
						end
					end
				end
			end
		end




		for i, v in pairs(game.Players:GetPlayers()) do
			if v:FindFirstChild('ImposterValue') then
				v:FindFirstChild('ImposterValue') :Destroy()
			end
		end

		for i, v in pairs(game.Players:GetPlayers()) do
			if v:FindFirstChild('Crewmate') then
				v:FindFirstChild('Crewmate') :Destroy()
			end
		end

		for i, v in pairs(game.Players:GetPlayers()) do
			for x, c in pairs(v:GetChildren()) do
				if c:IsA('BoolValue') then
					c.Value = false
				end
			end
		end



		wait(2)

		for i, v in pairs(workspace:GetChildren()) do
			if v.Name == 'Map' then
				v:Destroy()
			end
		end

		game.Lighting.FogEnd = 100

	end
end