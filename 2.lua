getgenv().AntiFlyActive = not getgenv().AntiFlyActive

if getgenv().AntiFlyActive then
    print("🛡️ Anti-Fly ACTIVADO")

    local player = game.Players.LocalPlayer
    local runService = game:GetService("RunService")

    getgenv().AntiFlyConnection = runService.Heartbeat:Connect(function()
        local char = player.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local ray = Ray.new(root.Position, Vector3.new(0, -500, 0))
        local hit, position = workspace:FindPartOnRay(ray, char)

        if hit then
            local groundY = position.Y
            local currentY = root.Position.Y
            if currentY - groundY > 0.5 then
                root.CFrame = CFrame.new(root.Position.X, groundY + 0.5, root.Position.Z)
                humanoid.PlatformStand = true
                humanoid.PlatformStand = false
            end
        end
    end)

else
    print("🛑 Anti-Fly DESACTIVADO")
    if getgenv().AntiFlyConnection then
        getgenv().AntiFlyConnection:Disconnect()
        getgenv().AntiFlyConnection = nil
    end
end
