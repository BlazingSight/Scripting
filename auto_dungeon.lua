local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()
local plr = game.Players.LocalPlayer
local Char = plr.Character
local humrp = Char.HumanoidRootPart
local TS = game:GetService("TweenService")
local GPO = library:CreateWindow("Blazing Hub (Grand Piece Online)")
local Farm = GPO:CreateFolder("Mob Farm")
local Misc = GPO:CreateFolder("Miscallaneous")
local Dungeon = GPO:CreateFolder("Dungeon Farm")
local SwordHandle = require(game:GetService("ReplicatedStorage").Modules.SwordHandle.SwordInfo)
local Noclipping = nil
local autostore = nil

getgenv().BigHitbox = false
getgenv().YOffset = 11.57 -- works best
getgenv().NPC = "Bandit"
getgenv().AutoFarmTog = true
getgenv().IslandESP = false
getgenv().FallDamage = true
getgenv().Weapon = "Skyblue Katana"
getgenv().TweenSpeed = 100
getgenv().Dungeon = true
getgenv().Caliber = true
getgenv().Serpent = true
getgenv().DragonBlaze = true
getgenv().BusoFarm = false
getgenv().Noclip = true
getgenv().Webhook = "https://discord.com/api/webhooks/849735927852695623/gHa_K_xxdQqsO4GzxR07uHbkt3v1glOwkOY7m1Rm55osC0CbaPL_cUryjAGfwSMaeLOI"

local Islands = {["Land of the Sky"] = Vector3.new(9025.92, 1451.81, -10552.6),["Elo's Island"] = Vector3.new(-10310.6, 21.5272, -7401.8),["Fishman Island"] = Vector3.new(8004.09, -2137.4, -17015.4),["Roca Island"] = Vector3.new(5446.71, 85.7106, -5206.39),["Fishman Cave"] = Vector3.new(5683.77, 9.23824, -16452.1),["Colosseum"] = Vector3.new(-2023.07324, 2.77896118, -7942.4375),["Shell's Town"] = Vector3.new(-395.230865, 77.6223907, -5176.5874),["Gravitos Fort"] = Vector3.new(2553.94873, 44.593853, -15712.2324)}
local Defaults = { SwordHandle[getgenv().Weapon].Range,  SwordHandle[getgenv().Weapon].Offset}

local function AutoStore(boolean)
    if boolean then
    local connection
    local Fruits = {"suke","mero","bari","bomu","zushi","gura","pika","mera","goro","magu","hie","tori","bomb","zushi","clear"}
    autostore = plr.Backpack.ChildAdded:Connect(function(child)
        local fruit = string.lower(child.Name)
        for i,v in pairs(Fruits) do
            if string.match(fruit,v) then
                Char.Humanoid:EquipTool(child)
                game:GetService("ReplicatedStorage").Events.FruitStorage:InvokeServer(true)
                local content = syn.request({
                    Url = getgenv().Webhook,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = game:GetService("HttpService"):JSONEncode({["content"] = "@everyone".." Successfully Stored "..v})
                })					
                end
            end
    end)
else
    autostore:Disconnect()
end
end

local function NoclipLoop()
	for _, child in pairs(plr.Character:GetDescendants()) do
		if child:IsA("BasePart") and child.CanCollide == true then
			child.CanCollide = false
		end
	end
end

local function spam1ss()
    for i,v in pairs(workspace.NPCs:GetChildren()) do
     if v.Name == getgenv().NPC and not getgenv().Dungeon or getgenv().Dungeon then
        if getgenv().Caliber then
        local v12 = game.ReplicatedStorage.Events.Skill:InvokeServer("36 Caliber Phoenix")
        local humrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        local v14, v15 = v12:InvokeServer(humrp.CFrame);
        v14:FireServer(v)
        end
        if getgenv().Serpent then
        wait(.1)
        local args = {
            [1] = "Raging Serpent",
            [2] = {
                ["siz"] = 1000
            }
        }
        
        game:GetService("ReplicatedStorage").Events.Skill:InvokeServer(unpack(args))
          end
          if getgenv().DragonBlaze then
        wait(.2)
        local args2 = {
            [1] = "Dragon Blaze",
            [2] = {
                [1] = v.HumanoidRootPart.Position,
                [2] = v.HumanoidRootPart.Position,
                [3] = v.HumanoidRootPart.Position,
                [4] = v.HumanoidRootPart.Position
            }
        }

        game:GetService("ReplicatedStorage").Events.Skill:InvokeServer(unpack(args2))
            end
        end
        end
end

local function IslandEsp(bool)
    local s,e = pcall(function()
        
   
    if bool and not workspace:FindFirstChild("IslandEsp") then
        
        local IslandsESP = Instance.new("Folder",workspace)
        IslandsESP.Name = "IslandEsp"
        for i,v in pairs(Islands) do
            print(i)
            local Part = Instance.new("Part")
            Part.Name = i
            Part.Anchored = true
            Part.CanCollide = false
            Part.Transparency = 1
            Part.Position = v
            Part.Parent = IslandsESP
            local ESP = Instance.new("BillboardGui",Part)
            ESP.MaxDistance = 1000000000000000000
            ESP.Adornee = Part
            ESP.AlwaysOnTop = true
            ESP.Size = UDim2.new(1000,0,1000,0)
            local TextLabel = Instance.new("TextLabel",ESP)
            TextLabel.BackgroundTransparency = 1
            TextLabel.TextColor3 = Color3.fromRGB(255,0,0)
            TextLabel.Text = i
            TextLabel.Size = UDim2.new(1,0,1,0)
        end
    elseif not bool then
        if workspace:FindFirstChild("IslandEsp") then
            workspace.IslandEsp:Destroy()
        end
    end
end)
if s then print("SuccessESP") else print(e) end
end

local function AutoFarm(type)
    if getgenv().AutoFarmTog and not Char:FindFirstChild(getgenv().Weapon)  then
        Char.Humanoid:EquipTool(plr.Backpack:FindFirstChild(getgenv().Weapon))
    end
    DB = false
	local Wave = game:GetService("Players").RedFlagRogue.PlayerGui:FindFirstChild("Matchmake").Wave
    while wait() do
        if getgenv().AutoFarmTog then
            local s,e = pcall(function()
        if not humrp:FindFirstChild("FarmVelo") then
            local BV = Instance.new("BodyVelocity",humrp)
            BV.Name = "FarmVelo"
            BV.P = 200
            BV.Velocity = Vector3.new(0,0,0)
            BV.MaxForce = Vector3.new(1e8,1e8,1e8)
        end
        if game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible == false and not getgenv().Dungeon then
            local QuestMobs = {["Bandit"] = "Daph",["Bandit Boss"] = "Ronny",["Desert Bandit"] = "Noah",["Zou Inhabitant"] = "Zen",["Castle Guard"] = "Zhen",["Head Guardian"] = "Musk",["Fishman Karate User"]= "Becky",["Gravito's Undermen"] = "Miska",["Yeti"] = "Ray",["Ryu"] = "Jenny"}
            local Quests = {["Bandit"] = "Help Raphtalia",["Bandit Boss"] = "Help Ronny",["Desert Bandit"] = "Help Noah",["Zou Inhabitant"] = "Help Zen",["Castle Guard"] = "Help zhen",["Head Guardian"] = "Help musk",["Fishman Karate User"] = "Help becky",["Gravito's Undermen"] = "Help Miska",["Yeti"] = "Road to Armament",["Ryu"] = "Help jenny"}
          
             local humrpnpc1 = workspace.NPCs:WaitForChild(QuestMobs[getgenv().NPC]).HumanoidRootPart

            print(humrpnpc1.Name.."skrtt")
            local Distance = (humrpnpc1.Position-humrp.Position).Magnitude
            
           local Tween =TS:Create(humrp,TweenInfo.new(Distance/getgenv().TweenSpeed),{CFrame = humrpnpc1.CFrame*CFrame.new(0,5,0)})
           Tween:Play()

           repeat wait() until (humrp.Position-humrpnpc1.Position).Magnitude <= 10
            print("there")
           repeat  
            if getgenv().AutoFarmTog then         
            wait(1)
            local Tween =TS:Create(humrp,TweenInfo.new(Distance/getgenv().TweenSpeed),{CFrame = humrpnpc1.CFrame*CFrame.new(0,5,0)})
           Tween:Play()
            game:GetService("ReplicatedStorage").Events.Quest:InvokeServer({"takequest",Quests[getgenv().NPC]})
            else
                break
            end
            wait()
           until game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible == true
           if not Char:FindFirstChild("BusoMelee") then
            game:GetService("ReplicatedStorage").Events.Haki:FireServer("Buso")
            end
        end

        if game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible or getgenv().Dungeon then
            spawn(function()
                while wait(.1) do
                    if getgenv().AutoFarmTog or getgenv().Dungeon then
                        if not Char:FindFirstChild("BusoMelee") and game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible and game:GetService("ReplicatedStorage")["Stats"..plr.Name].BusoBar.Value >= 10 or not Char:FindFirstChild("BusoMelee") and getgenv().Dungeon and game:GetService("ReplicatedStorage")["Stats"..plr.Name].BusoBar.Value >= 10  then
                            game:GetService("ReplicatedStorage").Events.Haki:FireServer("Buso")
                        elseif not game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible or not getgenv().Dungeon then
                            break     
                            end
                        else
                            break        
                    end
                end
            end)
        for i,v in pairs(workspace.NPCs:GetChildren()) do
            if not getgenv().Dungeon and v.Name == getgenv().NPC and v ~= nil and v:FindFirstChild("Humanoid").Health > 0 or getgenv().Dungeon and v ~= nil and v:FindFirstChild("Humanoid").Health > 0  then
            repeat
                mouse1click()
                if getgenv().AutoFarmTog and game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible or getgenv().AutoFarmTog  and getgenv().Dungeon then
                    if getgenv().NPC == "Yeti" and Char.Humanoid.Health <= 50 or Char.Humanoid.Health<= 50 and getgenv().Dungeon then
						if not getgenv().Dungeon then
                        local pos = Vector3.new(-6578.47803, 169.482346, 2009.87988)
		
                        local Distance = (pos-humrp.Position).Magnitude
            
                        local Tween =TS:Create(humrp,TweenInfo.new(Distance/getgenv().TweenSpeed),{CFrame = CFrame.new(pos)})
                        Tween:Play()
                        repeat
                            wait()
                        until Char.Humanoid.Health == Char.Humanoid.MaxHealth
                        return
					else
						local pos = v:FindFirstChild("HumanoidRootPart").Position
		
                        local Distance = (pos-humrp.Position).Magnitude
						
						repeat
						wait()
                        local Tween =TS:Create(humrp,TweenInfo.new(Distance/getgenv().TweenSpeed),{CFrame = v.HumanoidRootPart.CFrame*CFrame.new(0,110,0)})
                        Tween:Play()
                        until Char.Humanoid.Health >= Char.Humanoid.MaxHealth*.15
                        return
					end
                    end
                local humrpnpc = v:WaitForChild("HumanoidRootPart")
                local humnpc = v:WaitForChild("Humanoid")
                local Distance = (humrpnpc.Position-humrp.Position).Magnitude
                local YDistance = (Vector3.new(0,humrpnpc.Position.Y,0)-Vector3.new(0,humrp.Position.Y,0)).Magnitude
                TS:Create(humrp,TweenInfo.new(Distance/getgenv().TweenSpeed),{CFrame = humrpnpc.CFrame*CFrame.new(0,getgenv().YOffset,0)}):Play()
                SwordHandle[getgenv().Weapon].Offset = CFrame.new(0,-(YDistance+2),0)
                spawn(function()
                    if not DB then
						print("Using skill")
                spam1ss()
               DB = true
               wait(1)
               DB = false
               end
                end)
             
                elseif not getgenv().AutoFarmTog or not getgenv().Dungeon then
                    SwordHandle[getgenv().Weapon].Offset = CFrame.new(0,0,-25)
                    print("nigerstoppedcuzgay12")
                    break
                end
                wait()
            until v == nil or v.Humanoid.Health <= 0 or not getgenv().Dungeon and not game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible or Wave.Text == "Wave 25"
        elseif not game:GetService("Players").LocalPlayer.PlayerGui.Quest.Quest.Visible or not getgenv().Dungeon or Wave.Text == "Wave 25" then
          break
         end
        end
    end
    end)
    if s then print("SUCCESS!") else print(e) end
elseif not getgenv().AutoFarmTog then
    humrp:FindFirstChild("FarmVelo"):Destroy()
    SwordHandle[getgenv().Weapon].Offset = CFrame.new(0,0,-25)
    break
    end
    end
end


local function BusoFarm(bool)
  if getgenv().BusoFarm then
    local BusoBar = game.ReplicatedStorage:FindFirstChild("Stats"..plr.Name).BusoBar
  if not humrp:FindFirstChild("BusoMelee") then
    game:GetService("ReplicatedStorage").Events.Haki:FireServer("Buso")
  end
   connection = BusoBar:GetPropertyChangedSignal("Value"):Connect(function(value)
      if BusoBar.Value == BusoBar.MaxValue then
        if not humrp:FindFirstChild("BusoMelee") then
            game:GetService("ReplicatedStorage").Events.Haki:FireServer("Buso")
          end
      end
  end)
else
    connection:Disconnect()
end
end

    plr = game.Players.LocalPlayer
    Char = plr.Character    
    humrp = Char.HumanoidRootPart
    if getgenv().AutoFarmTog then
        spawn(function()
            AutoFarm()
        end)
    end

    if getgenv().Dungeon then
        spawn(function()
             AutoFarm()
             AutoStore()
             Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
        end)
    end
    if getgenv().FallDamage then
        humrp.OriginalSize.Name = "geppo"
    end
	if getgenv().Noclip then
		NoclipLoop()
	end
    end)


    Farm:Dropdown("Weapon",{"Katana","Skyblue Katana","Ryu's Blade","Seabeast Katana"},true,function(weapon)
    getgenv().Weapon = weapon
    
-- Mob Farm Features
Farm:Dropdown("NPC",{"Bandit","Bandit Boss","Desert Bandit","Zou Inhabitant","Castle Guard","Gravito's Undermen","Fishman Karate User","Yeti","Ryu"},true,function(mob)
    getgenv().NPC = mob
end)

Farm:Toggle("Auto-Farm",function(boolean)
    getgenv().AutoFarmTog = boolean
    spawn(function()
        AutoFarm("Mob")
    end)
end)

Farm:Slider("TweenSpeed",{min = 80, max = 150, precise = true},function(value)
    getgenv().TweenSpeed = value
end)

Farm:Slider("Y Offset",{min = -30, max = 200, precise = true},function(value)
    getgenv().YOffset = value
end)

Farm:Toggle("Big Hitbox",function(boolean)
    if boolean then
    SwordHandle[getgenv().Weapon].Offset = CFrame.new(0,0,-25)
    SwordHandle[getgenv().Weapon].Range = Vector3.new(16*5,18*5,14*5)
    else
        SwordHandle[getgenv().Weapon].Range = Defaults[1]
        SwordHandle[getgenv().Weapon].Offset =Defaults[2]
    end
end)

-- Dungeon
Dungeon:Toggle("Dungeon Farm",function(boolean)
    getgenv().Dungeon = boolean
    spawn(function()
		Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
    end)
end)

Dungeon:Box("Webhook","string",function(url)
	getgenv().Webhook = url
	print("Set Webhook to ",url)
end)
	
Dungeon:Toggle("Auto Store",function(boolean)
	AutoStore(boolean)
end)
-- Utility
Misc:Toggle("Island ESP", function(boolean)
    IslandEsp(boolean)
    getgenv().IslandESP = boolean
end)

Misc:Toggle("Buso Farm",function(boolean)
    getgenv().BusoFarm = boolean
   BusoFarm(boolean)
end)

Misc:Toggle("Fall Damage",function(boolean)
    getgenv().FallDamage = boolean
    if boolean then
        Char.HumanoidRootPart.OriginalSize.Name = "OriginalSize"
    else
        Char.HumanoidRootPart.Name = "OriginalSize"
    end
end)

Misc:Slider("WalkSpeed", {min = Char.Humanoid.WalkSpeed, max = 100,precise = true},function(number)
    local gmt = getrawmetatable(game)
    setreadonly(gmt,false)
    local oldindex = gmt.__index
    gmt.__index = newcclosure(function(self,b)
        if b == "WalkSpeed" then
            return 16
        end
        return oldindex(self,b)
    end)
    Char.Humanoid.WalkSpeed = number
end)


Misc:Toggle("Caliber Phoenix",function(boolean)
    getgenv().Caliber = boolean
end)

Misc:Toggle("Raging Serpent",function(boolean)
    getgenv().Serpent = boolean
end)

Misc:Toggle("Dragon Blaze",function(boolean)
    getgenv().DragonBlaze = boolean
end)

Misc:Toggle("Noclip",function(boolean)
	if boolean then
	Noclipping = game:GetService('RunService').Stepped:Connect(NoclipLoop)
	else
		Noclipping:Disconnect()
	end
end)
