local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/obeseinsect/roblox/main/Ui%20Libraries/Elerium.lua'))()

local ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/ESP-Lib/main/ESP.lua"))()
local ESP2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/ESP-Lib/main/ESP.lua"))()
local ESP3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/ESP-Lib/main/ESP.lua"))()
ESP:Toggle(true); ESP.Players = false; ESP.Color = Color3.fromRGB(128,234,255)
ESP2:Toggle(true); ESP2.Boxes = false; ESP2.Players = false
ESP3:Toggle(true); ESP3.Names = false; ESP3.Players = false; ESP3.FaceCamera = true

local player = game.Players.LocalPlayer

ESP3:AddObjectListener(workspace.World.Objectives, {
    Color = Color3.fromRGB(255,204,0),
    Type = 'Model',
    PrimaryPart = function(obj) while not obj:FindFirstChildWhichIsA('Part') do wait() end return obj:FindFirstChildWhichIsA('Part') end,
    IsEnabled = function(obj) return ESP3[obj.Name] and player:DistanceFromCharacter(obj.PrimaryPart.Position) < objectiveRange end
})
ESP2:AddObjectListener(workspace.Ignore.Items, {
    Color = Color3.fromRGB(102,255,102),
    Type = 'Model',
    PrimaryPart = function(obj) while not obj:FindFirstChildWhichIsA('Part') do wait() end return obj:FindFirstChildWhichIsA('Part') end,
    IsEnabled = function(obj) return ESP2[obj.Name] and player:DistanceFromCharacter(obj.PrimaryPart.Position) < itemRange end
})
ESP:AddObjectListener(workspace.Entities.Infected, {
    Color = Color3.fromRGB(255,102,102),
    Type = 'Model',
    PrimaryPart = function(obj) while not obj:FindFirstChildWhichIsA('Part') do wait() end return obj:FindFirstChildWhichIsA('Part') end,
    IsEnabled = function(obj) return ESP.Zombies and player:DistanceFromCharacter(obj.PrimaryPart.Position) < zombieRange end
})

do 
	local Window = library:AddWindow("Those Who Remain ESP", {
		main_color = Color3.fromRGB(41, 74, 122),
		min_size = Vector2.new(500, 600),
		toggle_key = Enum.KeyCode.RightShift,
		can_resize = true,
	})
	local visuals = Window:AddTab("Main")
	do
        visuals:AddSwitch("Player ESP", function(v) ESP.Players = v end)
		visuals:AddSwitch("Zombie ESP", function(v) ESP.Zombies = v end)
		visuals:AddSwitch("Objective ESP", function(v) ESP3.Objectives = v end)
        local zombRangeSlider = visuals:AddSlider("Zombie Range", function(v) zombieRange = v end, {["min"] = 0, ["max"] = 2500, ["readonly"] = false})
        local objectiveRangeSlider = visuals:AddSlider("Objective Range", function(v) objectiveRange = v end, {["min"] = 0, ["max"] = 1000, ["readonly"] = false})

        local itemEsp = visuals:AddFolder("Item ESP")
        local itemRangeSlider = itemEsp:AddSlider("Range", function(v) itemRange = v end, {["min"] = 0, ["max"] = 1000, ["readonly"] = false})
        for i, v in pairs(game:GetService("ReplicatedStorage").Models["Item Pickups"]:GetChildren()) do
            itemEsp:AddSwitch(v.Name, function(e) ESP2[v.Name] = e end)
        end
	end
	library:FormatWindows()
end
