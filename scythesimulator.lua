local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
local Window = OrionLib:MakeWindow({Name = "Scythe Simulator Script - Retro", HidePremium = true, SaveConfig = true, ConfigFolder = "OrionTest"})


local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


MainTab:AddButton({
    Name = "Remove Notifications",
    Callback = function()
        local player = game.Players.LocalPlayer
        local notificationsFrame = player:WaitForChild("PlayerGui"):FindFirstChild("MainGui"):FindFirstChild("NotificationsFrame")
        if notificationsFrame then
            notificationsFrame:Destroy()
            print("Notifications removed successfully.")
        else
            warn("NotificationsFrame not found.")
        end
    end
})


local FarmingTab = Window:MakeTab({
    Name = "Farming",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

FarmingTab:AddToggle({
    Name = "Auto-Farm",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        local farmInterval = 0.5  
        while _G.AutoFarm do
            local player = game.Players.LocalPlayer
            local character = player.Character
            local tool = character and character:FindFirstChildOfClass("Tool")
            
            if tool then
                
                local success, errorMessage = pcall(function()
                    tool:Activate()
                end)
                
                if not success then
                    warn("Failed to activate tool: " .. tostring(errorMessage))
                end
            end
            
            wait(farmInterval)
        end
    end    
})


local RebirthTab = Window:MakeTab({
    Name = "Rebirth",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

RebirthTab:AddToggle({
    Name = "Auto Rebirth",
    Default = false,
    Callback = function(Value)
        _G.AutoRebirth = Value
        while _G.AutoRebirth do
            local player = game.Players.LocalPlayer
            local rebirthRemote = game:GetService("ReplicatedStorage"):FindFirstChild("RebirthPlayer")
            if rebirthRemote then
                local success, result = pcall(function()
                    return rebirthRemote:FireServer()
                end)
                if not success then
                    warn("Failed to perform rebirth: " .. tostring(result))
                end
            end
            wait(5)
        end
    end
})


local EggsTab = Window:MakeTab({
    Name = "Eggs",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local eggs = "Egg1" 

EggsTab:AddDropdown({
    Name = "Choose which egg to auto-hatch",
    Default = eggs,
    Options = {"Egg1", "Egg2", "Egg3", "Egg4", "Egg5", "Egg6", "Egg7", "Egg8", "Egg9", "Egg10", "Egg11", "Egg12", "Egg13", "Egg14", "Egg15"},
    Callback = function(Value)
        eggs = Value
    end
})

EggsTab:AddToggle({
    Name = "Auto Hatch Egg",
    Default = false,
    Callback = function(Value)
        getgenv().egs = Value
        while getgenv().egs do
            local success, result = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("HatchPet"):FireServer(eggs, 1, 44)
            end)
            
            if not success then
                warn("Failed to hatch egg: " .. tostring(result))
            end
            
            wait(0.2)
        end
    end
})


local QuestTab = Window:MakeTab({
    Name = "Quests",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

QuestTab:AddButton({
    Name = "Instant Quest Completion",
    Callback = function()
        local player = game.Players.LocalPlayer
        local questData = player.PlayerData and player.PlayerData:FindFirstChild("QuestData")

        if questData and questData:FindFirstChild("CanClaim") then
            questData.CanClaim.Value = true
            print("Quest can be claimed instantly")
        else
            warn("QuestData or CanClaim not found.")
        end
    end
})


local PlaytimeRewardsTab = Window:MakeTab({
    Name = "Playtime Rewards",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

PlaytimeRewardsTab:AddButton({
    Name = "Claim Playtime Rewards",
    Callback = function()
        local function claimRewards()
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("PlaytimeRewards")

            if remote then
                if remote:IsA("RemoteFunction") then
                    local success, result = pcall(function()
                        return remote:InvokeServer()
                    end)

                    if success then
                        print("Playtime rewards claimed successfully.")
                    else
                        warn("Failed to claim playtime rewards. Error: " .. tostring(result))
                    end
                elseif remote:IsA("RemoteEvent") then
                    local success, result = pcall(function()
                        return remote:FireServer()
                    end)

                    if success then
                        print("Playtime rewards claimed successfully.")
                    else
                        warn("Failed to claim playtime rewards. Error: " .. tostring(result))
                    end
                else
                    warn("PlaytimeRewards remote is neither a RemoteFunction nor RemoteEvent.")
                end
            else
                warn("PlaytimeRewards remote not found.")
            end
        end

        
        while true do
            claimRewards()
            wait(5) 
        end
    end
})


local TeleportsTab = Window:MakeTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TeleportsTab:AddButton({
    Name = "Teleport to World 1",
    Callback = function()
        local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
        rootPart.CFrame = CFrame.new(22.797, 4.75, 0.737)
    end
})

TeleportsTab:AddButton({
    Name = "Teleport to World 2",
    Callback = function()
        local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
        rootPart.CFrame = CFrame.new(-1147.474, 4.75, 0.138)
    end
})

TeleportsTab:AddToggle({
    Name = "Auto Teleport to King in World 1",
    Default = false,
    Callback = function(Value)
        getgenv().spawnone = Value
        while getgenv().spawnone do
            local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
            rootPart.CFrame = CFrame.new(2.049, 17.1, 103.425)
            wait(2)
        end
    end
})

TeleportsTab:AddToggle({
    Name = "Auto Teleport to King in World 2",
    Default = false,
    Callback = function(Value)
        getgenv().spawntwo = Value
        while getgenv().spawntwo do
            local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
            rootPart.CFrame = CFrame.new(-1147.757, 17.1, 104.328)
            wait(2)
        end
    end
})


local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MiscTab:AddButton({
    Name = "Destroy GUI",
    Callback = function()
        OrionLib:Destroy()
    end
})

MiscTab:AddToggle({
    Name = "Anti-AFK",
    Default = false,
    Callback = function(Value)
        getgenv().antiAFK = Value
        while getgenv().antiAFK do
            local player = game.Players.LocalPlayer
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, 0.1)
                end
            end
            wait(10) 
        end
    end
})

-- Credits Tab
local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

CreditsTab:AddLabel("Script by Retro")
CreditsTab:AddLabel("yetistereo on cord")

-- Finalize
OrionLib:Init()
