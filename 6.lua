local Players    = game:GetService("Players")
local StarterPack = game:GetService("StarterPack")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player   = Players.LocalPlayer
local toolName = "Protein Egg"

if _G.AutoProteinEgg ~= nil then
    _G.AutoProteinEgg = not _G.AutoProteinEgg
else
    _G.AutoProteinEgg = true
end
print("Auto Protein Egg " .. (_G.AutoProteinEgg and "ACTIVADO ✅" or "DESACTIVADO ❌"))


local character = player.Character or player.CharacterAdded:Wait()

local function restoreVisibility(tool)
    for _, part in ipairs(tool:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 0
            pcall(function() part.LocalTransparencyModifier = 0 end)
        end
    end
end


local function findTool()
    local tool = player.Backpack:FindFirstChild(toolName)
    if tool then return tool end
    tool = StarterPack:FindFirstChild(toolName)
    if tool then return tool end
    tool = ReplicatedStorage:FindFirstChild(toolName)
    return tool
end


local function forceEquip(tool)
    if not (character and character:FindFirstChild("Humanoid")) then return end

    
    local success, err = pcall(function()
        character.Humanoid:EquipTool(tool)
    end)
    task.wait(0.1)

    
    if not character:FindFirstChild(toolName) then
        tool.Parent = character
        task.wait(0.1)
    end

    local equipped = character:FindFirstChild(toolName)
    if equipped then
        restoreVisibility(equipped)
    end
end

local function equipIfNeeded()
    if not _G.AutoProteinEgg or not character then return end

    local equipped = character:FindFirstChild(toolName)
    local needEquip = false

    if not equipped then
        needEquip = true
    else
        
        for _, part in ipairs(equipped:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency > 0 then
                needEquip = true
                break
            end
        end
    end

    if needEquip then
        local tool = findTool()
        if tool then
            -- Si estaba en StarterPack o ReplicatedStorage, clonamos a Backpack primero
            if tool.Parent ~= player.Backpack then
                local clone = tool:Clone()
                clone.Parent = player.Backpack
                tool = clone
            end
            forceEquip(tool)
        end
    end
end

player.CharacterAdded:Connect(function(char)
    character = char
    task.wait(1)
    equipIfNeeded()
end)

player.Backpack.ChildAdded:Connect(function(child)
    if _G.AutoProteinEgg and child.Name == toolName then
        task.wait(0.2)
        equipIfNeeded()
    end
end)

task.spawn(function()
    while _G.AutoProteinEgg do
        equipIfNeeded()
        task.wait(0.5)
    end
    print("Auto Protein Egg DESACTIVADO")
end)
