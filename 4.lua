local Players     = game:GetService("Players")
local RunService  = game:GetService("RunService")
local player      = Players.LocalPlayer
local backpack    = player:WaitForChild("Backpack")

spawn(function()
    while true do
        local shake = backpack:FindFirstChild("Tropical Shake")
        if not shake then
            warn("✅ Ya no quedan Tropical Shakes en el inventario.")
            break
        end

        warn("🕹 Encontrada Tropical Shakes:", shake, "- equipando...")
        shake.Parent = player.Character
        RunService.Heartbeat:Wait()

        if shake.Activate then
            shake:Activate()
            warn("🍹 Activada Tropical Shakes:", shake)
        elseif mouse1click then
            mouse1click()
            warn("🍹 mouse1click() sobre Tropical Shakes")
        else
            warn("⚠️ No se pudo activar Tropical Shakes: no hay Activate() ni mouse1click()")
        end

        task.wait(0.1)
    end
end)
