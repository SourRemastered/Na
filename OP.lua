COREGUI = game:GetService("CoreGui")
if not game:IsLoaded() then
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = COREGUI
    notLoaded.Text = "SourPatch is waiting for the game to load"
    game.Loaded:Wait()
    notLoaded:Destroy()
end

--[[
local Thing = loadstring(game:HttpGet("https://raw.githubusercontent.com/SourRemastered/Na/refs/heads/main/Checker.lua",true))()

if not Thing then
    print("Currently Down")
    return
else
    print("Okay")
end
]]

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()
local venyx = library.new("SourPatch", 5013109572)
-- themes
local themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Glow = Color3.fromRGB(0, 0, 0),
    Accent = Color3.fromRGB(10, 10, 10),
    LightContrast = Color3.fromRGB(20, 20, 20),
    DarkContrast = Color3.fromRGB(14, 14, 14),
    TextColor = Color3.fromRGB(255, 255, 255)
}
-- first page
local page = venyx:addPage("Main", 5012544693)
local section1 = page:addSection("Section 1")
local section2 = page:addSection("Section 2")

local Players = game:GetService("Players")
local Collection = game:GetService("CollectionService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player and Player.Character
local Backpack = Player.Backpack
local Humanoid = Character:FindFirstChild("Humanoid")

local isA = game.IsA

local function CharacterCheck(plr)
    if plr.Character then
        return true
    end
    return false
end

--[[
task.spawn(
    function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua", true))()
    end
)
]]

--[[
local hookfunction = hookfunction or hookfunc or detour_function
local hookmetamethod =
    hookmetamethod or
    newcclosure(
        function(obj, method, func)
            return hookfunction(getrawmetatable(obj)[method], func)
        end
    )
local getnamecallmethod = getnamecallmethod or get_namecall_method

local BlockList = {game:GetService("Players").LocalPlayer.Backpack.ServerTraits.FallDamage}

getgenv().Nofall = false

local OldEvent
OldEvent =
    hookfunction(
    Instance.new("RemoteEvent").FireServer,
    function(Self, ...)
        if not checkcaller() and table.find(BlockList, Self) and getgenv().Nofall then
            return
        end
        return OldEvent(Self, ...)
    end
)

-- game namecall hook (makes the script detect the remotes, basically)
local OldNamecall
OldNamecall =
    hookmetamethod(
    game,
    "__namecall",
    function(Self, ...)
        local method = getnamecallmethod()
        if method == "FireServer" and isA(Self, "RemoteEvent") then
            if not checkcaller() and table.find(BlockList, Self) and getgenv().Nofall then
                return
            end
        end

        return OldNamecall(Self, ...)
    end
)]]

section1:addButton(
    "Reset",
    function()
        if CharacterCheck(Player) then
            Character:BreakJoints()
        end
    end
)

section1:addToggle(
    "No KillBricks",
    false,
    function(value)
        getgenv().KillBricks = value

        if getgenv().KillBricks == true then
            for _, v in next, game.Workspace.Killbricks:GetChildren() do
                if v:FindFirstChild("TouchInterest") then
                    v.CanTouch = false
                end
            end
        else
            for _, v in next, game.Workspace.Killbricks:GetChildren() do
                if v:FindFirstChild("TouchInterest") then
                    v.CanTouch = true
                end
            end
        end
    end
)

section1:addToggle(
    "Chat Logs",
    false,
    function(chatlogs)
        local chatFrame = Player.PlayerGui.Chat.Frame
        if chatlogs == true then
            chatFrame.ChatChannelParentFrame.Visible = true
            chatFrame.ChatBarParentFrame.Position =
                chatFrame.ChatChannelParentFrame.Position +
                UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y)
        else
            chatFrame.ChatChannelParentFrame.Visible = false
            chatFrame.ChatBarParentFrame.Position = UDim2.new(UDim.new(0, 0, 0, 0))
        end
    end
)

section1:addToggle(
    "Noclip",
    false,
    function(Nocliptoggle)
        local Noclipping = nil
        getgenv().Noclip = Nocliptoggle

        if getgenv().Noclip == true then
            local function NoclipLoop()
                if Clip == false and CharacterCheck(Player) then
                    for _, child in pairs(Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true then
                            child.CanCollide = false
                        end
                    end
                end
            end
            Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)
        else
            if Noclipping then
                Noclipping:Disconnect()
            end
        end
    end
)

section1:addToggle(
    "No Fall",
    false,
    function(value)
        getgenv().Nofall = value
    end
)

section1:addToggle(
    "NoStun",
    nil,
    function(value)
        local Nostun = nil

        if value then
            if CharacterCheck(Player) then
                Nostun =
                    Player.Character.ChildAdded:Connect(
                    function(child)
                        repeat
                            task.wait()
                        until child
                        local Stun = {
                            "NoJump",
                            "Stun",
                            "NoDash",
                            "Blocking",
                            "HeavyAttack",
                            "LightAttack",
                            "Stunned",
                            "Action"
                        }
                        if table.find(Stun, child.Name) then
                            child:Destroy()
                        end
                    end
                )
                return
            end
        end

        Nostun:Disconnect()
    end
)

section1:addToggle(
    "No Fog",
    false,
    function(nofogtoggle)
        getgenv().nofog = nofogtoggle

        for i, v in pairs(game.Lighting:GetChildren()) do
            if
                v:IsA("ColorCorrectionEffect") or v:IsA("Sky") or v:IsA("BlurEffect") or v:IsA("BloomEffect") or
                    v:IsA("SunRaysEffect")
             then
                v:Destroy()
            end
        end

        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        game.Lighting.Brightness = 1
        game.Lighting.ClockTime = 14
        game.Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
        game.Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
        game.Lighting.ExposureCompensation = 0
        game.Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        game.Lighting.FogEnd = 999999999
        game.Lighting.GeographicLatitude = 41.733
        game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        game.Lighting.GlobalShadows = true

        game.Lighting.Changed:Connect(
            function()
                game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
                game.Lighting.Brightness = 1
                game.Lighting.ClockTime = 14
                game.Lighting.ColorShift_Bottom = Color3.fromRGB(255, 255, 255)
                game.Lighting.ColorShift_Top = Color3.fromRGB(255, 255, 255)
                game.Lighting.ExposureCompensation = 0
                game.Lighting.FogColor = Color3.fromRGB(255, 255, 255)
                game.Lighting.FogEnd = 999999999
                game.Lighting.GeographicLatitude = 41.733
                game.Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
                game.Lighting.GlobalShadows = true
            end
        )

        game.Lighting.DescendantAdded:Connect(
            function(obj)
                if
                    obj:IsA("ColorCorrectionEffect") or obj:IsA("Sky") or obj:IsA("BlurEffect") or
                        obj:IsA("BloomEffect") or
                        obj:IsA("SunRaysEffect")
                 then
                    obj:Destroy()
                end
            end
        )
    end
)

section2:addButton(
    "Server Hop",
    function()
        game:GetService("StarterGui"):SetCore(
            "PromptBlockPlayer",
            Players:GetPlayers()[math.random(2, #Players:GetPlayers())]
        )
        wait(2)
        Player:Kick("Server hopping")
        wait(2)
        game:GetService("TeleportService"):TeleportAsync(game.PlaceId, Player)
    end
)

section2:addKeybind(
    "Toggle Keybind",
    Enum.KeyCode.Tab,
    function()
        venyx:toggle()
    end,
    function()
    end
)

section2:addKeybind(
    "Safe Log",
    Enum.KeyCode.BackSlash,
    function()
        game:GetService("Players").LocalPlayer:Kick("Emergency Log")
    end,
    function()
    end
)

-- second page
local theme = venyx:addPage("Misc", 5013109572)
local page2section1 = theme:addSection("Misc")

local function AutoBlock()
    local tool = Backpack:FindFirstChild("Block Training")
    local TrainingMarker = Player.PlayerGui:FindFirstChild("TrainMarker")
    local BlockRemote, UnBlockRemote = Backpack.ServerTraits.Block, Backpack.ServerTraits.Unblock
    if tool then
        Humanoid:EquipTool(tool)
        tool:Activate()

        BlockRemote:FireServer()

        repeat
            task.wait()
        until TrainingMarker.Enabled

        local Connection

        Connection =
            game["Run Service"].Heartbeat:Connect(
            function(deltaTime)
                if not TrainingMarker.Enabled then
                    Connection:Disconnect()
                    UnBlockRemote:FireServer()
                    return
                end

                local pos = TrainingMarker.StudsOffsetWorldSpace
                local characterPosition = Character.HumanoidRootPart.Position

                local flatTargetPosition = Vector3.new(pos.X, characterPosition.Y, pos.Z)
                local direction = (flatTargetPosition - characterPosition).Unit

                local newCFrame = CFrame.new(characterPosition, flatTargetPosition)

                Character.HumanoidRootPart.CFrame = newCFrame

                task.wait()
            end
        )
    end
end

local function AutoPushUp()
    local tool = Backpack:FindFirstChild("Situp Training") or Backpack:FindFirstChild("Pushup Training")

    if tool then
        Humanoid:EquipTool(tool)
        tool:Activate()

        repeat
            task.wait()
        until Character:FindFirstChild("Training")

        task.wait(5)
        local ToolName = tool.Name
        local initialWait = 0.5
        local finalWait = 0.4

        if ToolName == "Pushup Training" then
            finalWait = 0.48
        end

        local duration = 5
        local startTime = tick()

        while Character:FindFirstChild("Training") do
            ReplicatedStorage.Remotes.Train:FireServer()

            local elapsed = tick() - startTime
            local progress = math.clamp(elapsed / duration, 0, 1)
            local currentWait = initialWait - (initialWait - finalWait) * progress
            print(currentWait)
            task.wait(currentWait)
        end
    else
        warn("Training tool not found in the backpack.")
    end
end

local oldspeed = 0

if Character:FindFirstChild("SpeedBoost") then
    oldspeed = Character.SpeedBoost.Value
end

page2section1:addToggle(
    "WalkSpeed",
    false,
    function(wstoggleval)
        getgenv().wstoggle = wstoggleval

        if getgenv().wstoggle == true then
            local ws = Instance.new("IntValue")
            ws.Name = "SpeedBoost"
            ws.Parent = Character
        else
            if Character:FindFirstChild("SpeedBoost") then
                Character.SpeedBoost.Value = oldspeed
            end
        end
    end
)

page2section1:addSlider(
    "WalkSpeed",
    0,
    0,
    300,
    function(walkspeedvalue)
        if getgenv().wstoggle == true and Character:FindFirstChild("SpeedBoost") then
            Character.SpeedBoost.Value = walkspeedvalue
        end
    end
)

local infJump
local infJumpDebounce = true
page2section1:addToggle(
    "InfJump",
    nil,
    function(InfJp)
        if infJump then
            infJump:Disconnect()
        end
        infJumpDebounce = InfJp
        infJump =
            UserInputService.JumpRequest:Connect(
            function()
                if not infJumpDebounce then
                    infJumpDebounce = true
                    Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                    wait()
                    infJumpDebounce = false
                end
            end
        )
    end
)

page2section1:addToggle(
    "tp projectiles",
    function(value)
        local Connect = nil

        if value then
            Connect =
                game:GetService("Workspace").FX.ChildAdded:Connect(
                function(child)
                    repeat
                        game:GetService("RunService").Heartbeat:Wait()
                        child.Position = game:GetService("Workspace").CurrentCamera.CameraSubject.Parent.Torso.Position
                    until (child == nil or child.Parent == nil)
                end
            )
        else
            if Connect then
                Connect:Disconnect()
            end
        end
    end
)

page2section1:addButton(
    "Pushup/situp Training",
    function()
        AutoPushUp()
    end
)

page2section1:addButton(
    "Block Training",
    function()
        AutoBlock()
    end
)

page2section1:addButton(
    "Self Destruct",
    function()
        for i, v in pairs(game.CoreGui:GetDescendants()) do
            if v.Name == "SourPatch" then
                v:Destroy()
            end
        end
    end
)

-- customization page
local theme = venyx:addPage("Customization", 5012544693)
local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do
    colors:addColorPicker(
        theme,
        color,
        function(color3)
            venyx:setTheme(theme, color3)
        end
    )
end

-- load
venyx:SelectPage(venyx.pages[1], true)
