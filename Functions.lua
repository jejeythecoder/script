--local module = {}
--function module.ChooseImpostor()
--	local imposter=game.Players:GetPlayers()[math.random(1,#game.Players:GetPlayers())]
	
--	local val =Instance.new('BoolValue')
--	val.Name="ImposterValue"
--	val.Parent = imposter
--	wait()
--	for i,v in pairs(game.Players:GetPlayers()) do
--		if v then 
--			if not v:FindFirstChild('ImposterValue') then
--				local character=v.Character or v.CharacterAdded:Wait()
--				local crewmate = Instance.new('BoolValue', v)
--				crewmate.Name ='Crewmate'
--			end
--		end
--	end
--	for i, v in pairs(game.Players:GetPlayers()) do
--		if v:FindFirstChild('ImposterValue') then
--			game.ReplicatedStorage.ShowUi1:FireClient(v)
--		else
--			game.ReplicatedStorage.ShowUi2:FireClient(v)
--		end
--	end
--end
--function module.GetWinner()
--	local number=0
--	local winner ='Nobody'
--	local votestable = {}
--	for i,v in pairs(game.Players:GetPlayers()) do
--		if v then
--			local playergui=v.PlayerGui
--			local frame = playergui.Voting.Main.Container
--			for i, v in pairs(frame:GetChildern()) do
--				if v:IsA('TextButton') then
--					if v.Name ~= 'Template' then
--						table.insert(votestable,v)
--					end
--				end
--			end
--		end
--	end
--	for i, v in pairs(votestable)do
--		local val=v:FindFirstChild('Votes')
--		if val.Value>number then
--			winner=v
--		end
--	end
--	wait(.1)
--	for i, v in pairs(votestable) do
--		if v then
--			table.remove(votestable, i)
--		end
--	end
--	wait(1)
--	print(winner)
--	game.ReplicatedStorage.Winner.Value=tostring(winner)
--end
--return module
local module = {}
function module.ChooseImposter()
	local imposter = game.Players:GetPlayers()[math.random(1, #game.Players:GetPlayers())]


	local val = Instance.new('BoolValue')
	val.Name = "ImposterValue"
	val.Parent = imposter

	wait()

	for i, v in pairs(game.Players:GetPlayers()) do
		if v then
			if not v:FindFirstChild('ImposterValue') then
				local character = v.Character or v.CharacterAdded:Wait()
				local crewmate = Instance.new('BoolValue', v)
				crewmate.Name = 'Crewmate'
			end
		end
	end

	for i, v in pairs(game.Players:GetPlayers()) do
		if v:FindFirstChild('ImposterValue') then
			game.ReplicatedStorage.ShowUi1:FireClient(v)
		else
			game.ReplicatedStorage.ShowUi2:FireClient(v)
		end
	end
end

function module.GetWinner()
	local number = 0
	local winner = 'Nobody'


	local votestable = {

	}


	for i, v in pairs(game.Players:GetPlayers()) do
		if v then
			local playergui = v.PlayerGui
			local frame = playergui.Voting.Main.Container
			for i, v in pairs(frame:GetChildren()) do
				if v:IsA('TextButton') then
					if v.Name ~= 'Template' then
						table.insert(votestable, v)
					end
				end
			end
		end
	end

	for i, v in pairs(votestable) do
		local val = v:FindFirstChild('Votes')
		if val.Value > number then
			number = val.Value
			winner = v
		end
	end
	wait(.1)
	for i, v in pairs(votestable) do
		if v then
			table.remove(votestable, i)
		end
	end

	wait(1)

	print(winner)

	game.ReplicatedStorage.Winner.Value = tostring(winner)

	for i, v in pairs(game.Players:GetPlayers()) do
		if v then
			local playergui = v.PlayerGui
			local frame = playergui.Voting.Main.Container
			for i, v in pairs(frame:GetChildren()) do
				if v:IsA('TextButton') then
					if v.Name ~= 'Template' then
						table.remove(votestable, i)
					end
				end
			end
		end
	end

	for i, v in pairs(game.Players:GetPlayers()) do
		if v then
			local playergui = v.PlayerGui
			local frame = playergui.Voting.Main.Container
			for i, v in pairs(frame:GetChildren()) do
				if v:IsA('TextButton') then
					if v.Name ~= 'Template' then
						v.Votes.Value = 0
					end
				end
			end
		end
	end

end

function module.update()
	game.ReplicatedStorage.Imposter.Value = true
end

function module.update2()
	game.ReplicatedStorage.Imposter.Value = false
end

return module
