if([[
    --"Royal High Farm V2 | Made with <3 by Kaid#0001 | にゃ＜３"
]]):len() ~= 70 then while true do end end

--Settings
local addedDelay = .5 -- Extra delay for each gem teleport | Recommend .5 or more to make sure the gems are picked up
local gemLimit = 400000 -- Gem count the farm will stop at, avoids you getting trade banned, the lower the number the better
local mode = "unsafe" -- Modes : "safe" ; "unsafe" ; "veryunsafe"
--End Settings

repeat task.wait() until game:IsLoaded()

math.randomseed(tick())
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local repStorage = game:GetService("ReplicatedStorage")
local ls = game:GetService("LogService")
local ws = game:GetService("Workspace")
local tws = game:GetService("TweenService")
local https = game:GetService("HttpService")

local UI = game:GetObjects("rbxassetid://11103122108")[1]

UI.Main.FarmLimit.Text = gemLimit
UI.Main.TotalCash.Text = string.gsub(plr.PlayerGui.HUD.Center.DiamondAmount.Text, ",", "")

for i,v in pairs(UI:GetDescendants()) do
    if v:IsA("UIGradient") then
        v.Offset = Vector2.new(-.5,-.5)
        local twig = TweenInfo.new(4,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut,-1,true,.2)
        local tweeng = tws:Create(v,twig,{["Offset"]=Vector2.new(.5,.5)})
        tweeng:Play()
    end
end

--Drag script by Tiffblox
local a=game:GetService("UserInputService")local b=UI.Main;local c;local d;local e;local f;local function g(h)local i=h.Position-e;b.Position=UDim2.new(f.X.Scale,f.X.Offset+i.X,f.Y.Scale,f.Y.Offset+i.Y)end;b.InputBegan:Connect(function(h)if h.UserInputType==Enum.UserInputType.MouseButton1 or h.UserInputType==Enum.UserInputType.Touch then c=true;e=h.Position;f=b.Position;h.Changed:Connect(function()if h.UserInputState==Enum.UserInputState.End then c=false end end)end end)b.InputChanged:Connect(function(h)if h.UserInputType==Enum.UserInputType.MouseMovement or h.UserInputType==Enum.UserInputType.Touch then d=h end end)a.InputChanged:Connect(function(h)if h==d and c then g(h)end end)

local function parentHui(ui)
    if gethui then
        ui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ui)
        ui.Parent = game:GetService("CoreGui")
    elseif gethiddengui then
        ui.Parent = gethiddengui()
    else
        ui.Parent = game:GetService("CoreGui")
    end
end

local function getRoot()
    return plr.Character.Humanoid.RootPart or nil
end

local function tweenTo(obj)
    local tween
    if mode == "safe" then
        if (getRoot().CFrame.Position-obj.CFrame.Position).Magnitude > 500 then
            tween = tws.Create(tws,getRoot(),TweenInfo.new(6+math.random()),{CFrame = CFrame.new(obj.CFrame.X+math.random(),obj.CFrame.Y+math.random(),obj.CFrame.Z+math.random())})
        elseif (getRoot().CFrame.Position-obj.CFrame.Position).Magnitude > 100 then
            tween = tws.Create(tws,getRoot(),TweenInfo.new(2+math.random()),{CFrame = CFrame.new(obj.CFrame.X+math.random(),obj.CFrame.Y+math.random(),obj.CFrame.Z+math.random())})
        else
            tween = tws.Create(tws,getRoot(),TweenInfo.new(.25+math.random()),{CFrame = CFrame.new(obj.CFrame.X+math.random(),obj.CFrame.Y+math.random(),obj.CFrame.Z+math.random())})
        end
    elseif mode == "unsafe" then
        if (getRoot().CFrame.Position-obj.CFrame.Position).Magnitude > 200 then
            tween = tws.Create(tws,getRoot(),TweenInfo.new(1+math.random()),{CFrame = CFrame.new(obj.CFrame.X+math.random(),obj.CFrame.Y+math.random(),obj.CFrame.Z+math.random())})
        else
            tween = tws.Create(tws,getRoot(),TweenInfo.new(.25+math.random()),{CFrame = CFrame.new(obj.CFrame.X+math.random(),obj.CFrame.Y+math.random(),obj.CFrame.Z+math.random())})
        end
    elseif mode == "veryunsafe" then
        tween = tws.Create(tws,getRoot(),TweenInfo.new(.1),{CFrame = CFrame.new(obj.CFrame.X+math.random(),obj.CFrame.Y+math.random(),obj.CFrame.Z+math.random())})
    end
    tween.Play(tween)
    tween.Completed:Wait()
end

-- Support checks
if not (isfolder and makefolder and writefile and readfile and isfile and hookmetamethod and newcclosure) then
    plr:Kick("\n\nYour eploit doesn't support this script\n(x.synapse.to | script-ware.com)\n")
    return
end

local executor = identifyexecutor or getexecutorname or nil

if (not executor or (not (executor():find("Synapse X") or executor() == "ScriptWare") or (not syn and executor() ~= "ScriptWare"))) and not _G.badExploit then
    plr:Kick("\n\nThis script is only assured support for Synapse X and Semi-Support for ScriptWare, if you would like to continue despite this warning, \nadd _G.badExploit = true to the start of the script\n")
end

-- Create File System
if not isfolder("RHFarmKaid_UwU") then
    makefolder("RHFarmKaid_UwU")
end

if not isfile("RHFarmKaid_UwU/settings.lgbt") then
    local tbl = {
        ["addedDelay"] = addedDelay,
        ["gemLimit"] = gemLimit,
        ["mode"] = mode
    }
    writefile("RHFarmKaid_UwU/settings.lgbt", https:JSONEncode(tbl))
end

local setts = https:JSONDecode(readfile("RHFarmKaid_UwU/settings.lgbt"))
addedDelay = setts.addedDelay
gemLimit = setts.gemLimit
mode = setts.mode

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self,...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    
    if NamecallMethod == "FireServer" and not checkcaller() then
        if tostring(self) == "Clicked" then
            print'Game attempted to fire FakeClick, blocked...'
            return task.wait(9e9)
        end
        
        if tostring(self) == "ReportError"  then
            print'Game attempted to fire ReportError, blocked...'
            return
        end
    end
    
    return oldNamecall(self,...)
end))

if game.PlaceId ~= 1765700510 and game.PlaceId ~= 1067560271 then
    plr.OnTeleport:Connect(function(State)
        local qot = syn.queue_on_teleport or queue_on_teleport
        if State == Enum.TeleportState.Started and qot then
            qot([[loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaiddd/rhFarm/main/script.lua", true))()]])
        end
    end)
    repStorage.Network.Events.Gui.TeleportGuiScepterAnimation:FireServer(true)
    task.wait(3 + math.random()*2)
    repStorage.SceptorTeleport:FireServer("New Royale")
    return
end

for i,v in pairs(getconnections(ls.MessageOut)) do
    v:Disable()
end

--Antiafk https://v3rmillion.net/showthread.php?tid=772135
local vu = game:GetService("VirtualUser")
plr.Idled:Connect(function()
    local vect2 = Vector2.new(0,0),workspace.CurrentCamera.CFrame
    vu:Button2Down(vect2)
    task.wait(1)
    vu:Button2Up(vect2)
end)

repStorage.Network.Events.Gui.Currency.Update.OnClientEvent:Connect(function(value)
    UI.Main.TotalCash.Text = value

    if tonumber(value) > gemLimit then
        plr:Kick("\n[Kaid's Autofarm]\nYou hit/exceeded the limit specified in your gemLimit variable\nEither spend your gems now or increase your gemLimit variable!\n(This is to prevent supposed trade-bans)")
    end
end)

repStorage.Network.Events.Player.Wings.Flying:FireServer(true)
if math.random() > .5 then
    repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3273005577")
else
    repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3272679228")
end

if plr.PlayerGui:FindFirstChild("StartingGUI") and not plr.Backpack:FindFirstChild("LoveDorm") then
    firesignal(plr.PlayerGui.StartingGUI.one.love.MouseButton1Down)
    task.wait()
    firesignal(plr.PlayerGui.StartingGUI.one.love.MouseButton1Click)
    task.wait(.5)
    firesignal(plr.PlayerGui.StartingGUI.two.Done.MouseButton1Down)
    task.wait()
    firesignal(plr.PlayerGui.StartingGUI.two.Done.MouseButton1Click)
end

plr.CharacterAdded:Connect(function()
    plr.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
        if plr.Character.Humanoid.Sit then
            task.wait(.1)
            plr.Character.Humanoid.Sit = false
        end
    end)
end)

if plr.Character and plr.Character:FindFirstChild("Humanoid") then
    plr.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
        if plr.Character.Humanoid.Sit then
            task.wait(.1)
            plr.Character.Humanoid.Sit = false
        end
    end)
else
    plr.Character:WaitForChild("Humanoid")
    plr.Character.Humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
        if plr.Character.Humanoid.Sit then
            task.wait(.1)
            plr.Character.Humanoid.Sit = false
        end
    end)
end

plr.PlayerGui.CaptchaGui:GetPropertyChangedSignal("Enabled"):Connect(function()
    if plr.PlayerGui.CaptchaGui.Enabled then
        for i,v in pairs(plr.PlayerGui.CaptchaGui.Captcha.FloatArea:GetChildren()) do
            local absolute = v.AbsoluteSize.X
            task.wait(.25)
            if absolute ~= v.AbsoluteSize.X then
                firesignal(v.MouseButton1Down)
                task.wait()
                firesignal(v.MouseButton1Click)
                task.wait(.01)
            end
        end
        task.wait(.25)
        firesignal(plr.PlayerGui.CaptchaGui.Award.Close.MouseButton1Down)
        task.wait()
        firesignal(plr.PlayerGui.CaptchaGui.Award.Close.MouseButton1Click)
    end
end)

if plr.PlayerGui.CaptchaGui.Enabled then
    for i,v in pairs(plr.PlayerGui.CaptchaGui.Captcha.FloatArea:GetChildren()) do
        local absolute = v.AbsoluteSize.X
        task.wait(.25)
        if absolute ~= v.AbsoluteSize.X then
            firesignal(v.MouseButton1Down)
            task.wait()
            firesignal(v.MouseButton1Click)
            task.wait(.01)
        end
    end
    task.wait(.25)
    firesignal(plr.PlayerGui.CaptchaGui.Award.Close.MouseButton1Down)
    task.wait()
    firesignal(plr.PlayerGui.CaptchaGui.Award.Close.MouseButton1Click)
end

local function sHop()
    plr.OnTeleport:Connect(function(State)
        local qot = syn.queue_on_teleport or queue_on_teleport
        if State == Enum.TeleportState.Started and qot then
            qot([[loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaiddd/rhFarm/main/script.lua", true))()]])
        end
    end)
    if game.PlaceId == 1067560271 then
        repStorage.Network.Events.Gui.TeleportGuiScepterAnimation:FireServer(true)
        task.wait(3 + math.random()*2)
        repStorage.SceptorTeleport:FireServer("New Royale")
        return
    end
    if game.PlaceId == 1765700510 then
        repStorage.Network.Events.Gui.TeleportGuiScepterAnimation:FireServer(true)
        task.wait(3 + math.random()*2)
        repStorage.SceptorTeleport:FireServer("Enchantix")
        return
    end
end

parentHui(UI)

if game.PlaceId == 1765700510 then
    for i,v in pairs(ws:GetDescendants()) do
        if v.Name == "FancyTeleportScript" then
            v.Parent:Destroy()
        end
    end
    local dFolder = ws:FindFirstChild("CollectibleDiamonds")
    if not dFolder then
        plr:Kick("\nRoyale High renamed the Diamond folder it seems, report bug to Kaid#0001 to get it fixed\n")
    end
    repeat
        for i,v in pairs(dFolder:GetChildren()) do
            if (getRoot().CFrame.Position-v.CFrame.Position).Magnitude > 5000 then
                v:Destroy()
                break
            end
            repStorage.Network.Events.Player.Wings.Flying:FireServer(true)
            if math.random() > .5 then
                repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3273005577")
            else
                repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3272679228")
            end
            task.wait(addedDelay)
            tweenTo(v)
        end
    until not dFolder:GetChildren()[1]
    sHop()
elseif game.PlaceId == 1067560271 then
    local dFolder = ws:FindFirstChild("CollectibleDiamonds")
    if not dFolder then
        plr:Kick("\nRoyale High renamed the Diamond folder it seems, report bug to Kaid#0001 to get it fixed\n")
    end

    local specials = {}
    local normals = {}

    for i,v in pairs(dFolder:GetChildren()) do
       if v.Name ~= "specialdiamond" then table.insert(specials,v) else table.insert(normals,v) end
    end
    for i=1,3 do
        specials = {}
        normals = {}

        for i,v in pairs(dFolder:GetChildren()) do
            if v.Name ~= "specialdiamond" then table.insert(specials,v) else table.insert(normals,v) end
        end

        for i,v in pairs(normals) do
            for i,v in pairs(specials) do
                if v.Transparency == 0 then
                    repStorage.Network.Events.Player.Wings.Flying:FireServer(true)
                    if math.random() > .5 then
                        repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3273005577")
                    else
                        repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3272679228")
                    end
                    task.wait(addedDelay)
                    tweenTo(v)
                end
            end
            if v.Transparency == 0 then
                repStorage.Network.Events.Player.Wings.Flying:FireServer(true)
                if math.random() > .5 then
                    repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3273005577")
                else
                    repStorage.Fly.StateChanged:FireServer(true, "rbxassetid://3272679228")
                end
                task.wait(addedDelay)
                tweenTo(v)
            end
        end
    end
    
    sHop()
else
    plr:Kick("Major Error, don't know how you got this, wrong game? If you are even running this script in Royale High and got this, contact Kaid#0001")
end
