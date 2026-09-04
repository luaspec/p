
local Config = {}
Config.NS = 60
Config.CS = 30
Config.LAGGER_SPEED = 15
Config.LAGGER_CARRY_SPEED = 24.5
Config.speedMode = false
Config.laggerToggled = false
Config.laggerPhase = 0
Config.antiRagdollEnabled = false
Config.infJumpEnabled = false
Config.autoStealEnabled = false
Config.autoBatEnabled = false
Config.autoLeftEnabled = false
Config.autoRightEnabled = false
Config.batCounterEnabled = false
Config.medusaCounterEnabled = false
Config.unwalkEnabled = false
Config.antiLagEnabled = false
Config.stretchRezEnabled = false
Config.autoTPEnabled = false
Config.stealRadius = 60
Config.stealDuration = 1.4
Config.autoTPHeight = 20
Config.mobileButtonsVisible = true
Config.mobileButtonsLocked = false
Config.speedMethod = 4  -- 1=Velocity, 2=Assembly, 3=BodyVelocity, 4=LinearVelocity, 5=WalkSpeed, 6=Hybrid
Config.KB = {
    DropBrainrot = {kb = Enum.KeyCode.X, gp = nil},
    AutoLeft     = {kb = Enum.KeyCode.Z, gp = nil},
    AutoRight    = {kb = Enum.KeyCode.C, gp = nil},
    AutoBat      = {kb = Enum.KeyCode.E, gp = nil},
    TPFloor      = {kb = Enum.KeyCode.F, gp = nil},
    InstaReset   = {kb = Enum.KeyCode.T, gp = nil},
    GuiHide      = {kb = Enum.KeyCode.LeftControl, gp = nil},
    SpeedToggle  = {kb = Enum.KeyCode.Q, gp = nil},
    LaggerToggle = {kb = Enum.KeyCode.R, gp = nil},
}

return Config
