if _G.AutoPunchToggle == nil then
    _G.AutoPunchToggle = false
end

_G.AutoPunchToggle = not _G.AutoPunchToggle

if _G.AutoPunchToggle then
    warn("✅ Auto Punch ACTIVADO")
else
    warn("⛔ Auto Punch DESACTIVADO")
    return
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local backpack = player:WaitForChild("Backpack")
local character = player.Character or player.CharacterAdded:Wait()
local hand = "rightHand"

local function getMuscleEvent()
    return player:FindFirstChild("muscleEvent")
end

player.CharacterAdded:Connect(function(char)
    character = char
end)

player.ChildAdded:Connect(function(child)
    if child.Name == "Backpack" then
        backpack = child
    end
end)

task.spawn(function()
    while _G.AutoPunchToggle do
        local muscleEvent = getMuscleEvent()
        character = player.Character
        if character and character:FindFirstChild("Humanoid") and muscleEvent then
            local punchEquipped = character:FindFirstChild("Punch")
            local punchInBackpack = backpack:FindFirstChild("Punch")

            if not punchEquipped and punchInBackpack then
                character.Humanoid:EquipTool(punchInBackpack)
            end

            muscleEvent:FireServer("punch", hand)
        end
        task.wait(0.0001)
    end
end)
