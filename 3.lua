local lighting = game:GetService("Lighting")
local player = game.Players.LocalPlayer

local function softAntiLag()
    local classesToClean = {
        ["ParticleEmitter"] = true,
        ["Trail"] = true,
        ["Smoke"] = true,
        ["Fire"] = true
    }

    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            for _, sub in ipairs(obj:GetChildren()) do
                if classesToClean[sub.ClassName] then
                    pcall(function()
                        sub:Destroy()
                    end)
                end
            end
        end
    end

    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.WaterWaveSize = 0
        terrain.WaterReflectance = 0
        terrain.WaterTransparency = 1
    end
end

local function setSunsetSky()
    lighting.ClockTime = 18 -- 6:00 PM
    lighting.Brightness = 1.5
    lighting.OutdoorAmbient = Color3.fromRGB(150, 100, 80)
    lighting.FogColor = Color3.fromRGB(200, 120, 100)
    lighting.FogEnd = 500

    for _, v in ipairs(lighting:GetChildren()) do
        if v:IsA("Sky") then
            v:Destroy()
        end
    end

    local sky = Instance.new("Sky")
    sky.Name = "SunsetSky"
    sky.SkyboxBk = "rbxassetid://131889017"
    sky.SkyboxDn = "rbxassetid://131889017"
    sky.SkyboxFt = "rbxassetid://131889017"
    sky.SkyboxLf = "rbxassetid://131889017"
    sky.SkyboxRt = "rbxassetid://131889017"
    sky.SkyboxUp = "rbxassetid://131889017"
    sky.SunAngularSize = 10
    sky.MoonAngularSize = 0
    sky.SunTextureId = "rbxassetid://644432992"
    sky.Parent = lighting
end

softAntiLag()
setSunsetSky()

print("✅ Anti-lag aplicado y cielo de atardecer activado.")
