-- ZenithGUI.lua
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("ZenithPremium_V3") then
    CoreGui:FindFirstChild("ZenithPremium_V3"):Destroy()
end

local ZenithUI = Instance.new("ScreenGui")
ZenithUI.Name = "ZenithPremium_V3"
ZenithUI.Parent = CoreGui
ZenithUI.ResetOnSpawn = false
ZenithUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- === GLASSMORPHISM COLOR PALETTE ===
local T = {
    Glass       = Color3.fromRGB(20, 20, 35),
    Surface     = Color3.fromRGB(25, 25, 45),
    Border      = Color3.fromRGB(80, 200, 255),
    Accent      = Color3.fromRGB(0, 230, 255),
    Accent2     = Color3.fromRGB(120, 240, 255),
    Text        = Color3.fromRGB(245, 245, 255),
    TextMuted   = Color3.fromRGB(160, 170, 190),
    Off         = Color3.fromRGB(35, 40, 60),
    Red         = Color3.fromRGB(255, 90, 90),
    Glow        = Color3.fromRGB(0, 220, 255),
}

local TWEEN_FAST = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TWEEN_MED  = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

local function Corner(r, p) 
    local c = Instance.new("UICorner") 
    c.CornerRadius = UDim.new(0, r) 
    c.Parent = p 
end

local function Stroke(t, c, p, trans) 
    local s = Instance.new("UIStroke") 
    s.Thickness = t 
    s.Color = c 
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border 
    s.Parent = p 
end

local function Gradient(parent, start, endc)
    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, start), ColorSequenceKeypoint.new(1, endc)}
    grad.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 0.75)}
    grad.Parent = parent
end

local function MakeDraggable(handle, target)
    local dragging, dragStart, startPos = false, nil, nil
    handle.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = inp.Position
            startPos = target.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local delta = inp.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    handle.InputEnded:Connect(function() dragging = false end)
end

local WIN_W, WIN_H = 480, 420

-- Background Glow
local GlowBG = Instance.new("Frame")
GlowBG.Name = "Glow"
GlowBG.Parent = ZenithUI
GlowBG.AnchorPoint = Vector2.new(0.5, 0.5)
GlowBG.Position = UDim2.new(0.5, 0, 0.5, 0)
GlowBG.Size = UDim2.new(0, WIN_W + 80, 0, WIN_H + 80)
GlowBG.BackgroundColor3 = T.Glow
GlowBG.BackgroundTransparency = 0.92
GlowBG.BorderSizePixel = 0
Corner(40, GlowBG)

-- Main Glass Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ZenithUI
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, WIN_W, 0, WIN_H)
MainFrame.BackgroundColor3 = T.Glass
MainFrame.BackgroundTransparency = 0.45
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
Corner(18, MainFrame)
Stroke(2, T.Border, MainFrame, 0.4)

-- Header
local Header = Instance.new("Frame")
Header.Parent = MainFrame
Header.Size = UDim2.new(1, 0, 0, 58)
Header.BackgroundTransparency = 1

local HeaderGlass = Instance.new("Frame")
HeaderGlass.Parent = Header
HeaderGlass.Size = UDim2.new(1,0,1,0)
HeaderGlass.BackgroundColor3 = T.Glass
HeaderGlass.BackgroundTransparency = 0.6
Corner(18, HeaderGlass)
Gradient(HeaderGlass, T.Accent, Color3.fromRGB(0, 100, 180))

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Parent = Header
TitleLabel.Position = UDim2.new(0, 22, 0, 0)
TitleLabel.Size = UDim2.new(1, -120, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "ZENITH <font color='#00E6FF'>PREMIUM</font> <font size='10'>V3</font>"
TitleLabel.RichText = true
TitleLabel.TextColor3 = T.Text
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 15.5
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Close & Minimize
local BtnClose = Instance.new("TextButton")
BtnClose.Parent = Header
BtnClose.Size = UDim2.new(0, 32, 0, 32)
BtnClose.Position = UDim2.new(1, -42, 0.5, -16)
BtnClose.BackgroundColor3 = Color3.fromRGB(30,10,10)
BtnClose.BackgroundTransparency = 0.4
BtnClose.Text = "✕"
BtnClose.TextColor3 = T.Red
BtnClose.Font = Enum.Font.GothamBold
BtnClose.TextSize = 14
Corner(8, BtnClose)
Stroke(1.2, T.Red, BtnClose, 0.3)

local BtnMin = Instance.new("TextButton")
BtnMin.Parent = Header
BtnMin.Size = UDim2.new(0, 32, 0, 32)
BtnMin.Position = UDim2.new(1, -78, 0.5, -16)
BtnMin.BackgroundColor3 = T.Surface
BtnMin.BackgroundTransparency = 0.5
BtnMin.Text = "−"
BtnMin.TextColor3 = T.Accent
BtnMin.Font = Enum.Font.GothamBold
BtnMin.TextSize = 18
Corner(8, BtnMin)
Stroke(1.2, T.Accent, BtnMin, 0.5)

-- Tab Bar
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.Position = UDim2.new(0, 0, 0, 58)
TabBar.Size = UDim2.new(1, 0, 0, 42)
TabBar.BackgroundTransparency = 0.7
TabBar.BackgroundColor3 = T.Glass
Corner(0, TabBar)

local tabNames = {"Farming", "Upgrades", "Utility"}
local tabButtons = {}
local TAB_W = 160

for i, name in ipairs(tabNames) do
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.Size = UDim2.new(0, TAB_W, 1, 0)
    btn.Position = UDim2.new(0, (i-1)*TAB_W, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 13.5
    btn.TextColor3 = T.TextMuted
    table.insert(tabButtons, btn)
end

local activeTabUnderline = Instance.new("Frame")
activeTabUnderline.Parent = TabBar
activeTabUnderline.Size = UDim2.new(0, TAB_W-20, 0, 3)
activeTabUnderline.Position = UDim2.new(0, 10, 1, -3)
activeTabUnderline.BackgroundColor3 = T.Accent
Corner(3, activeTabUnderline)

-- Content
local ContentWrapper = Instance.new("Frame")
ContentWrapper.Parent = MainFrame
ContentWrapper.Position = UDim2.new(0, 0, 0, 100)
ContentWrapper.Size = UDim2.new(1, 0, 1, -100)
ContentWrapper.BackgroundTransparency = 1
ContentWrapper.ClipsDescendants = true

local function MakeScrollPage()
    local sf = Instance.new("ScrollingFrame")
    sf.Size = UDim2.new(1, 0, 1, 0)
    sf.BackgroundTransparency = 1
    sf.ScrollBarThickness = 4
    sf.ScrollBarImageColor3 = T.Accent
    sf.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sf.Visible = false
    
    Instance.new("UIListLayout", sf).Padding = UDim.new(0, 12)
    Instance.new("UIPadding", sf).PaddingLeft = UDim.new(0, 16)
    Instance.new("UIPadding", sf).PaddingRight = UDim.new(0, 16)
    Instance.new("UIPadding", sf).PaddingTop = UDim.new(0, 12)
    
    sf.Parent = ContentWrapper
    return sf
end

local pages = {MakeScrollPage(), MakeScrollPage(), MakeScrollPage()}

-- Card Function
local function CreateCard(page, label, sublabel, configKey, hasInput, inputKey)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, 0, 0, 74)
    Card.BackgroundColor3 = T.Surface
    Card.BackgroundTransparency = 0.55
    Card.BorderSizePixel = 0
    Corner(16, Card)
    Stroke(1.5, T.Border, Card, 0.5)
    Card.Parent = page

    Card.MouseEnter:Connect(function() TweenService:Create(Card, TWEEN_FAST, {BackgroundTransparency = 0.4}):Play() end)
    Card.MouseLeave:Connect(function() TweenService:Create(Card, TWEEN_FAST, {BackgroundTransparency = 0.55}):Play() end)

    local LabelTxt = Instance.new("TextLabel", Card)
    LabelTxt.Position = UDim2.new(0, 20, 0, 16)
    LabelTxt.Size = UDim2.new(0.65, 0, 0, 22)
    LabelTxt.BackgroundTransparency = 1
    LabelTxt.Text = label
    LabelTxt.TextColor3 = T.Text
    LabelTxt.Font = Enum.Font.GothamSemibold
    LabelTxt.TextSize = 14.5
    LabelTxt.TextXAlignment = Enum.TextXAlignment.Left

    local SubTxt = Instance.new("TextLabel", Card)
    SubTxt.Position = UDim2.new(0, 20, 0, 38)
    SubTxt.Size = UDim2.new(0.6, 0, 0, 18)
    SubTxt.BackgroundTransparency = 1
    SubTxt.Text = sublabel
    SubTxt.TextColor3 = T.TextMuted
    SubTxt.Font = Enum.Font.Gotham
    SubTxt.TextSize = 11.5
    SubTxt.TextXAlignment = Enum.TextXAlignment.Left

    -- Toggle
    local PillBg = Instance.new("Frame", Card)
    PillBg.Size = UDim2.new(0, 48, 0, 26)
    PillBg.Position = UDim2.new(1, -64, 0.5, -13)
    PillBg.BackgroundColor3 = T.Off
    PillBg.BackgroundTransparency = 0.3
    Corner(99, PillBg)
    Stroke(1.5, T.Border, PillBg, 0.4)

    local PillKnob = Instance.new("Frame", PillBg)
    PillKnob.Size = UDim2.new(0, 20, 0, 20)
    PillKnob.Position = UDim2.new(0, 3, 0.5, -10)
    PillKnob.BackgroundColor3 = Color3.fromRGB(220,220,220)
    Corner(99, PillKnob)

    local isOn = false
    local function SetState(on)
        isOn = on
        getgenv().Config[configKey] = on
        TweenService:Create(PillBg, TWEEN_MED, {BackgroundColor3 = on and T.Accent or T.Off}):Play()
        TweenService:Create(PillKnob, TWEEN_MED, {
            Position = on and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10),
            BackgroundColor3 = on and Color3.new(1,1,1) or Color3.fromRGB(200,200,200)
        }):Play()
    end

    local ToggleBtn = Instance.new("TextButton", Card)
    ToggleBtn.Size = UDim2.new(0, 48, 0, 26)
    ToggleBtn.Position = UDim2.new(1, -64, 0.5, -13)
    ToggleBtn.BackgroundTransparency = 1
    ToggleBtn.MouseButton1Click:Connect(function() SetState(not isOn) end)

    if hasInput then
        local InputBg = Instance.new("Frame", Card)
        InputBg.Size = UDim2.new(0, 62, 0, 28)
        InputBg.Position = UDim2.new(1, -130, 0.5, -14)
        InputBg.BackgroundColor3 = T.Surface
        InputBg.BackgroundTransparency = 0.5
        Corner(8, InputBg)
        Stroke(1, T.Border, InputBg, 0.5)

        local InputBox = Instance.new("TextBox", InputBg)
        InputBox.Size = UDim2.new(1, -12, 1, 0)
        InputBox.Position = UDim2.new(0, 6, 0, 0)
        InputBox.BackgroundTransparency = 1
        InputBox.Text = tostring(getgenv().Config[inputKey])
        InputBox.TextColor3 = T.Accent2
        InputBox.Font = Enum.Font.GothamBold
        InputBox.TextSize = 13
        InputBox.ClearTextOnFocus = false
        InputBox.FocusLost:Connect(function()
            local num = tonumber(InputBox.Text)
            if num then getgenv().Config[inputKey] = num end
        end)
    end

    return SetState
end

-- Create Cards
CreateCard(pages[1], "Auto Sell Ores", "Automatically sells all ores", "AutoSell", true, "SellInterval")
CreateCard(pages[1], "Auto Rebirth", "Rebirths at specified amount", "AutoRebirth", true, "RebirthCooldown")
CreateCard(pages[2], "Auto Upgrade", "Upgrades all available stats", "AutoUpgrade", true, "UpgradeDelay")
CreateCard(pages[3], "Achievement Sweeper", "Claims all achievements", "AutoClaim", true, "ClaimSpeed")

-- Tab Switching
local function SwitchTab(idx)
    for i, page in ipairs(pages) do page.Visible = (i == idx) end
    for i, btn in ipairs(tabButtons) do
        TweenService:Create(btn, TWEEN_FAST, {TextColor3 = (i == idx) and T.Accent or T.TextMuted}):Play()
    end
    TweenService:Create(activeTabUnderline, TWEEN_MED, {
        Position = UDim2.new(0, (idx-1)*TAB_W + 10, 1, -3)
    }):Play()
end

for i, btn in ipairs(tabButtons) do
    btn.MouseButton1Click:Connect(function() SwitchTab(i) end)
end
SwitchTab(1)

-- Floating Icon
local IconBtn = Instance.new("ImageButton")
IconBtn.Name = "ZenithIcon"
IconBtn.Parent = ZenithUI
IconBtn.Size = UDim2.new(0, 58, 0, 58)
IconBtn.Position = UDim2.new(0.03, 0, 0.1, 0)
IconBtn.BackgroundColor3 = T.Glass
IconBtn.BackgroundTransparency = 0.4
IconBtn.Image = "rbxassetid://6031068433"
IconBtn.ImageColor3 = T.Accent
Corner(99, IconBtn)
Stroke(3, T.Accent, IconBtn, 0.35)

MakeDraggable(IconBtn, IconBtn)

-- Show/Hide
local guiVisible = true

local function HideGUI()
    guiVisible = false
    TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
        Size = UDim2.new(0, WIN_W, 0, 60), BackgroundTransparency = 1
    }):Play()
    task.delay(0.4, function()
        MainFrame.Visible = false
        GlowBG.Visible = false
        IconBtn.Visible = true
    end)
end

local function ShowGUI()
    guiVisible = true
    MainFrame.Visible = true
    GlowBG.Visible = true
    MainFrame.Size = UDim2.new(0, WIN_W, 0, 60)
    MainFrame.BackgroundTransparency = 1
    IconBtn.Visible = false
    TweenService:Create(MainFrame, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, WIN_W, 0, WIN_H), BackgroundTransparency = 0.45
    }):Play()
end

BtnMin.MouseButton1Click:Connect(HideGUI)
BtnClose.MouseButton1Click:Connect(HideGUI)
IconBtn.MouseButton1Click:Connect(ShowGUI)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Insert then
        if guiVisible then HideGUI() else ShowGUI() end
    end
end)

print("✅ Zenith Premium V3 GUI Loaded")
