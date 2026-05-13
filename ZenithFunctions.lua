-- ZenithFunctions.lua
-- This file will run after the GUI

getgenv().Config = getgenv().Config or {
    AutoSell = false, SellInterval = 0.1,
    AutoRebirth = false, RebirthCooldown = 0.5,
    AutoClaim = false, ClaimSpeed = 0.01,
    AutoUpgrade = false, UpgradeDelay = 0.2,
}

print("🔧 Zenith Functions Loaded - Waiting for toggles...")

-- ==================== YOUR ACTUAL GAME LOGIC ====================

spawn(function()
    while task.wait() do
        if getgenv().Config.AutoSell then
            -- Paste your Auto Sell code here
            task.wait(getgenv().Config.SellInterval or 0.2)
        end
    end
end)

spawn(function()
    while task.wait() do
        if getgenv().Config.AutoRebirth then
            -- Paste your Rebirth code here
            task.wait(getgenv().Config.RebirthCooldown or 1)
        end
    end
end)

spawn(function()
    while task.wait() do
        if getgenv().Config.AutoUpgrade then
            -- Paste your Auto Upgrade code here
            task.wait(getgenv().Config.UpgradeDelay or 0.5)
        end
    end
end)

spawn(function()
    while task.wait() do
        if getgenv().Config.AutoClaim then
            -- Paste your Achievement Claim code here
            task.wait(getgenv().Config.ClaimSpeed or 0.1)
        end
    end
end)
