local isDisabled = false
local isActive = false
local playerId = PlayerId()

local function startThread()
    Citizen.CreateThread(function()
        local camFov = GetGameplayCamFov()
        local camId = CreateCamera("DEFAULT_SCRIPTED_CAMERA", true)
        local camOffset = config.camOffset

        SetCamFov(camId, camFov)
        RenderScriptCams(true, true, config.easeTime, true, false)
        SetCamAffectsAiming(camId, true)

        while isActive do
            local camCoords = GetGameplayCamCoord()
            local camRot = GetGameplayCamRot(0)
            local coords = GetOffsetFromCoordAndHeadingInWorldCoords(camCoords.x, camCoords.y, camCoords.z, camRot.z, camOffset.x, camOffset.y, camOffset.z)

            SetCamCoord(camId, coords.x, coords.y, coords.z)
            SetCamRot(camId, camRot.x, camRot.y, camRot.z, 0)
            ShowHudComponentThisFrame(14) -- Draw back Crosshair

            if not IsPlayerFreeAiming(playerId) or GetFollowPedCamViewMode() >= 3 then isActive = false end

            Wait(0)
        end

        RenderScriptCams(false, true, config.easeTime, true, false)

        Wait(config.easeTime * 2)

        DestroyCam(camId, true)
    end)
end

local function onPressed()
    if isDisabled then
        return
    end

    isActive = not isActive

    if isActive then
        if not IsPlayerFreeAiming(playerId) or GetFollowPedCamViewMode() >= 3 then isActive = false return end

        startThread()
    end
end

local keyMapping = config.keyMapping
RegisterCommand(keyMapping.name, function()
    if IsPauseMenuActive() then return end

    onPressed()
end, false)

RegisterKeyMapping(keyMapping.name, keyMapping.description, keyMapping.defaultMapper, keyMapping.defaultKey)

---@param state boolean
exports("setDisabled", function(state)
    isDisabled = state
end)

---@return boolean
exports("isDisabled", function()
    return isDisabled
end)