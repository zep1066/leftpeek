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

        while isActive do
            Wait(0)

            local camCoords = GetGameplayCamCoord()
            local camRot = GetGameplayCamRot(0)

            local coords = GetOffsetFromCoordAndHeadingInWorldCoords(camCoords.x, camCoords.y, camCoords.z, camRot.z, camOffset.x, camOffset.y, camOffset.z)

            SetCamCoord(camId, coords.x, coords.y, coords.z)
            SetCamRot(camId, camRot.x, camRot.y, camRot.z, 0)
            SetCamAffectsAiming(camId, true)
            ShowHudComponentThisFrame(14) -- Draw back Crosshair

            if not IsPlayerFreeAiming(playerId) then isActive = false end
        end

        RenderScriptCams(false, true, config.easeTime, true, false)
        DestroyCam(camId, true)
    end)
end

local function onPressed()
    if isDisabled then
        return
    end

    isActive = not isActive

    if isActive then
        if not IsPlayerFreeAiming(playerId) then return end

        startThread()
    end
end

local keyMapping = config.keyMapping
if lib and lib.name == "ox_lib" then
    lib.addKeybind({
        name =  keyMapping.name,
        description = keyMapping.description,
        defaultMapper = keyMapping.defaultMapper,
        defaultKey = keyMapping.defaultKey,
        onPressed = onPressed
    })
else
    RegisterCommand('+' .. keyMapping.name, function()
        if IsPauseMenuActive() then return end

        onPressed()
    end, false)

    RegisterCommand('-' .. keyMapping.name, function()
        if IsPauseMenuActive() then return end
    end, false)

    RegisterKeyMapping('+' .. keyMapping.name, keyMapping.description, keyMapping.defaultMapper, keyMapping.defaultKey)
end

---@param state boolean
exports("setDisabled", function(state)
    isDisabled = state
end)

---@return boolean
exports("isDisabled", function()
    return isDisabled
end)