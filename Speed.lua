
local Speed = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
Speed.currentMethod = 4
function Speed.setVelocity(hrp, x, y, z)
    hrp.Velocity = Vector3.new(x, y, z)
end
function Speed.setAssembly(hrp, x, y, z)
    hrp.AssemblyLinearVelocity = Vector3.new(x, y, z)
end
function Speed.getOrCreateBV(hrp)
    local bv = hrp:FindFirstChild("_SpeedBV")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "_SpeedBV"
        bv.Parent = hrp
        bv.MaxForce = Vector3.new(1e9, 0, 1e9)
        bv.P = 1000
    end
    return bv
end
function Speed.setBodyVelocity(hrp, x, y, z)
    local bv = Speed.getOrCreateBV(hrp)
    bv.Velocity = Vector3.new(x, y, z)
end
function Speed.clearBodyVelocity(hrp)
    local bv = hrp:FindFirstChild("_SpeedBV")
    if bv then bv:Destroy() end
end
function Speed.getOrCreateLV(hrp)
    local lv = hrp:FindFirstChild("_SpeedLV")
    local att = hrp:FindFirstChild("RootAttachment")
    if not att then
        att = Instance.new("Attachment")
        att.Name = "RootAttachment"
        att.Parent = hrp
    end
    if not lv then
        lv = Instance.new("LinearVelocity")
        lv.Name = "_SpeedLV"
        lv.Parent = hrp
        lv.Attachment0 = att
        lv.RelativeTo = Enum.ActuatorRelativeTo.World
        lv.VelocityConstraintMode = Enum.VelocityConstraintMode.Plane
        lv.PrimaryTangentAxis = Vector3.new(1, 0, 0)
        lv.SecondaryTangentAxis = Vector3.new(0, 0, 1)
        lv.MaxForce = math.huge
    end
    return lv
end

function Speed.setLinearVelocity(hrp, x, y, z)
    local lv = Speed.getOrCreateLV(hrp)
    lv.PlaneVelocity = Vector2.new(x, z)
    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, y, hrp.AssemblyLinearVelocity.Z)
end

function Speed.clearLinearVelocity(hrp)
    local lv = hrp:FindFirstChild("_SpeedLV")
    if lv then lv:Destroy() end
end
function Speed.setWalkSpeed(hum, speed)
    hum.WalkSpeed = speed
end
function Speed.setHybrid(hrp, hum, x, y, z)
    hum.WalkSpeed = math.sqrt(x*x + z*z)
    hrp.AssemblyLinearVelocity = Vector3.new(x * 0.3, y, z * 0.3)
    local lv = Speed.getOrCreateLV(hrp)
    lv.PlaneVelocity = Vector2.new(x * 0.2, z * 0.2)
end

Speed.currentSpeed = Vector3.zero
Speed.speedAlpha = 0.15

function Speed.set(hrp, hum, x, y, z)
    if not hrp or not hum then return end
    
    local maxSpeed = 80
    local spd = math.sqrt(x*x + z*z)
    if spd > maxSpeed then
        local ratio = maxSpeed / spd
        x = x * ratio
        z = z * ratio
    end
    
    local target = Vector3.new(x, y, z)
    Speed.currentSpeed = Speed.currentSpeed:Lerp(target, Speed.speedAlpha)
    x, y, z = Speed.currentSpeed.X, Speed.currentSpeed.Y, Speed.currentSpeed.Z
    
    local method = Speed.currentMethod
    if method == 1 then Speed.setVelocity(hrp, x, y, z)
    elseif method == 2 then Speed.setAssembly(hrp, x, y, z)
    elseif method == 3 then Speed.setBodyVelocity(hrp, x, y, z)
    elseif method == 4 then Speed.setLinearVelocity(hrp, x, y, z)
    elseif method == 5 then Speed.setWalkSpeed(hum, math.sqrt(x*x + z*z))
    elseif method == 6 then Speed.setHybrid(hrp, hum, x, y, z)
    end
end

function Speed.clear(hrp)
    Speed.currentSpeed = Vector3.zero
    Speed.clearBodyVelocity(hrp)
    Speed.clearLinearVelocity(hrp)
    if hrp then
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.Velocity = Vector3.zero
    end
end

function Speed.getActiveSpeed()
    local cfg = Speed.Config or {}
    if cfg.laggerToggled then
        return cfg.laggerPhase == 2 and cfg.LAGGER_CARRY_SPEED or cfg.LAGGER_SPEED
    else
        return cfg.speedMode and cfg.CS or cfg.NS
    end
end

function Speed.init(Config)
    Speed.Config = Config
    Speed.currentMethod = Config.speedMethod or 4
end

return Speed
