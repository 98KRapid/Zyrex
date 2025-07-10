local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Create blur and tween it in
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

local blurIn = TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = 24})
blurIn:Play()
blurIn.Completed:Wait()

-- Create GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "ZyrexLoader"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundTransparency = 1

-- Background Frame
local bg = Instance.new("Frame", frame)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 10, 25)
bg.BackgroundTransparency = 1
bg.ZIndex = 0

-- Optional rounded corners for modern look
local corner = Instance.new("UICorner", bg)
corner.CornerRadius = UDim.new(0, 0)

TweenService:Create(bg, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {BackgroundTransparency = 0.25}):Play()

-- Letter Build
local word = "Zyrex"
local letters = {}

local function tweenOutAndDestroy()
	for _, label in ipairs(letters) do
		TweenService:Create(label, TweenInfo.new(0.3), {
			TextTransparency = 1,
			TextSize = 20
		}):Play()
	end

	TweenService:Create(bg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
	local blurOut = TweenService:Create(blur, TweenInfo.new(0.4), {Size = 0})
	blurOut:Play()
	blurOut.Completed:Wait()

	screenGui:Destroy()
	blur:Destroy()
end

-- Create animated letter labels
for i = 1, #word do
	local char = word:sub(i, i)

	local label = Instance.new("TextLabel")
	label.Text = char
	label.Font = Enum.Font.GothamBlack
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 1
	label.TextTransparency = 1
	label.TextSize = 30
	label.Size = UDim2.new(0, 60, 0, 60)
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.new(0.5, (i - (#word / 2 + 0.5)) * 65, 0.5, 0)
	label.BackgroundTransparency = 1
	label.ZIndex = 1
	label.Parent = frame

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 110, 180)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 60, 120))
	})
	gradient.Rotation = 90
	gradient.Parent = label

	local tweenIn = TweenService:Create(label, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		TextTransparency = 0,
		TextSize = 64
	})
	tweenIn:Play()

	table.insert(letters, label)
	wait(0.25)
end

wait(1.25)
tweenOutAndDestroy()

repeat task.wait() until player and player.Character
if not game:IsLoaded() then
	game.Loaded:Wait()
end
