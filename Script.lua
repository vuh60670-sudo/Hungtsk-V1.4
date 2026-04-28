--[[ 
    🔥 HÙNG FORSAKEN HUB V1.4 - AUTO FIX 🔥
    - Fix: Underground tự động trồi lên sau 3s
    - Fix: Nút thu nhỏ (_) cố định
    - Fix: Ghost Mode tắt là hiện hình
]]

local _0xLogic = [[
local P = game:GetService("Players")
local R = game:GetService("RunService")
local C = game:GetService("CoreGui")
local L = P.LocalPlayer
local U = {G = false, S = false, U = false, T = nil}

-- 1. WATERMARK CẦU VỒNG
local function CreateWM()
    if C:FindFirstChild("ForsakenWM") then C.ForsakenWM:Destroy() end
    local wm = Instance.new("ScreenGui", C); wm.Name = "ForsakenWM"
    local lb = Instance.new("TextLabel", wm)
    lb.Size = UDim2.new(0,300,0,50); lb.Position = UDim2.new(1,-310,1,-60); lb.BackgroundTransparency = 1
    lb.Font = Enum.Font.SourceSansBold; lb.TextSize = 25; lb.TextXAlignment = 2
    R.RenderStepped:Connect(function()
        lb.Text = "HÙNG FORSAKEN V1.4"
        lb.TextColor3 = Color3.fromHSV(tick()%2.5/2.5, 0.8, 1)
    end)
end
task.spawn(CreateWM)

-- 2. GIAO DIỆN CHÍNH
if C:FindFirstChild("H_F_V14") then C.H_F_V14:Destroy() end
local gui = Instance.new("ScreenGui", C); gui.Name = "H_F_V14"
local f = Instance.new("Frame", gui); f.Size = UDim2.new(0,200,0,260); f.Position = UDim2.new(0.5,-100,0.4,0); f.BackgroundColor3 = Color3.fromRGB(15,15,20); f.Active = true; f.Draggable = true
Instance.new("UICorner", f)

local head = Instance.new("TextLabel", f); head.Size = UDim2.new(1,0,0,35); head.BackgroundColor3 = Color3.fromRGB(120,0,200); head.Text = "FORSAKEN V1.4"; head.TextColor3 = Color3.new(1,1,1); head.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", head)

local body = Instance.new("Frame", f); body.Size = UDim2.new(1,0,1,-35); body.Position = UDim2.new(0,0,0,35); body.BackgroundTransparency = 1

-- NÚT THU NHỎ
local isMini = false
local minBtn = Instance.new("TextButton", head)
minBtn.Text = "_"; minBtn.Size = UDim2.new(0,30,1,0); minBtn.Position = UDim2.new(1,-35,0,0); minBtn.BackgroundTransparency = 1; minBtn.TextColor3 = Color3.new(1,1,1); minBtn.TextSize = 20
minBtn.MouseButton1Click:Connect(function()
    isMini = not isMini
    f:TweenSize(isMini and UDim2.new(0,200,0,35) or UDim2.new(0,200,0,260), "Out", "Quart", 0.3, true)
    body.Visible = not isMini
end)

-- 3. XỬ LÝ GHOST
local function UpdateGhost(val)
    local char = L.Character
    if char then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = val and 1 or 0 end
        end
        if char:FindFirstChild("HumanoidRootPart") then char.HumanoidRootPart.Transparency = 1 end
    end
end

local function _AB(n, y, c, isToggle)
    local bt = Instance.new("TextButton", body); bt.Text = n..": OFF"; bt.Size = UDim2.new(0.9,0,0,42); bt.Position = UDim2.new(0.05,0,0,y); bt.BackgroundColor3 = Color3.fromRGB(150,0,0); bt.TextColor3 = Color3.new(1,1,1); bt.Font = Enum.Font.SourceSansBold
    Instance.new("UICorner", bt)
    local a = false
    bt.MouseButton1Click:Connect(function()
        if isToggle then
            a = not a
            bt.Text = n..(a and ": ON" or ": OFF")
            bt.BackgroundColor3 = a and Color3.fromRGB(0,150,0) or Color3.fromRGB(150,0,0)
            c(a)
        else
            c(bt)
        end
    end)
end

R.Stepped:Connect(function()
    if not L.Character or not L.Character:FindFirstChild("HumanoidRootPart") then return end
    if U.S and U.T and U.T.Character then
        L.Character.HumanoidRootPart.CFrame = U.T.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
    end
    if U.G or U.U then
        for _,p in pairs(L.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
    end
end)

_AB("GHOST", 15, function(s) U.G = s; UpdateGhost(s) end, true)
_AB("STICKY", 75, function(s) 
    U.S = s; U.T = nil
    if s then for _,v in pairs(P:GetPlayers()) do if v ~= L and v.Character then U.T = v break end end end
end, true)

-- FIX UNDERGROUND 3S
_AB("UNDER", 135, function(btn)
    if U.U then return end
    local root = L.Character and L.Character:FindFirstChild("HumanoidRootPart")
    if root then
        U.U = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        local oldPos = root.CFrame
        root.CFrame = oldPos * CFrame.new(0, -15, 0)
        
        task.spawn(function()
            for i = 3, 1, -1 do
                btn.Text = "WAIT: " .. i .. "s"
                task.wait(1)
            end
            root.CFrame = oldPos
            U.U = false
            btn.Text = "UNDER: OFF"
            btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        end)
    end
end, false)
]]

loadstring(_0xLogic)()
