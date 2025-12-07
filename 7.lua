getgenv().AutoKillGlobal = not getgenv().AutoKillGlobal

if getgenv().AutoKillGlobal then
    print("☠️ AutoKill Global ACTIVADO")

    local player = game.Players.LocalPlayer

    local function getHand()
        local char = player.Character or player.CharacterAdded:Wait()
        return char:FindFirstChild("RightHand") or char:FindFirstChild("Right Arm")
    end

    local hand

    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        hand = getHand()
    end)

    hand = getHand()

    task.spawn(function()
        while getgenv().AutoKillGlobal do
            if not hand or not hand:IsDescendantOf(workspace) then
                hand = getHand()
            end
            if hand and hand:IsDescendantOf(workspace) then
                for _, other in pairs(game.Players:GetPlayers()) do
                    if other ~= player and other.Character then
                        local targetPart = other.Character:FindFirstChild("HumanoidRootPart")
                        if targetPart and targetPart:IsDescendantOf(workspace) then
                            pcall(function()
                                firetouchinterest(hand, targetPart, 0)
                                task.wait(0.05) -- pausa razonable
                                firetouchinterest(hand, targetPart, 1)
                            end)
                            task.wait(0.05)
                        end
                    end
                end
            else
                task.wait(0.5)
            end
            task.wait(0.1)
        end
        print("🛑 AutoKill Global DESACTIVADO")
    end)

else
    print("🛑 AutoKill Global DESACTIVADO")
end
