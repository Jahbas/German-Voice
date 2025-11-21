local _AUa00Zt2x7mrKBkxh3BqJO = "0.9.2beta"
local function _3rMHE8kad14NLIBNzbblXv(version1, version2)
    local function _gsWCJj1e4ZLjQRozgYV631(versionStr)
        if type(versionStr) == "number" then
            return {versionStr}
        end
        local _lNJlwV9UfHVALGkjnUem1v = tostring(versionStr)
        local _ubDvb9GSVAaa8Q3kXLlsgP = string.match(_lNJlwV9UfHVALGkjnUem1v, "^([%d%.]+)")
        if not _ubDvb9GSVAaa8Q3kXLlsgP then
            return {0}
        end
        local _Ag4RKlVyo9HMT60vZcoh3F = {}
        for part in string.gmatch(_ubDvb9GSVAaa8Q3kXLlsgP, "([%d]+)") do
            table.insert(_Ag4RKlVyo9HMT60vZcoh3F, tonumber(part) or 0)
        end
        return _Ag4RKlVyo9HMT60vZcoh3F
    end
    local _nVZWJQlqLBH69ickt31aj9 = _gsWCJj1e4ZLjQRozgYV631(version1)
    local _owIvkyuaddTCfyZ6lYaXTx = _gsWCJj1e4ZLjQRozgYV631(version2)
    local _nRGWhENdaOFuXN9A78JmxX = math.max(#_nVZWJQlqLBH69ickt31aj9, #_owIvkyuaddTCfyZ6lYaXTx)
    for i = 1, _nRGWhENdaOFuXN9A78JmxX do
        local _QShJjfFk59vonkksjIfHSa = _nVZWJQlqLBH69ickt31aj9[i] or 0
        local _jaQF4l1M7Z2gqGWzeYW9DA = _owIvkyuaddTCfyZ6lYaXTx[i] or 0
        if _QShJjfFk59vonkksjIfHSa > _jaQF4l1M7Z2gqGWzeYW9DA then
            return 1
        elseif _QShJjfFk59vonkksjIfHSa < _jaQF4l1M7Z2gqGWzeYW9DA then
            return -1
        end
    end
    local _lp64lbxvlzllKR0H5p9AGS = tostring(version1)
    local _AuhePDVmONKmViH5ovKsiI = tostring(version2)
    if _lp64lbxvlzllKR0H5p9AGS > _AuhePDVmONKmViH5ovKsiI then
        return 1
    elseif _lp64lbxvlzllKR0H5p9AGS < _AuhePDVmONKmViH5ovKsiI then
        return -1
    else
        return 0
    end
end
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local _GSXQ5ZdqXBcxZHIKgOWejx = "TipStatsGUI_VersionTracker"
local _4TOcrVCRxztCNqtVFEdqCb = ReplicatedStorage:FindFirstChild(_GSXQ5ZdqXBcxZHIKgOWejx)
if _4TOcrVCRxztCNqtVFEdqCb then
    local _owi6aROZ7fbhM3m3zFlrwn = _4TOcrVCRxztCNqtVFEdqCb:GetAttribute("Version") or "0"
    local _5tUu2yeNtxY3cAmkfj0tov = _3rMHE8kad14NLIBNzbblXv(_owi6aROZ7fbhM3m3zFlrwn, _AUa00Zt2x7mrKBkxh3BqJO)
    if _5tUu2yeNtxY3cAmkfj0tov >= 0 then
        print("TipStatsGUI: A newer or equal version (" .. tostring(_owi6aROZ7fbhM3m3zFlrwn) .. ") is already running. Exiting this instance.")
        pcall(function()
            local _Bmajh8GcYvzu3cpgFjLnqK = Players.LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("TipStatsGUI")
            if _Bmajh8GcYvzu3cpgFjLnqK then
                _Bmajh8GcYvzu3cpgFjLnqK:Destroy()
            end
        end)
        return
    else
        _4TOcrVCRxztCNqtVFEdqCb:SetAttribute("Version", _AUa00Zt2x7mrKBkxh3BqJO)
        print("TipStatsGUI: Updated to version " .. tostring(_AUa00Zt2x7mrKBkxh3BqJO))
    end
else
    _4TOcrVCRxztCNqtVFEdqCb = Instance.new("StringValue")
    _4TOcrVCRxztCNqtVFEdqCb.Name = _GSXQ5ZdqXBcxZHIKgOWejx
    _4TOcrVCRxztCNqtVFEdqCb:SetAttribute("Version", _AUa00Zt2x7mrKBkxh3BqJO)
    _4TOcrVCRxztCNqtVFEdqCb.Parent = ReplicatedStorage
    print("TipStatsGUI: Initialized version " .. tostring(_AUa00Zt2x7mrKBkxh3BqJO))
end
local _IwkVsc23fgHnJGQ9AHaXHj = true
local _LIuLWY5kDACbxQb3ywR0IQ = {}
local function _np2lATLn4q5t0F0tS01g0q(_WU87BkEmPu7K64NkJ8cEzd)
    if _WU87BkEmPu7K64NkJ8cEzd then
        table.insert(_LIuLWY5kDACbxQb3ywR0IQ, _WU87BkEmPu7K64NkJ8cEzd)
    end
    return _WU87BkEmPu7K64NkJ8cEzd
end
local function _qQK5dVmd8ClWzzncohAIf9()
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    _IwkVsc23fgHnJGQ9AHaXHj = false
    print("TipStatsGUI: Starting cleanup of old instance...")
    pcall(function()
        for _, _WU87BkEmPu7K64NkJ8cEzd in ipairs(_LIuLWY5kDACbxQb3ywR0IQ) do
            if _WU87BkEmPu7K64NkJ8cEzd and typeof(_WU87BkEmPu7K64NkJ8cEzd) == "RBXScriptConnection" then
                pcall(function()
                    _WU87BkEmPu7K64NkJ8cEzd:Disconnect()
                end)
            end
        end
        _LIuLWY5kDACbxQb3ywR0IQ = {}
    end)
    pcall(function()
        if _sSaHKxTzJmyg56gOIkDZGl then
            _DJOxJdjwghvyTBZDHk3VQ0()
        end
        if _eQ1LgYgAj9WUcCOhzqsiHH then
            _LJMsyyY9wjwFjMRGpDg6Z5()
        end
        if _XgVZSxipJ7tAAN0zy3w1K5 then
            task.cancel(_XgVZSxipJ7tAAN0zy3w1K5)
            _XgVZSxipJ7tAAN0zy3w1K5 = nil
        end
        if _VMLNExLRDyJxCopIvZIRnC then
            _VMLNExLRDyJxCopIvZIRnC:Disconnect()
            _VMLNExLRDyJxCopIvZIRnC = nil
        end
        if _8KA16DhcL1jBITUfqrXNSp then
            _8KA16DhcL1jBITUfqrXNSp:Destroy()
            _8KA16DhcL1jBITUfqrXNSp = nil
        end
        _KyudF1wlqenY1Uo94R3Tmd = nil
        if _re5qfWtmvctI7fWtq65VEu then
            for _LovOfbaPAgtCeey8jCuEVQ, _NXDf15WGHv4zdyTFuuiM2w in pairs(_aTEGfarD9aIdgCBvTozpAX) do
                if _NXDf15WGHv4zdyTFuuiM2w and _NXDf15WGHv4zdyTFuuiM2w.Parent then
                    local _MbuECcuuyZtiyKNdKhF8hg = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChildOfClass("Humanoid")
                    if _MbuECcuuyZtiyKNdKhF8hg then
                        local _Nlc8dt1nHgDFEdBo5ovVYk = _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalWalkSpeed")
                        if _Nlc8dt1nHgDFEdBo5ovVYk ~= nil then
                            _MbuECcuuyZtiyKNdKhF8hg.WalkSpeed = _Nlc8dt1nHgDFEdBo5ovVYk
                            _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalWalkSpeed", nil)
                        end
                        local _yLIpRE7l5nJK7JOnkRUD2W = _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalJumpPower")
                        if _yLIpRE7l5nJK7JOnkRUD2W ~= nil then
                            _MbuECcuuyZtiyKNdKhF8hg.JumpPower = _yLIpRE7l5nJK7JOnkRUD2W
                            _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalJumpPower", nil)
                        end
                    end
                    for _, descendant in ipairs(_NXDf15WGHv4zdyTFuuiM2w:GetDescendants()) do
                        if descendant:IsA("BasePart") then
                            local _aPmeY5XeJZhgqKpnroFxUS = descendant:GetAttribute("OriginalTransparency")
                            if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
                                descendant.Transparency = _aPmeY5XeJZhgqKpnroFxUS
                                descendant:SetAttribute("OriginalTransparency", nil)
                            end
                        end
                    end
                    local _CQzJpPC316GgHbG6I6Rxpz = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChild("HumanoidRootPart")
                    if _CQzJpPC316GgHbG6I6Rxpz then
                        local _aPmeY5XeJZhgqKpnroFxUS = _CQzJpPC316GgHbG6I6Rxpz:GetAttribute("OriginalTransparency")
                        if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
                            _CQzJpPC316GgHbG6I6Rxpz.Transparency = _aPmeY5XeJZhgqKpnroFxUS
                            _CQzJpPC316GgHbG6I6Rxpz:SetAttribute("OriginalTransparency", nil)
                        end
                    end
                end
            end
            _aTEGfarD9aIdgCBvTozpAX = {}
            _re5qfWtmvctI7fWtq65VEu = false
        end
        for _LovOfbaPAgtCeey8jCuEVQ, _ in pairs(_zPD8EKH7czjgXL3tnHh7ox) do
            if _LovOfbaPAgtCeey8jCuEVQ and _LovOfbaPAgtCeey8jCuEVQ.Character then
                local _MbuECcuuyZtiyKNdKhF8hg = _LovOfbaPAgtCeey8jCuEVQ.Character:FindFirstChildOfClass("Humanoid")
                if _MbuECcuuyZtiyKNdKhF8hg then
                    local _Nlc8dt1nHgDFEdBo5ovVYk = _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalWalkSpeed")
                    if _Nlc8dt1nHgDFEdBo5ovVYk ~= nil then
                        _MbuECcuuyZtiyKNdKhF8hg.WalkSpeed = _Nlc8dt1nHgDFEdBo5ovVYk
                        _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalWalkSpeed", nil)
                    end
                    local _yLIpRE7l5nJK7JOnkRUD2W = _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalJumpPower")
                    if _yLIpRE7l5nJK7JOnkRUD2W ~= nil then
                        _MbuECcuuyZtiyKNdKhF8hg.JumpPower = _yLIpRE7l5nJK7JOnkRUD2W
                        _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalJumpPower", nil)
                    end
                end
                for _, descendant in ipairs(_LovOfbaPAgtCeey8jCuEVQ.Character:GetDescendants()) do
                    if descendant:IsA("BasePart") then
                        local _aPmeY5XeJZhgqKpnroFxUS = descendant:GetAttribute("OriginalTransparency")
                        if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
                            descendant.Transparency = _aPmeY5XeJZhgqKpnroFxUS
                            descendant:SetAttribute("OriginalTransparency", nil)
                        end
                    end
                end
                local _CQzJpPC316GgHbG6I6Rxpz = _LovOfbaPAgtCeey8jCuEVQ.Character:FindFirstChild("HumanoidRootPart")
                if _CQzJpPC316GgHbG6I6Rxpz then
                    local _aPmeY5XeJZhgqKpnroFxUS = _CQzJpPC316GgHbG6I6Rxpz:GetAttribute("OriginalTransparency")
                    if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
                        _CQzJpPC316GgHbG6I6Rxpz.Transparency = _aPmeY5XeJZhgqKpnroFxUS
                        _CQzJpPC316GgHbG6I6Rxpz:SetAttribute("OriginalTransparency", nil)
                    end
                end
            end
        end
        _zPD8EKH7czjgXL3tnHh7ox = {}
        local _FRfADhupCtBKhknUN6yqK4 = nil
        pcall(function()
            _FRfADhupCtBKhknUN6yqK4 = game:GetService("CoreGui")
        end)
        if not _FRfADhupCtBKhknUN6yqK4 then
            return
        end
        if _S0syiCt3DB2qEki81fRzIy then
            for _, child in ipairs(_S0syiCt3DB2qEki81fRzIy:GetChildren()) do
                if child:IsA("Frame") and string.sub(child.Name, 1, 11) == "PlayerInfo_" then
                    child:Destroy()
                end
            end
        end
        if _S0syiCt3DB2qEki81fRzIy and _S0syiCt3DB2qEki81fRzIy.Parent then
            pcall(function()
                _S0syiCt3DB2qEki81fRzIy:Destroy()
            end)
            _S0syiCt3DB2qEki81fRzIy = nil
        end
        local _OXZlOaHUUrbZ8E5vSOmYOt = _FRfADhupCtBKhknUN6yqK4:FindFirstChild("TipStatsGUI")
        if _OXZlOaHUUrbZ8E5vSOmYOt then
            local _bUzxn7Jqof6Ynq6JabjKLY = _OXZlOaHUUrbZ8E5vSOmYOt:FindFirstChild("LocationHub")
            if _bUzxn7Jqof6Ynq6JabjKLY then
                _bUzxn7Jqof6Ynq6JabjKLY:Destroy()
            end
            local _7Yivni1NNtGsbnBz6RLzYP = _OXZlOaHUUrbZ8E5vSOmYOt:FindFirstChild("SettingsPanel")
            if _7Yivni1NNtGsbnBz6RLzYP then
                _7Yivni1NNtGsbnBz6RLzYP:Destroy()
            end
            local _OUQZCKJrGsIeQE2SE6Pk5B = _OXZlOaHUUrbZ8E5vSOmYOt:FindFirstChild("HoverInfoBanner")
            if _OUQZCKJrGsIeQE2SE6Pk5B then
                _OUQZCKJrGsIeQE2SE6Pk5B:Destroy()
            end
            for _, child in ipairs(_OXZlOaHUUrbZ8E5vSOmYOt:GetChildren()) do
                if child:IsA("Frame") and string.sub(child.Name, 1, 11) == "PlayerInfo_" then
                    child:Destroy()
                end
            end
            _OXZlOaHUUrbZ8E5vSOmYOt:Destroy()
        end
        local _dTgU51hrQu4AUzEfySPhVB = _FRfADhupCtBKhknUN6yqK4:FindFirstChild("DonationNotificationGui")
        if _dTgU51hrQu4AUzEfySPhVB then
            _dTgU51hrQu4AUzEfySPhVB:Destroy()
        end
        local _oNaWDjOawk1Rr6jyktuOMu = Players.LocalPlayer:FindFirstChild("PlayerGui")
        if _oNaWDjOawk1Rr6jyktuOMu then
            local _BcwpSM3DbwQzFiMXWx3S1K = _oNaWDjOawk1Rr6jyktuOMu:FindFirstChild("TipStatsGUI")
            if _BcwpSM3DbwQzFiMXWx3S1K then
                _BcwpSM3DbwQzFiMXWx3S1K:Destroy()
            end
        end
        for _, descendant in ipairs(Workspace:GetDescendants()) do
            if descendant:IsA("Highlight") and descendant.Name == "TipStatsHoverOutline" then
                descendant:Destroy()
            end
        end
        if _4TOcrVCRxztCNqtVFEdqCb and _4TOcrVCRxztCNqtVFEdqCb:GetAttribute("Version") == _AUa00Zt2x7mrKBkxh3BqJO then
            _4TOcrVCRxztCNqtVFEdqCb:Destroy()
        end
        print("TipStatsGUI: Cleanup completed. Old instance stopped.")
    end)
end
spawn(function()
    while _IwkVsc23fgHnJGQ9AHaXHj do
        task.wait(0.1)
        if not _IwkVsc23fgHnJGQ9AHaXHj then
            return
        end
        if _4TOcrVCRxztCNqtVFEdqCb and _4TOcrVCRxztCNqtVFEdqCb:GetAttribute("Version") then
            local _05tYJiFCSaDWxoAEoNGvFs = _4TOcrVCRxztCNqtVFEdqCb:GetAttribute("Version")
            local _5tUu2yeNtxY3cAmkfj0tov = _3rMHE8kad14NLIBNzbblXv(_05tYJiFCSaDWxoAEoNGvFs, _AUa00Zt2x7mrKBkxh3BqJO)
            if _5tUu2yeNtxY3cAmkfj0tov > 0 then
                print("TipStatsGUI: Detected newer version (" .. tostring(_05tYJiFCSaDWxoAEoNGvFs) .. "). Cleaning up and exiting.")
                _qQK5dVmd8ClWzzncohAIf9()
                return
            end
        else
            if _IwkVsc23fgHnJGQ9AHaXHj then
                _qQK5dVmd8ClWzzncohAIf9()
            end
            return
        end
    end
end)
if _4TOcrVCRxztCNqtVFEdqCb then
    _np2lATLn4q5t0F0tS01g0q(_4TOcrVCRxztCNqtVFEdqCb:GetAttributeChangedSignal("Version"):Connect(function()
        if not _IwkVsc23fgHnJGQ9AHaXHj then
            return
        end
        local _05tYJiFCSaDWxoAEoNGvFs = _4TOcrVCRxztCNqtVFEdqCb:GetAttribute("Version")
        if _05tYJiFCSaDWxoAEoNGvFs then
            local _5tUu2yeNtxY3cAmkfj0tov = _3rMHE8kad14NLIBNzbblXv(_05tYJiFCSaDWxoAEoNGvFs, _AUa00Zt2x7mrKBkxh3BqJO)
            if _5tUu2yeNtxY3cAmkfj0tov > 0 then
                print("TipStatsGUI: Detected newer version (" .. tostring(_05tYJiFCSaDWxoAEoNGvFs) .. ") via attribute change. Cleaning up and exiting.")
                _qQK5dVmd8ClWzzncohAIf9()
            end
        end
    end))
end
local _0Mo4Au6gjlIcWTR8WhXyix = Players.LocalPlayer
while not _0Mo4Au6gjlIcWTR8WhXyix do
    task.wait()
    _0Mo4Au6gjlIcWTR8WhXyix = Players.LocalPlayer
end
local _emQnagvqLpPINr8NKtwuzb = nil
pcall(function()
    if _0Mo4Au6gjlIcWTR8WhXyix then
        _emQnagvqLpPINr8NKtwuzb = _0Mo4Au6gjlIcWTR8WhXyix:GetMouse()
    end
end)
local _LhLCCPupqgkRsRdGijHmSr = 20
local _n2q7wdf7S6jYVoT9cZ0ibc = nil
local _jyBLAbl9jRGHjF0gwVeVjb = nil
local _eZ2wi7xv9nsmIvzevkqE7J = nil
local _kJTiybCj45qiXRjJVMq7Sq = nil
local _sSaHKxTzJmyg56gOIkDZGl = nil
local _eQ1LgYgAj9WUcCOhzqsiHH = nil
local _oZ6VlOgBjrpZhQuQzJ9YVL = nil
local _Yqnxytas55TTNBCAFgEEoL = nil
local _cwlGmo6We58YLZ3ZJnlilP = nil
local _a04gia68W6dqh1It910aEM = nil
local function _V0o4jKDXEzXk82TKCiARBp(_LovOfbaPAgtCeey8jCuEVQ)
    if _LovOfbaPAgtCeey8jCuEVQ and _LovOfbaPAgtCeey8jCuEVQ.Character then
        local _MbuECcuuyZtiyKNdKhF8hg = _LovOfbaPAgtCeey8jCuEVQ.Character:FindFirstChildOfClass('Humanoid')
        if _MbuECcuuyZtiyKNdKhF8hg then
            return _MbuECcuuyZtiyKNdKhF8hg.RigType == Enum.HumanoidRigType.R15
        end
    end
    return false
end
local function _RJjERYng8mXMJfhQnnCyT2(char)
    return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
end
local function _EZ5WJoqVnje30T4c1q5z18(char)
    return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
end
local function _Fzz1Ml7Xmv9ATdihb7jl4s(instance)
    while instance do
        local _LovOfbaPAgtCeey8jCuEVQ = Players:GetPlayerFromCharacter(instance)
        if _LovOfbaPAgtCeey8jCuEVQ then
            return _LovOfbaPAgtCeey8jCuEVQ
        end
        instance = instance.Parent
    end
    return nil
end
local function _tUZ9Tym2vHpshovPSgGjI0(_bnwqb2xyJmweNiyo22vo3w, maxDistance)
    maxDistance = maxDistance or _LhLCCPupqgkRsRdGijHmSr
    if not _0Mo4Au6gjlIcWTR8WhXyix then
        return false
    end
    local _jO1Hy2pA2jBR1wT7oy8aDw = _0Mo4Au6gjlIcWTR8WhXyix.Character
    local _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w and _bnwqb2xyJmweNiyo22vo3w.Character
    if not _jO1Hy2pA2jBR1wT7oy8aDw or not _h9SE505xhMreHmbgzPuJFP then
        return false
    end
    local _lpVrBbjhkyo5gmUAQamLCA = _RJjERYng8mXMJfhQnnCyT2(_jO1Hy2pA2jBR1wT7oy8aDw)
    local _GvKyAr6AdlPTT76gxCatXd = _RJjERYng8mXMJfhQnnCyT2(_h9SE505xhMreHmbgzPuJFP)
    if not _lpVrBbjhkyo5gmUAQamLCA or not _GvKyAr6AdlPTT76gxCatXd then
        return false
    end
    local _DQI0PgZWHCBZi5cfkZjC88 = (_lpVrBbjhkyo5gmUAQamLCA.Position - _GvKyAr6AdlPTT76gxCatXd.Position).Magnitude
    return _DQI0PgZWHCBZi5cfkZjC88 <= maxDistance, _DQI0PgZWHCBZi5cfkZjC88
end
local function _DJOxJdjwghvyTBZDHk3VQ0()
    if _n2q7wdf7S6jYVoT9cZ0ibc then
        _n2q7wdf7S6jYVoT9cZ0ibc:Disconnect()
        _n2q7wdf7S6jYVoT9cZ0ibc = nil
    end
    if _jyBLAbl9jRGHjF0gwVeVjb then
        _jyBLAbl9jRGHjF0gwVeVjb:Disconnect()
        _jyBLAbl9jRGHjF0gwVeVjb = nil
    end
    if _kJTiybCj45qiXRjJVMq7Sq then
        _kJTiybCj45qiXRjJVMq7Sq:Stop()
        _kJTiybCj45qiXRjJVMq7Sq = nil
    end
    if _eZ2wi7xv9nsmIvzevkqE7J then
        _eZ2wi7xv9nsmIvzevkqE7J:Destroy()
        _eZ2wi7xv9nsmIvzevkqE7J = nil
    end
    _sSaHKxTzJmyg56gOIkDZGl = nil
end
local function _OO24suFpUOJOzJZphVtPaD(_bnwqb2xyJmweNiyo22vo3w)
    if not _bnwqb2xyJmweNiyo22vo3w or not _bnwqb2xyJmweNiyo22vo3w.Parent then
        return
    end
    local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
    if not _KCbu2Au1vAJIFqOuBflYpF then
        return
    end
    if _sSaHKxTzJmyg56gOIkDZGl == _bnwqb2xyJmweNiyo22vo3w then
        _DJOxJdjwghvyTBZDHk3VQ0()
        return
    end
    _DJOxJdjwghvyTBZDHk3VQ0()
    _sSaHKxTzJmyg56gOIkDZGl = _bnwqb2xyJmweNiyo22vo3w
    spawn(function()
        local _jO1Hy2pA2jBR1wT7oy8aDw = _KCbu2Au1vAJIFqOuBflYpF.Character
        if not _jO1Hy2pA2jBR1wT7oy8aDw then
            _jO1Hy2pA2jBR1wT7oy8aDw = _KCbu2Au1vAJIFqOuBflYpF.CharacterAdded:Wait(5)
        end
        if not _jO1Hy2pA2jBR1wT7oy8aDw or not _jO1Hy2pA2jBR1wT7oy8aDw.Parent then
            return
        end
        local _MbuECcuuyZtiyKNdKhF8hg = _jO1Hy2pA2jBR1wT7oy8aDw:FindFirstChildWhichIsA("Humanoid")
        if not _MbuECcuuyZtiyKNdKhF8hg then
            return
        end
        local _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.Character
        if not _h9SE505xhMreHmbgzPuJFP then
            _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.CharacterAdded:Wait(5)
        end
        if not _h9SE505xhMreHmbgzPuJFP or not _h9SE505xhMreHmbgzPuJFP.Parent then
            return
        end
        _eZ2wi7xv9nsmIvzevkqE7J = Instance.new("Animation")
        _eZ2wi7xv9nsmIvzevkqE7J.AnimationId = not _V0o4jKDXEzXk82TKCiARBp(_KCbu2Au1vAJIFqOuBflYpF) and "rbxassetid://148840371" or "rbxassetid://5918726674"
        _kJTiybCj45qiXRjJVMq7Sq = _MbuECcuuyZtiyKNdKhF8hg:LoadAnimation(_eZ2wi7xv9nsmIvzevkqE7J)
        _kJTiybCj45qiXRjJVMq7Sq:Play(0.1, 1, 1)
        _kJTiybCj45qiXRjJVMq7Sq:AdjustSpeed(3)
        _jyBLAbl9jRGHjF0gwVeVjb = _MbuECcuuyZtiyKNdKhF8hg.Died:Connect(function()
            _DJOxJdjwghvyTBZDHk3VQ0()
        end)
        if _bnwqb2xyJmweNiyo22vo3w.CharacterRemoving then
            _bnwqb2xyJmweNiyo22vo3w.CharacterRemoving:Connect(function()
                if _sSaHKxTzJmyg56gOIkDZGl == _bnwqb2xyJmweNiyo22vo3w then
                    _DJOxJdjwghvyTBZDHk3VQ0()
                end
            end)
        end
        local _EUWKIfvrIuZYEw9JYtS2Iw = CFrame.new(0, 0, 1.1)
        _n2q7wdf7S6jYVoT9cZ0ibc = RunService.RenderStepped:Connect(function()
            pcall(function()
                local _SlvegD2BDY9CUTKnBoRWp0 = _EZ5WJoqVnje30T4c1q5z18(_h9SE505xhMreHmbgzPuJFP)
                local _lpVrBbjhkyo5gmUAQamLCA = _RJjERYng8mXMJfhQnnCyT2(_jO1Hy2pA2jBR1wT7oy8aDw)
                if _SlvegD2BDY9CUTKnBoRWp0 and _lpVrBbjhkyo5gmUAQamLCA and _SlvegD2BDY9CUTKnBoRWp0.Parent and _lpVrBbjhkyo5gmUAQamLCA.Parent then
                    _lpVrBbjhkyo5gmUAQamLCA.CFrame = _SlvegD2BDY9CUTKnBoRWp0.CFrame * _EUWKIfvrIuZYEw9JYtS2Iw
                end
            end)
        end)
    end)
end
local function _LJMsyyY9wjwFjMRGpDg6Z5()
    if _eQ1LgYgAj9WUcCOhzqsiHH ~= nil then
        _eQ1LgYgAj9WUcCOhzqsiHH = nil
    end
    if _oZ6VlOgBjrpZhQuQzJ9YVL then
        _oZ6VlOgBjrpZhQuQzJ9YVL:Disconnect()
        _oZ6VlOgBjrpZhQuQzJ9YVL = nil
    end
    if _Yqnxytas55TTNBCAFgEEoL then
        _Yqnxytas55TTNBCAFgEEoL:Disconnect()
        _Yqnxytas55TTNBCAFgEEoL = nil
    end
    local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
    if _KCbu2Au1vAJIFqOuBflYpF and _KCbu2Au1vAJIFqOuBflYpF.Character then
        Workspace.CurrentCamera.CameraSubject = _KCbu2Au1vAJIFqOuBflYpF.Character:FindFirstChildOfClass("Humanoid")
    end
end
local function _eGxgzKkp40UbLcsdyoLlmE(_bnwqb2xyJmweNiyo22vo3w)
    if not _bnwqb2xyJmweNiyo22vo3w or not _bnwqb2xyJmweNiyo22vo3w.Parent then
        return
    end
    local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
    if not _KCbu2Au1vAJIFqOuBflYpF then
        return
    end
    if _eQ1LgYgAj9WUcCOhzqsiHH == _bnwqb2xyJmweNiyo22vo3w then
        _LJMsyyY9wjwFjMRGpDg6Z5()
        return
    end
    _LJMsyyY9wjwFjMRGpDg6Z5()
    _eQ1LgYgAj9WUcCOhzqsiHH = _bnwqb2xyJmweNiyo22vo3w
    spawn(function()
        local _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.Character
        if not _h9SE505xhMreHmbgzPuJFP then
            _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.CharacterAdded:Wait(5)
        end
        if not _h9SE505xhMreHmbgzPuJFP or not _h9SE505xhMreHmbgzPuJFP.Parent then
            _LJMsyyY9wjwFjMRGpDg6Z5()
            return
        end
        Workspace.CurrentCamera.CameraSubject = _h9SE505xhMreHmbgzPuJFP:FindFirstChildOfClass("Humanoid")
        local function _bi1cXC4DenwZmgjIJHByu7()
            if _eQ1LgYgAj9WUcCOhzqsiHH == _bnwqb2xyJmweNiyo22vo3w then
                repeat 
                    task.wait() 
                until _bnwqb2xyJmweNiyo22vo3w.Character ~= nil and _RJjERYng8mXMJfhQnnCyT2(_bnwqb2xyJmweNiyo22vo3w.Character)
                if _eQ1LgYgAj9WUcCOhzqsiHH == _bnwqb2xyJmweNiyo22vo3w then
                    Workspace.CurrentCamera.CameraSubject = _bnwqb2xyJmweNiyo22vo3w.Character:FindFirstChildOfClass("Humanoid")
                end
            end
        end
        _oZ6VlOgBjrpZhQuQzJ9YVL = _bnwqb2xyJmweNiyo22vo3w.CharacterAdded:Connect(viewDiedFunc)
        local function _FCEZcDflAQTNZdzOb3Nb9r()
            if _eQ1LgYgAj9WUcCOhzqsiHH == _bnwqb2xyJmweNiyo22vo3w and _bnwqb2xyJmweNiyo22vo3w.Character then
                Workspace.CurrentCamera.CameraSubject = _bnwqb2xyJmweNiyo22vo3w.Character:FindFirstChildOfClass("Humanoid")
            end
        end
        _Yqnxytas55TTNBCAFgEEoL = Workspace.CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(viewChangedFunc)
        _bnwqb2xyJmweNiyo22vo3w.AncestryChanged:Connect(function()
            if not _bnwqb2xyJmweNiyo22vo3w.Parent then
                if _eQ1LgYgAj9WUcCOhzqsiHH == _bnwqb2xyJmweNiyo22vo3w then
                    _LJMsyyY9wjwFjMRGpDg6Z5()
                end
            end
        end)
    end)
end
local _wDuB0A8HgYbTwUR6C2Wb9Z = {}
local _QpQcjxL2OamZbsRzGPlmS3 = {}
local _vu1vB0pYm7D41aoo4L1oY2 = {}
local _CVlWc88T197DiiDHQ8wNou = nil
local function _wLtE0qjNgk1WbcLcXu7ZQ2(title, message, notificationType, actionButton, actionCallback)
    notificationType = notificationType or "info"
    if not _S0syiCt3DB2qEki81fRzIy or not _S0syiCt3DB2qEki81fRzIy.Parent then
        return
    end
    if not _CVlWc88T197DiiDHQ8wNou then
        _CVlWc88T197DiiDHQ8wNou = Instance.new("Frame")
        _CVlWc88T197DiiDHQ8wNou.Name = "NotificationContainer"
        _CVlWc88T197DiiDHQ8wNou.Size = UDim2.new(0, 400, 0, 300)
        _CVlWc88T197DiiDHQ8wNou.Position = UDim2.new(0.5, -200, 0, 10)
        _CVlWc88T197DiiDHQ8wNou.AnchorPoint = Vector2.new(0.5, 0)
        _CVlWc88T197DiiDHQ8wNou.BackgroundTransparency = 1
        _CVlWc88T197DiiDHQ8wNou.Parent = _S0syiCt3DB2qEki81fRzIy
        local _bgki3hXThvMBL4vXPGwnyf = Instance.new("UIListLayout")
        _bgki3hXThvMBL4vXPGwnyf.SortOrder = Enum.SortOrder.LayoutOrder
        _bgki3hXThvMBL4vXPGwnyf.Padding = UDim.new(0, 10)
        _bgki3hXThvMBL4vXPGwnyf.HorizontalAlignment = Enum.HorizontalAlignment.Center
        _bgki3hXThvMBL4vXPGwnyf.VerticalAlignment = Enum.VerticalAlignment.Top
        _bgki3hXThvMBL4vXPGwnyf.Parent = _CVlWc88T197DiiDHQ8wNou
        local _BmCnhkPlJxhZhPrjv7XoG2 = Instance.new("UIPadding")
        _BmCnhkPlJxhZhPrjv7XoG2.PaddingTop = UDim.new(0, 10)
        _BmCnhkPlJxhZhPrjv7XoG2.Parent = _CVlWc88T197DiiDHQ8wNou
    end
    local borderColor, bgColor
    if notificationType == "success" then
        borderColor = Color3.fromRGB(100, 200, 100)
        bgColor = Color3.fromRGB(40, 60, 40)
    elseif notificationType == "warning" then
        borderColor = Color3.fromRGB(255, 180, 50)
        bgColor = Color3.fromRGB(60, 50, 30)
    else
        borderColor = Color3.fromRGB(100, 150, 255)
        bgColor = Color3.fromRGB(40, 40, 60)
    end
    local _K9WEWbqrFvZa4u3VZGQJbV = Instance.new("Frame")
    _K9WEWbqrFvZa4u3VZGQJbV.Name = "Notification_" .. tick()
    _K9WEWbqrFvZa4u3VZGQJbV.Size = UDim2.new(0, 380, 0, 100)
    _K9WEWbqrFvZa4u3VZGQJbV.BackgroundColor3 = bgColor
    _K9WEWbqrFvZa4u3VZGQJbV.BorderSizePixel = 0
    _K9WEWbqrFvZa4u3VZGQJbV.Parent = _CVlWc88T197DiiDHQ8wNou
    _K9WEWbqrFvZa4u3VZGQJbV.LayoutOrder = #_wDuB0A8HgYbTwUR6C2Wb9Z + 1
    local _xMTXpbeTMlXoxUsCDccRY5 = Instance.new("UICorner")
    _xMTXpbeTMlXoxUsCDccRY5.CornerRadius = UDim.new(0, 10)
    _xMTXpbeTMlXoxUsCDccRY5.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _4HeKKfYunLBZuH1bLgJ3mN = Instance.new("UIStroke")
    _4HeKKfYunLBZuH1bLgJ3mN.Color = borderColor
    _4HeKKfYunLBZuH1bLgJ3mN.Thickness = 3
    _4HeKKfYunLBZuH1bLgJ3mN.Transparency = 0
    _4HeKKfYunLBZuH1bLgJ3mN.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _StiiAL438TmW52DvkA5x8X = Instance.new("TextLabel")
    _StiiAL438TmW52DvkA5x8X.Name = "TitleLabel"
    _StiiAL438TmW52DvkA5x8X.Size = UDim2.new(1, actionButton and -100 or -40, 0, 30)
    _StiiAL438TmW52DvkA5x8X.Position = UDim2.new(0, 15, 0, 10)
    _StiiAL438TmW52DvkA5x8X.BackgroundTransparency = 1
    _StiiAL438TmW52DvkA5x8X.Text = title
    _StiiAL438TmW52DvkA5x8X.TextColor3 = Color3.fromRGB(255, 255, 255)
    _StiiAL438TmW52DvkA5x8X.TextSize = 16
    _StiiAL438TmW52DvkA5x8X.Font = Enum.Font.GothamBold
    _StiiAL438TmW52DvkA5x8X.TextXAlignment = Enum.TextXAlignment.Left
    _StiiAL438TmW52DvkA5x8X.TextTruncate = Enum.TextTruncate.AtEnd
    _StiiAL438TmW52DvkA5x8X.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _iw6oC7WT47BU4FUV0t7pBf = Instance.new("TextLabel")
    _iw6oC7WT47BU4FUV0t7pBf.Name = "MessageLabel"
    _iw6oC7WT47BU4FUV0t7pBf.Size = UDim2.new(1, actionButton and -100 or -40, 0, 40)
    _iw6oC7WT47BU4FUV0t7pBf.Position = UDim2.new(0, 15, 0, 40)
    _iw6oC7WT47BU4FUV0t7pBf.BackgroundTransparency = 1
    _iw6oC7WT47BU4FUV0t7pBf.Text = message
    _iw6oC7WT47BU4FUV0t7pBf.TextColor3 = Color3.fromRGB(220, 220, 220)
    _iw6oC7WT47BU4FUV0t7pBf.TextSize = 13
    _iw6oC7WT47BU4FUV0t7pBf.Font = Enum.Font.Gotham
    _iw6oC7WT47BU4FUV0t7pBf.TextXAlignment = Enum.TextXAlignment.Left
    _iw6oC7WT47BU4FUV0t7pBf.TextWrapped = true
    _iw6oC7WT47BU4FUV0t7pBf.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    if actionButton and actionCallback then
        local _6pA29lILPGaMvUrFaRuBqE = Instance.new("TextButton")
        _6pA29lILPGaMvUrFaRuBqE.Name = "ActionButton"
        _6pA29lILPGaMvUrFaRuBqE.Size = UDim2.new(0, 90, 0, 35)
        _6pA29lILPGaMvUrFaRuBqE.Position = UDim2.new(1, -100, 0.5, -17.5)
        _6pA29lILPGaMvUrFaRuBqE.AnchorPoint = Vector2.new(0, 0.5)
        _6pA29lILPGaMvUrFaRuBqE.BackgroundColor3 = borderColor
        _6pA29lILPGaMvUrFaRuBqE.Text = actionButton
        _6pA29lILPGaMvUrFaRuBqE.TextColor3 = Color3.fromRGB(255, 255, 255)
        _6pA29lILPGaMvUrFaRuBqE.TextSize = 12
        _6pA29lILPGaMvUrFaRuBqE.Font = Enum.Font.GothamBold
        _6pA29lILPGaMvUrFaRuBqE.BorderSizePixel = 0
        _6pA29lILPGaMvUrFaRuBqE.Parent = _K9WEWbqrFvZa4u3VZGQJbV
        local _g5qv3WnISaZaPTxiklQtz6 = Instance.new("UICorner")
        _g5qv3WnISaZaPTxiklQtz6.CornerRadius = UDim.new(0, 6)
        _g5qv3WnISaZaPTxiklQtz6.Parent = _6pA29lILPGaMvUrFaRuBqE
        _6pA29lILPGaMvUrFaRuBqE.MouseEnter:Connect(function()
            _6pA29lILPGaMvUrFaRuBqE.BackgroundColor3 = Color3.fromRGB(
                math.min(255, borderColor.R * 255 * 1.2),
                math.min(255, borderColor.G * 255 * 1.2),
                math.min(255, borderColor.B * 255 * 1.2)
            )
        end)
        _6pA29lILPGaMvUrFaRuBqE.MouseLeave:Connect(function()
            _6pA29lILPGaMvUrFaRuBqE.BackgroundColor3 = borderColor
        end)
        _6pA29lILPGaMvUrFaRuBqE.MouseButton1Click:Connect(actionCallback)
    end
    local _G4SfCYLf9wy64ThKKWAeRg = Instance.new("TextButton")
    _G4SfCYLf9wy64ThKKWAeRg.Name = "CloseButton"
    _G4SfCYLf9wy64ThKKWAeRg.Size = UDim2.new(0, 25, 0, 25)
    _G4SfCYLf9wy64ThKKWAeRg.Position = UDim2.new(1, -30, 0, 8)
    _G4SfCYLf9wy64ThKKWAeRg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _G4SfCYLf9wy64ThKKWAeRg.Text = "×"
    _G4SfCYLf9wy64ThKKWAeRg.TextColor3 = Color3.fromRGB(200, 200, 200)
    _G4SfCYLf9wy64ThKKWAeRg.TextSize = 18
    _G4SfCYLf9wy64ThKKWAeRg.Font = Enum.Font.GothamBold
    _G4SfCYLf9wy64ThKKWAeRg.BorderSizePixel = 0
    _G4SfCYLf9wy64ThKKWAeRg.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _2TJk7c5RkudmpG0SS2MUnP = Instance.new("UICorner")
    _2TJk7c5RkudmpG0SS2MUnP.CornerRadius = UDim.new(0, 4)
    _2TJk7c5RkudmpG0SS2MUnP.Parent = _G4SfCYLf9wy64ThKKWAeRg
    _G4SfCYLf9wy64ThKKWAeRg.MouseEnter:Connect(function()
        _G4SfCYLf9wy64ThKKWAeRg.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    _G4SfCYLf9wy64ThKKWAeRg.MouseLeave:Connect(function()
        _G4SfCYLf9wy64ThKKWAeRg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    local function _X6JAE6qyoGym2OYqp4puJ6()
        local _OMhPSzjQx1S2yTsRYebuuD = TweenService:Create(
            _K9WEWbqrFvZa4u3VZGQJbV,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)}
        )
        _OMhPSzjQx1S2yTsRYebuuD:Play()
        _OMhPSzjQx1S2yTsRYebuuD.Completed:Connect(function()
            _K9WEWbqrFvZa4u3VZGQJbV:Destroy()
            for i, notif in ipairs(_wDuB0A8HgYbTwUR6C2Wb9Z) do
                if notif == _K9WEWbqrFvZa4u3VZGQJbV then
                    table.remove(_wDuB0A8HgYbTwUR6C2Wb9Z, i)
                    break
                end
            end
        end)
    end
    _G4SfCYLf9wy64ThKKWAeRg.MouseButton1Click:Connect(closeNotification)
    _K9WEWbqrFvZa4u3VZGQJbV.Size = UDim2.new(0, 0, 0, 0)
    _K9WEWbqrFvZa4u3VZGQJbV.BackgroundTransparency = 1
    local _gtamrxV1brx7OaCB7UGWEa = TweenService:Create(
        _K9WEWbqrFvZa4u3VZGQJbV,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 380, 0, 100), BackgroundTransparency = 0}
    )
    _gtamrxV1brx7OaCB7UGWEa:Play()
    local _Gh9eHKWg4zWs1gPxVBfL8w = notificationType == "warning" and 5 or 8
    task.delay(_Gh9eHKWg4zWs1gPxVBfL8w, function()
        if _K9WEWbqrFvZa4u3VZGQJbV and _K9WEWbqrFvZa4u3VZGQJbV.Parent then
            _X6JAE6qyoGym2OYqp4puJ6()
        end
    end)
    table.insert(_wDuB0A8HgYbTwUR6C2Wb9Z, _K9WEWbqrFvZa4u3VZGQJbV)
    return _K9WEWbqrFvZa4u3VZGQJbV
end
local function _3JjyOPEoPFQCtpNbjitZzb(_bnwqb2xyJmweNiyo22vo3w)
    local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
    if not _KCbu2Au1vAJIFqOuBflYpF or not _KCbu2Au1vAJIFqOuBflYpF.Character then
        return
    end
    local _lpVrBbjhkyo5gmUAQamLCA = _RJjERYng8mXMJfhQnnCyT2(_KCbu2Au1vAJIFqOuBflYpF.Character)
    if not _lpVrBbjhkyo5gmUAQamLCA then
        return
    end
    spawn(function()
        local _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.Character
        if not _h9SE505xhMreHmbgzPuJFP then
            _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.CharacterAdded:Wait(5)
        end
        if _h9SE505xhMreHmbgzPuJFP then
            local _GvKyAr6AdlPTT76gxCatXd = _RJjERYng8mXMJfhQnnCyT2(_h9SE505xhMreHmbgzPuJFP)
            if _GvKyAr6AdlPTT76gxCatXd then
                _lpVrBbjhkyo5gmUAQamLCA.CFrame = _GvKyAr6AdlPTT76gxCatXd.CFrame * CFrame.new(0, 0, 2)
            end
        end
    end)
end
local function _vvAnffFGn4TBh8YqkZRbQl(_LovOfbaPAgtCeey8jCuEVQ, amount)
    _wLtE0qjNgk1WbcLcXu7ZQ2(
        _LovOfbaPAgtCeey8jCuEVQ.DisplayName .. " (" .. _LovOfbaPAgtCeey8jCuEVQ.Name .. ")",
        "Donated " .. amount .. " Robux!",
        "success",
        "Teleport",
        function()
            _3JjyOPEoPFQCtpNbjitZzb(_LovOfbaPAgtCeey8jCuEVQ)
        end
    )
end
local function _PVvcXElE4ZYOaVLeDk9KLG()
    local function _06y850tYZrxL9G8RzrNBkp(_LovOfbaPAgtCeey8jCuEVQ)
        if _BV86plIPCkSAtGcR2pWgc0 then
            _BV86plIPCkSAtGcR2pWgc0(_LovOfbaPAgtCeey8jCuEVQ)
        end
        spawn(function()
            local _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("TipJarStats")
            if not _Ae7vISWaNHvb31mAIQfuJr then
                _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:WaitForChild("TipJarStats", 10)
            end
            if _Ae7vISWaNHvb31mAIQfuJr then
                local _Y96vYR5taFZldy3s5TlM2U = _Ae7vISWaNHvb31mAIQfuJr.Raised
                if not _Y96vYR5taFZldy3s5TlM2U then
                    _Y96vYR5taFZldy3s5TlM2U = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Raised")
                end
                if _Y96vYR5taFZldy3s5TlM2U and (_Y96vYR5taFZldy3s5TlM2U:IsA("IntValue") or _Y96vYR5taFZldy3s5TlM2U:IsA("NumberValue")) then
                    _vu1vB0pYm7D41aoo4L1oY2[_LovOfbaPAgtCeey8jCuEVQ.UserId] = _Y96vYR5taFZldy3s5TlM2U.Value
                    _Y96vYR5taFZldy3s5TlM2U:GetPropertyChangedSignal("Value"):Connect(function()
                        local _VfZ3fVpHr2SzayZG4W21y2 = _Y96vYR5taFZldy3s5TlM2U.Value
                        local _4sed7g9hOV2foWja8RWpmP = _vu1vB0pYm7D41aoo4L1oY2[_LovOfbaPAgtCeey8jCuEVQ.UserId] or _VfZ3fVpHr2SzayZG4W21y2
                        if _VfZ3fVpHr2SzayZG4W21y2 > _4sed7g9hOV2foWja8RWpmP then
                            local _lWwPuepbXyw6fDmqIEP0Wn = _VfZ3fVpHr2SzayZG4W21y2 - _4sed7g9hOV2foWja8RWpmP
                            if _lWwPuepbXyw6fDmqIEP0Wn > 0 then
                                print("Donation detected! Receiver:", _LovOfbaPAgtCeey8jCuEVQ.Name, "Increase:", _lWwPuepbXyw6fDmqIEP0Wn)
                                local _Bhm60BZCLtDpz3xZHqWUM6 = nil
                                for _, donator in ipairs(Players:GetPlayers()) do
                                    if donator ~= _LovOfbaPAgtCeey8jCuEVQ then
                                        local _zAJOfa1v2hqZrGrPiGZQSB = donator:FindFirstChild("TipJarStats")
                                        if _zAJOfa1v2hqZrGrPiGZQSB then
                                            local _YDP5q8fyqqYAbGIHuyskv9 = _zAJOfa1v2hqZrGrPiGZQSB.Donated
                                            if not _YDP5q8fyqqYAbGIHuyskv9 then
                                                _YDP5q8fyqqYAbGIHuyskv9 = _zAJOfa1v2hqZrGrPiGZQSB:FindFirstChild("Donated")
                                            end
                                            if _YDP5q8fyqqYAbGIHuyskv9 and (_YDP5q8fyqqYAbGIHuyskv9:IsA("IntValue") or _YDP5q8fyqqYAbGIHuyskv9:IsA("NumberValue")) then
                                                local _L9kpk22xWhxmpALj7wYdC6 = _YDP5q8fyqqYAbGIHuyskv9.Value
                                                local _OMw2TeHRbFRS3Ffk2tMmQ1 = _QpQcjxL2OamZbsRzGPlmS3[donator.UserId] or _L9kpk22xWhxmpALj7wYdC6
                                                if _L9kpk22xWhxmpALj7wYdC6 > _OMw2TeHRbFRS3Ffk2tMmQ1 then
                                                    local _UVItotZiIC3jWf7we37b6l = _L9kpk22xWhxmpALj7wYdC6 - _OMw2TeHRbFRS3Ffk2tMmQ1
                                                    if math.abs(_UVItotZiIC3jWf7we37b6l - _lWwPuepbXyw6fDmqIEP0Wn) <= 1 then
                                                        _Bhm60BZCLtDpz3xZHqWUM6 = donator
                                                        _QpQcjxL2OamZbsRzGPlmS3[donator.UserId] = _L9kpk22xWhxmpALj7wYdC6
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                if _Bhm60BZCLtDpz3xZHqWUM6 then
                                    print("Found donator:", _Bhm60BZCLtDpz3xZHqWUM6.Name)
                                    _k0bfh0VWn8H2kdL27vVjtX(_Bhm60BZCLtDpz3xZHqWUM6.DisplayName or _Bhm60BZCLtDpz3xZHqWUM6.Name, tostring(_lWwPuepbXyw6fDmqIEP0Wn), _LovOfbaPAgtCeey8jCuEVQ.DisplayName or _LovOfbaPAgtCeey8jCuEVQ.Name)
                                else
                                    print("Donator not found, showing 'Someone'")
                                    _k0bfh0VWn8H2kdL27vVjtX("Someone", tostring(_lWwPuepbXyw6fDmqIEP0Wn), _LovOfbaPAgtCeey8jCuEVQ.DisplayName or _LovOfbaPAgtCeey8jCuEVQ.Name)
                                end
                                _vu1vB0pYm7D41aoo4L1oY2[_LovOfbaPAgtCeey8jCuEVQ.UserId] = _VfZ3fVpHr2SzayZG4W21y2
                            end
                        elseif _VfZ3fVpHr2SzayZG4W21y2 ~= _4sed7g9hOV2foWja8RWpmP then
                            _vu1vB0pYm7D41aoo4L1oY2[_LovOfbaPAgtCeey8jCuEVQ.UserId] = _VfZ3fVpHr2SzayZG4W21y2
                        end
                    end)
                end
                local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
                if not _ZKi3dfVVGlvV4TM9u0f6bf then
                    _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
                end
                if _ZKi3dfVVGlvV4TM9u0f6bf and (_ZKi3dfVVGlvV4TM9u0f6bf:IsA("IntValue") or _ZKi3dfVVGlvV4TM9u0f6bf:IsA("NumberValue")) then
                    _QpQcjxL2OamZbsRzGPlmS3[_LovOfbaPAgtCeey8jCuEVQ.UserId] = _ZKi3dfVVGlvV4TM9u0f6bf.Value
                    _ZKi3dfVVGlvV4TM9u0f6bf:GetPropertyChangedSignal("Value"):Connect(function()
                        _QpQcjxL2OamZbsRzGPlmS3[_LovOfbaPAgtCeey8jCuEVQ.UserId] = _ZKi3dfVVGlvV4TM9u0f6bf.Value
                    end)
                end
            end
        end)
    end
    for _, _LovOfbaPAgtCeey8jCuEVQ in ipairs(Players:GetPlayers()) do
        _06y850tYZrxL9G8RzrNBkp(_LovOfbaPAgtCeey8jCuEVQ)
    end
    Players.PlayerAdded:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
        _06y850tYZrxL9G8RzrNBkp(_LovOfbaPAgtCeey8jCuEVQ)
    end)
    Players.PlayerRemoving:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
        _QpQcjxL2OamZbsRzGPlmS3[_LovOfbaPAgtCeey8jCuEVQ.UserId] = nil
        _vu1vB0pYm7D41aoo4L1oY2[_LovOfbaPAgtCeey8jCuEVQ.UserId] = nil
    end)
end
local _FRfADhupCtBKhknUN6yqK4 = nil
pcall(function()
    _FRfADhupCtBKhknUN6yqK4 = game:GetService("CoreGui")
end)
if not _FRfADhupCtBKhknUN6yqK4 then
    warn("TipStatsGUI: CoreGui service not available")
    return
end
local _Bmajh8GcYvzu3cpgFjLnqK = _FRfADhupCtBKhknUN6yqK4:FindFirstChild("TipStatsGUI")
if _Bmajh8GcYvzu3cpgFjLnqK then
    pcall(function()
        _Bmajh8GcYvzu3cpgFjLnqK:Destroy()
    end)
    task.wait(0.1)
end
local _S0syiCt3DB2qEki81fRzIy = Instance.new("ScreenGui")
_S0syiCt3DB2qEki81fRzIy.Name = "TipStatsGUI"
_S0syiCt3DB2qEki81fRzIy.ResetOnSpawn = false
_S0syiCt3DB2qEki81fRzIy.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    _S0syiCt3DB2qEki81fRzIy.Parent = _FRfADhupCtBKhknUN6yqK4
end)
local _5vzTy4daSqNr8qalAXBZAk = UDim2.new(0, 500, 0, 600)
local _c0cYO8uIBF1EnoGYrNyIOQ = UDim2.new(0, 500, 0, 45)
local _sg3OAQ4e8v2XYKYhGZ6XjV = false
local _zTeqPiwjdJh5tq8nBTQY68 = false
local _LP6d70swKkUntJEjvGWJTW = UDim2.new(1, -20, 0, 80)
local _xmVJGdBcbIclOrYzVq8q5t = Instance.new("Frame")
_xmVJGdBcbIclOrYzVq8q5t.Name = "MainFrame"
_xmVJGdBcbIclOrYzVq8q5t.Size = _5vzTy4daSqNr8qalAXBZAk
_xmVJGdBcbIclOrYzVq8q5t.Position = UDim2.new(0.5, -250, 0.5, -300)
_xmVJGdBcbIclOrYzVq8q5t.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_xmVJGdBcbIclOrYzVq8q5t.BorderSizePixel = 0
_xmVJGdBcbIclOrYzVq8q5t.Parent = _S0syiCt3DB2qEki81fRzIy
local _fFz99nolqcH67YT1VjuCOQ = Instance.new("UICorner")
_fFz99nolqcH67YT1VjuCOQ.CornerRadius = UDim.new(0, 10)
_fFz99nolqcH67YT1VjuCOQ.Parent = _xmVJGdBcbIclOrYzVq8q5t
local _BIdUdme5LZNHLsCGaVk6Ed = Instance.new("UIStroke")
_BIdUdme5LZNHLsCGaVk6Ed.Color = Color3.fromRGB(50, 50, 50)
_BIdUdme5LZNHLsCGaVk6Ed.Thickness = 1
_BIdUdme5LZNHLsCGaVk6Ed.Transparency = 0.2
_BIdUdme5LZNHLsCGaVk6Ed.Parent = _xmVJGdBcbIclOrYzVq8q5t
local _fKMemYRdzhQUqvhuQd0XnY = Instance.new("Frame")
_fKMemYRdzhQUqvhuQd0XnY.Name = "TitleBar"
_fKMemYRdzhQUqvhuQd0XnY.Size = UDim2.new(1, 0, 0, 45)
_fKMemYRdzhQUqvhuQd0XnY.Position = UDim2.new(0, 0, 0, 0)
_fKMemYRdzhQUqvhuQd0XnY.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_fKMemYRdzhQUqvhuQd0XnY.BorderSizePixel = 0
_fKMemYRdzhQUqvhuQd0XnY.Parent = _xmVJGdBcbIclOrYzVq8q5t
local _ch3GW2XyYRA88YZQWk8b6X = Instance.new("UICorner")
_ch3GW2XyYRA88YZQWk8b6X.CornerRadius = UDim.new(0, 10)
_ch3GW2XyYRA88YZQWk8b6X.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _Kd7LJFPbCu406Nu7YWKlYT = Instance.new("UIStroke")
_Kd7LJFPbCu406Nu7YWKlYT.Color = Color3.fromRGB(60, 60, 60)
_Kd7LJFPbCu406Nu7YWKlYT.Thickness = 1
_Kd7LJFPbCu406Nu7YWKlYT.Transparency = 0.3
_Kd7LJFPbCu406Nu7YWKlYT.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _PdF3Vsz8dCVVg03G02GHKq = nil
local _oQxfjUz3ifO9F8w1wD8N8E = nil
local function _6WYb50N1bgR10lWPddxsjK(text)
    if _PdF3Vsz8dCVVg03G02GHKq then
        _PdF3Vsz8dCVVg03G02GHKq:Destroy()
    end
    _PdF3Vsz8dCVVg03G02GHKq = Instance.new("Frame")
    _PdF3Vsz8dCVVg03G02GHKq.Name = "Tooltip"
    _PdF3Vsz8dCVVg03G02GHKq.Size = UDim2.new(0, 0, 0, 0)
    _PdF3Vsz8dCVVg03G02GHKq.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    _PdF3Vsz8dCVVg03G02GHKq.BorderSizePixel = 0
    _PdF3Vsz8dCVVg03G02GHKq.ZIndex = 100
    _PdF3Vsz8dCVVg03G02GHKq.Parent = _S0syiCt3DB2qEki81fRzIy
    local _sxjfpkU3rwdjW9RorJSASi = Instance.new("UICorner")
    _sxjfpkU3rwdjW9RorJSASi.CornerRadius = UDim.new(0, 6)
    _sxjfpkU3rwdjW9RorJSASi.Parent = _PdF3Vsz8dCVVg03G02GHKq
    local _FxeYIIN2RbbgTBqPbATrc0 = Instance.new("UIStroke")
    _FxeYIIN2RbbgTBqPbATrc0.Color = Color3.fromRGB(60, 60, 60)
    _FxeYIIN2RbbgTBqPbATrc0.Thickness = 1
    _FxeYIIN2RbbgTBqPbATrc0.Parent = _PdF3Vsz8dCVVg03G02GHKq
    local _K2OP6i9VLMVhVKKOyH1v7e = Instance.new("TextLabel")
    _K2OP6i9VLMVhVKKOyH1v7e.Name = "TooltipText"
    _K2OP6i9VLMVhVKKOyH1v7e.Size = UDim2.new(1, -12, 1, -8)
    _K2OP6i9VLMVhVKKOyH1v7e.Position = UDim2.new(0, 6, 0, 4)
    _K2OP6i9VLMVhVKKOyH1v7e.BackgroundTransparency = 1
    _K2OP6i9VLMVhVKKOyH1v7e.Text = text
    _K2OP6i9VLMVhVKKOyH1v7e.TextColor3 = Color3.fromRGB(240, 240, 240)
    _K2OP6i9VLMVhVKKOyH1v7e.TextSize = 12
    _K2OP6i9VLMVhVKKOyH1v7e.Font = Enum.Font.Gotham
    _K2OP6i9VLMVhVKKOyH1v7e.TextXAlignment = Enum.TextXAlignment.Left
    _K2OP6i9VLMVhVKKOyH1v7e.TextYAlignment = Enum.TextYAlignment.Top
    _K2OP6i9VLMVhVKKOyH1v7e.TextWrapped = true
    _K2OP6i9VLMVhVKKOyH1v7e.Parent = _PdF3Vsz8dCVVg03G02GHKq
    local _8atcn0mQRt9RpOCaI4AjJk = TextService:GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(200, math.huge))
    _PdF3Vsz8dCVVg03G02GHKq.Size = UDim2.new(0, math.min(_8atcn0mQRt9RpOCaI4AjJk.X + 12, 250), 0, _8atcn0mQRt9RpOCaI4AjJk.Y + 8)
    return _PdF3Vsz8dCVVg03G02GHKq
end
local function _H8mOWlkdsZzqVD0T9SFm5G(button, text)
    local _xSLYaWp9MAVj6mQoOX0oZJ = false
    local _M7cAOpy4jnee0yLswlmLnZ = nil
    button.MouseEnter:Connect(function()
        if _PdF3Vsz8dCVVg03G02GHKq then
            _PdF3Vsz8dCVVg03G02GHKq:Destroy()
        end
        _xSLYaWp9MAVj6mQoOX0oZJ = true
        spawn(function()
            task.wait(0.2)
            if not _xSLYaWp9MAVj6mQoOX0oZJ then
                return
            end
            if not button or not button.Parent then
                return
            end
            _M7cAOpy4jnee0yLswlmLnZ = _6WYb50N1bgR10lWPddxsjK(text)
            task.wait()
            if not _xSLYaWp9MAVj6mQoOX0oZJ then
                if _M7cAOpy4jnee0yLswlmLnZ and _M7cAOpy4jnee0yLswlmLnZ.Parent then
                    _M7cAOpy4jnee0yLswlmLnZ:Destroy()
                    _M7cAOpy4jnee0yLswlmLnZ = nil
                end
                return
            end
            local _XSCDtFxF6cUuIrkroYx6Fm = button.AbsolutePosition
            local _Cgjvk1o2P8mAcscWZix3kz = button.AbsoluteSize
            local _sFgs6QB3GAmDH2qF803STa = _M7cAOpy4jnee0yLswlmLnZ.AbsoluteSize
            local _KcUdf3xl4fYWuhyMi7aT8h = _XSCDtFxF6cUuIrkroYx6Fm.X + (_Cgjvk1o2P8mAcscWZix3kz.X / 2) - (_sFgs6QB3GAmDH2qF803STa.X / 2)
            local _lZZWl0D4ITljruiWaaxI12 = _XSCDtFxF6cUuIrkroYx6Fm.Y - _sFgs6QB3GAmDH2qF803STa.Y - 5
            if _KcUdf3xl4fYWuhyMi7aT8h < 5 then
                _KcUdf3xl4fYWuhyMi7aT8h = 5
            elseif _KcUdf3xl4fYWuhyMi7aT8h + _sFgs6QB3GAmDH2qF803STa.X > _S0syiCt3DB2qEki81fRzIy.AbsoluteSize.X - 5 then
                _KcUdf3xl4fYWuhyMi7aT8h = _S0syiCt3DB2qEki81fRzIy.AbsoluteSize.X - _sFgs6QB3GAmDH2qF803STa.X - 5
            end
            _M7cAOpy4jnee0yLswlmLnZ.Position = UDim2.new(0, _KcUdf3xl4fYWuhyMi7aT8h, 0, _lZZWl0D4ITljruiWaaxI12)
            _M7cAOpy4jnee0yLswlmLnZ.Size = UDim2.new(0, 0, 0, 0)
            _M7cAOpy4jnee0yLswlmLnZ.BackgroundTransparency = 1
            local _oTBszlGVnMdDvMOLiCys6T = TweenService:Create(
                _M7cAOpy4jnee0yLswlmLnZ,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, _sFgs6QB3GAmDH2qF803STa.X, 0, _sFgs6QB3GAmDH2qF803STa.Y), BackgroundTransparency = 0}
            )
            _oTBszlGVnMdDvMOLiCys6T:Play()
        end)
    end)
    button.MouseLeave:Connect(function()
        _xSLYaWp9MAVj6mQoOX0oZJ = false
        if _M7cAOpy4jnee0yLswlmLnZ and _M7cAOpy4jnee0yLswlmLnZ.Parent then
            local _oTBszlGVnMdDvMOLiCys6T = TweenService:Create(
                _M7cAOpy4jnee0yLswlmLnZ,
                TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}
            )
            _oTBszlGVnMdDvMOLiCys6T:Play()
            _oTBszlGVnMdDvMOLiCys6T.Completed:Connect(function()
                if _M7cAOpy4jnee0yLswlmLnZ and _M7cAOpy4jnee0yLswlmLnZ.Parent then
                    _M7cAOpy4jnee0yLswlmLnZ:Destroy()
                    _M7cAOpy4jnee0yLswlmLnZ = nil
                    _PdF3Vsz8dCVVg03G02GHKq = nil
                end
            end)
        end
    end)
end
local _jjANuFqeqGpvdafCundgmR = Instance.new("TextLabel")
_jjANuFqeqGpvdafCundgmR.Name = "TitleText"
_jjANuFqeqGpvdafCundgmR.Size = UDim2.new(1, -20, 1, 0)
_jjANuFqeqGpvdafCundgmR.Position = UDim2.new(0, 15, 0, 0)
_jjANuFqeqGpvdafCundgmR.BackgroundTransparency = 1
_jjANuFqeqGpvdafCundgmR.Text = "Player Tip Stats"
_jjANuFqeqGpvdafCundgmR.TextColor3 = Color3.fromRGB(240, 240, 240)
_jjANuFqeqGpvdafCundgmR.TextSize = 17
_jjANuFqeqGpvdafCundgmR.Font = Enum.Font.GothamSemibold
_jjANuFqeqGpvdafCundgmR.TextXAlignment = Enum.TextXAlignment.Left
_jjANuFqeqGpvdafCundgmR.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _FJLzTE4exYHe5prmCXFjxr = Instance.new("TextButton")
_FJLzTE4exYHe5prmCXFjxr.Name = "SettingsButton"
_FJLzTE4exYHe5prmCXFjxr.Size = UDim2.new(0, 32, 0, 32)
_FJLzTE4exYHe5prmCXFjxr.Position = UDim2.new(1, -188, 0, 6.5)
_FJLzTE4exYHe5prmCXFjxr.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_FJLzTE4exYHe5prmCXFjxr.Text = "⚙"
_FJLzTE4exYHe5prmCXFjxr.TextColor3 = Color3.fromRGB(220, 220, 220)
_FJLzTE4exYHe5prmCXFjxr.TextSize = 16
_FJLzTE4exYHe5prmCXFjxr.Font = Enum.Font.GothamBold
_FJLzTE4exYHe5prmCXFjxr.BorderSizePixel = 0
_FJLzTE4exYHe5prmCXFjxr.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _J1YL3ZAcsLXhTrgCEp6HMn = Instance.new("UICorner")
_J1YL3ZAcsLXhTrgCEp6HMn.CornerRadius = UDim.new(0, 6)
_J1YL3ZAcsLXhTrgCEp6HMn.Parent = _FJLzTE4exYHe5prmCXFjxr
_FJLzTE4exYHe5prmCXFjxr.MouseEnter:Connect(function()
    _FJLzTE4exYHe5prmCXFjxr.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
_FJLzTE4exYHe5prmCXFjxr.MouseLeave:Connect(function()
    _FJLzTE4exYHe5prmCXFjxr.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
_H8mOWlkdsZzqVD0T9SFm5G(_FJLzTE4exYHe5prmCXFjxr, "Settings")
local _re5qfWtmvctI7fWtq65VEu = false
local _aTEGfarD9aIdgCBvTozpAX = {}
local _rLp3SE03G5reGQCebwBiUO = nil
local _PhMfrV9R2H6iT31hs2DeIF = nil
local _zPD8EKH7czjgXL3tnHh7ox = {}
local _4BCSgFFhJWBhTSV5VX04Bp = {}
local _dFoL2KYYKZmWE03gv5CfaU = {
    showLocationHubButton = true,
    hideAllTipJars = false,
    disableAltRequirement = false,
    disableHoverInfo = false,
    disableHoverOutline = false,
    toggleKeyCode = Enum.KeyCode.V,
    hoverRange = 20,
}
local _VbA2MutJNctQiutM1sjjcK = "TipStatsGUI_Settings"
local _Q3rBTFeui4uHCprihKxXdT = nil
local function _JfvnLGBwbI7NxDCEXIRtHd()
    pcall(function()
        if not _Q3rBTFeui4uHCprihKxXdT then
            _Q3rBTFeui4uHCprihKxXdT = ReplicatedStorage:FindFirstChild(_VbA2MutJNctQiutM1sjjcK)
            if not _Q3rBTFeui4uHCprihKxXdT then
                _Q3rBTFeui4uHCprihKxXdT = Instance.new("StringValue")
                _Q3rBTFeui4uHCprihKxXdT.Name = _VbA2MutJNctQiutM1sjjcK
                _Q3rBTFeui4uHCprihKxXdT.Parent = ReplicatedStorage
            end
        end
        local _IFb3HuocqbTLhTHlHKIf4D = {
            showLocationHubButton = _dFoL2KYYKZmWE03gv5CfaU.showLocationHubButton,
            hideAllTipJars = _dFoL2KYYKZmWE03gv5CfaU.hideAllTipJars,
            disableAltRequirement = _dFoL2KYYKZmWE03gv5CfaU.disableAltRequirement,
            disableHoverInfo = _dFoL2KYYKZmWE03gv5CfaU.disableHoverInfo,
            disableHoverOutline = _dFoL2KYYKZmWE03gv5CfaU.disableHoverOutline,
            hoverRange = _dFoL2KYYKZmWE03gv5CfaU.hoverRange,
            toggleKeyCodeName = _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode and _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode.Name or nil,
        }
        local success, jsonString = pcall(function()
            return HttpService:JSONEncode(_IFb3HuocqbTLhTHlHKIf4D)
        end)
        if success and jsonString then
            _Q3rBTFeui4uHCprihKxXdT.Value = jsonString
            print("TipStatsGUI: Settings saved")
        else
            warn("TipStatsGUI: Failed to encode _7IJRE0NgInWp613Mc4YtlX")
        end
    end)
end
local function _mXyqP0lOQ6hvyvmQTGa8HA()
    pcall(function()
        _Q3rBTFeui4uHCprihKxXdT = ReplicatedStorage:FindFirstChild(_VbA2MutJNctQiutM1sjjcK)
        if not _Q3rBTFeui4uHCprihKxXdT then
            return
        end
        if _Q3rBTFeui4uHCprihKxXdT.Value == "" or _Q3rBTFeui4uHCprihKxXdT.Value == nil then
            return
        end
        local success, settingsData = pcall(function()
            return HttpService:JSONDecode(_Q3rBTFeui4uHCprihKxXdT.Value)
        end)
        if not success or not settingsData then
            warn("TipStatsGUI: Failed to decode _7IJRE0NgInWp613Mc4YtlX")
            return
        end
        if settingsData.showLocationHubButton ~= nil then
            _dFoL2KYYKZmWE03gv5CfaU.showLocationHubButton = settingsData.showLocationHubButton
        end
        if settingsData.hideAllTipJars ~= nil then
            _dFoL2KYYKZmWE03gv5CfaU.hideAllTipJars = settingsData.hideAllTipJars
        end
        if settingsData.disableAltRequirement ~= nil then
            _dFoL2KYYKZmWE03gv5CfaU.disableAltRequirement = settingsData.disableAltRequirement
        end
        if settingsData.disableHoverInfo ~= nil then
            _dFoL2KYYKZmWE03gv5CfaU.disableHoverInfo = settingsData.disableHoverInfo
        end
        if settingsData.disableHoverOutline ~= nil then
            _dFoL2KYYKZmWE03gv5CfaU.disableHoverOutline = settingsData.disableHoverOutline
        end
        if settingsData.hoverRange ~= nil then
            _dFoL2KYYKZmWE03gv5CfaU.hoverRange = math.max(20, math.min(100, settingsData.hoverRange))
        end
        if settingsData.toggleKeyCodeName then
            local _d0emFDP5wrcYFeJrXXa3fs = Enum.KeyCode[settingsData.toggleKeyCodeName]
            if _d0emFDP5wrcYFeJrXXa3fs then
                _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode = _d0emFDP5wrcYFeJrXXa3fs
            end
        end
        print("TipStatsGUI: Settings loaded")
    end)
end
local _ATvSmFv819KG1YK0RJYnqF = {}
local _mwKoRu6a9p9tI6r4x6sJ9u = {}
local _3ZY5HZFrVY4yTv85Md1bMZ = Instance.new("BindableEvent")
local _JD0uC72q64U8mpRIsEg2iz = {}
local _BV86plIPCkSAtGcR2pWgc0 = nil
local function _wZfqLs3LjJppkdDdMw1wsB(_LovOfbaPAgtCeey8jCuEVQ)
    if _LovOfbaPAgtCeey8jCuEVQ then
        _4BCSgFFhJWBhTSV5VX04Bp[_LovOfbaPAgtCeey8jCuEVQ] = true
    end
end
local function _vDQvNmAoaFQ8816Usju6pB(container)
    if not container then
        return false
    end
    return container:FindFirstChild("TipJar") ~= nil
end
local function _3VUJ8SiQbUz6exE1M0KCLV(_LovOfbaPAgtCeey8jCuEVQ)
    if not _LovOfbaPAgtCeey8jCuEVQ then
        return false
    end
    if _4BCSgFFhJWBhTSV5VX04Bp[_LovOfbaPAgtCeey8jCuEVQ] then
        return true
    end
    if _vDQvNmAoaFQ8816Usju6pB(_LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("Backpack")) or _vDQvNmAoaFQ8816Usju6pB(_LovOfbaPAgtCeey8jCuEVQ.Character) then
        _wZfqLs3LjJppkdDdMw1wsB(_LovOfbaPAgtCeey8jCuEVQ)
        return true
    end
    return false
end
local function _HVrRpJrPz2lndcKTNjYWtB(tool, hidden)
    if not tool then
        return
    end
    local _C4uSQ1u6Szcv6SPOzz0XVi = _ATvSmFv819KG1YK0RJYnqF[tool]
    if hidden then
        if not _C4uSQ1u6Szcv6SPOzz0XVi then
            _C4uSQ1u6Szcv6SPOzz0XVi = {
                originals = {},
            }
            _ATvSmFv819KG1YK0RJYnqF[tool] = _C4uSQ1u6Szcv6SPOzz0XVi
            _C4uSQ1u6Szcv6SPOzz0XVi.descendantAdded = tool.DescendantAdded:Connect(function(descendant)
                if _dFoL2KYYKZmWE03gv5CfaU.hideAllTipJars then
                    if descendant:IsA("BasePart") then
                        if _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] == nil then
                            _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = descendant.LocalTransparencyModifier
                        end
                        descendant.LocalTransparencyModifier = 1
                    elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                        if _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] == nil then
                            _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = descendant.Transparency
                        end
                        descendant.Transparency = 1
                    elseif descendant:IsA("ProximityPrompt") then
                        if _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] == nil then
                            _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = descendant.Enabled
                        end
                        descendant.Enabled = false
                    end
                end
            end)
            _C4uSQ1u6Szcv6SPOzz0XVi.descendantRemoving = tool.DescendantRemoving:Connect(function(descendant)
                _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = nil
            end)
            _C4uSQ1u6Szcv6SPOzz0XVi.ancestryChanged = tool.AncestryChanged:Connect(function(_, parent)
                if not parent then
                    if _C4uSQ1u6Szcv6SPOzz0XVi.descendantAdded then _C4uSQ1u6Szcv6SPOzz0XVi.descendantAdded:Disconnect() end
                    if _C4uSQ1u6Szcv6SPOzz0XVi.descendantRemoving then _C4uSQ1u6Szcv6SPOzz0XVi.descendantRemoving:Disconnect() end
                    if _C4uSQ1u6Szcv6SPOzz0XVi.ancestryChanged then _C4uSQ1u6Szcv6SPOzz0XVi.ancestryChanged:Disconnect() end
                    _ATvSmFv819KG1YK0RJYnqF[tool] = nil
                end
            end)
        end
        for _, descendant in ipairs(tool:GetDescendants()) do
            if descendant:IsA("BasePart") then
                if _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] == nil then
                    _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = descendant.LocalTransparencyModifier
                end
                descendant.LocalTransparencyModifier = 1
            elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                if _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] == nil then
                    _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = descendant.Transparency
                end
                descendant.Transparency = 1
            elseif descendant:IsA("ProximityPrompt") then
                if _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] == nil then
                    _C4uSQ1u6Szcv6SPOzz0XVi.originals[descendant] = descendant.Enabled
                end
                descendant.Enabled = false
            end
        end
    else
        if _C4uSQ1u6Szcv6SPOzz0XVi then
            for instanceRef, originalValue in pairs(_C4uSQ1u6Szcv6SPOzz0XVi.originals) do
                if instanceRef:IsA("BasePart") then
                    instanceRef.LocalTransparencyModifier = originalValue or 0
                elseif instanceRef:IsA("Decal") or instanceRef:IsA("Texture") then
                    instanceRef.Transparency = originalValue or 0
                elseif instanceRef:IsA("ProximityPrompt") then
                    instanceRef.Enabled = (originalValue == nil) and true or originalValue
                end
            end
            if _C4uSQ1u6Szcv6SPOzz0XVi.descendantAdded then _C4uSQ1u6Szcv6SPOzz0XVi.descendantAdded:Disconnect() end
            if _C4uSQ1u6Szcv6SPOzz0XVi.descendantRemoving then _C4uSQ1u6Szcv6SPOzz0XVi.descendantRemoving:Disconnect() end
            if _C4uSQ1u6Szcv6SPOzz0XVi.ancestryChanged then _C4uSQ1u6Szcv6SPOzz0XVi.ancestryChanged:Disconnect() end
            _ATvSmFv819KG1YK0RJYnqF[tool] = nil
        end
    end
end
local function _J8MQbuojBc1fwCHTfhVeHL(tool)
    if not tool then
        return
    end
    _HVrRpJrPz2lndcKTNjYWtB(tool, _dFoL2KYYKZmWE03gv5CfaU.hideAllTipJars)
end
local function _TL9dILLeKkq41tWQBudmQB(container)
    if not container then
        return
    end
    for _, child in ipairs(container:GetChildren()) do
        if child.Name == "TipJar" then
            _J8MQbuojBc1fwCHTfhVeHL(child)
        end
        if child:IsA("Tool") or child:IsA("Model") then
            _TL9dILLeKkq41tWQBudmQB(child)
        end
    end
end
local function _nKT7aKXjla7HyfAvffWdNX(_LovOfbaPAgtCeey8jCuEVQ)
    if not _LovOfbaPAgtCeey8jCuEVQ then
        return
    end
    _TL9dILLeKkq41tWQBudmQB(_LovOfbaPAgtCeey8jCuEVQ.Character)
    _TL9dILLeKkq41tWQBudmQB(_LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("Backpack"))
end
local function _8IKAMP52MbI7fV6NZMC1bM()
    for _, _LovOfbaPAgtCeey8jCuEVQ in ipairs(Players:GetPlayers()) do
        _nKT7aKXjla7HyfAvffWdNX(_LovOfbaPAgtCeey8jCuEVQ)
    end
end
local function _42UwvlhNCVR9J2pMs0oU5M(_LovOfbaPAgtCeey8jCuEVQ)
    if not _LovOfbaPAgtCeey8jCuEVQ then
        return
    end
    if _JD0uC72q64U8mpRIsEg2iz[_LovOfbaPAgtCeey8jCuEVQ] then
        return
    end
    local _uXfnOtBS3xj11m29nCqNas = {}
    local function _aTGiPv0LjoaredUaqedrhR(container)
        if not container then
            return
        end
        for _, child in ipairs(container:GetChildren()) do
            if child.Name == "TipJar" then
                _wZfqLs3LjJppkdDdMw1wsB(_LovOfbaPAgtCeey8jCuEVQ)
                _J8MQbuojBc1fwCHTfhVeHL(child)
            end
        end
        table.insert(_uXfnOtBS3xj11m29nCqNas, container.ChildAdded:Connect(function(child)
            if child.Name == "TipJar" then
                _wZfqLs3LjJppkdDdMw1wsB(_LovOfbaPAgtCeey8jCuEVQ)
                _J8MQbuojBc1fwCHTfhVeHL(child)
            end
        end))
    end
    local function _QLJViXILO3ffWJlDgN0aCG(_eFeI6z5h3sgZdZDgySG4fN)
        _aTGiPv0LjoaredUaqedrhR(_eFeI6z5h3sgZdZDgySG4fN)
    end
    local _eFeI6z5h3sgZdZDgySG4fN = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("Backpack")
    if _eFeI6z5h3sgZdZDgySG4fN then
        _QLJViXILO3ffWJlDgN0aCG(_eFeI6z5h3sgZdZDgySG4fN)
    end
    table.insert(_uXfnOtBS3xj11m29nCqNas, _LovOfbaPAgtCeey8jCuEVQ.ChildAdded:Connect(function(child)
        if child.Name == "Backpack" then
            _QLJViXILO3ffWJlDgN0aCG(child)
        end
    end))
    local function _h6ROnZIighScOLvPfrRtT2(_NXDf15WGHv4zdyTFuuiM2w)
        _aTGiPv0LjoaredUaqedrhR(_NXDf15WGHv4zdyTFuuiM2w)
    end
    if _LovOfbaPAgtCeey8jCuEVQ.Character then
        _h6ROnZIighScOLvPfrRtT2(_LovOfbaPAgtCeey8jCuEVQ.Character)
    end
    table.insert(_uXfnOtBS3xj11m29nCqNas, _LovOfbaPAgtCeey8jCuEVQ.CharacterAdded:Connect(function(_NXDf15WGHv4zdyTFuuiM2w)
        _h6ROnZIighScOLvPfrRtT2(_NXDf15WGHv4zdyTFuuiM2w)
    end))
    _JD0uC72q64U8mpRIsEg2iz[_LovOfbaPAgtCeey8jCuEVQ] = _uXfnOtBS3xj11m29nCqNas
    _nKT7aKXjla7HyfAvffWdNX(_LovOfbaPAgtCeey8jCuEVQ)
end
_BV86plIPCkSAtGcR2pWgc0 = ensureTipJarTracking
local function _G8XeaegcvaWae9xsIWJODT(_NXDf15WGHv4zdyTFuuiM2w)
    if not _NXDf15WGHv4zdyTFuuiM2w or not _NXDf15WGHv4zdyTFuuiM2w.Parent then return end
    local _MbuECcuuyZtiyKNdKhF8hg = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChildOfClass("Humanoid")
    local _CQzJpPC316GgHbG6I6Rxpz = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChild("HumanoidRootPart")
    if _MbuECcuuyZtiyKNdKhF8hg then
        if not _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalWalkSpeed") then
            _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalWalkSpeed", _MbuECcuuyZtiyKNdKhF8hg.WalkSpeed)
        end
        if not _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalJumpPower") then
            _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalJumpPower", _MbuECcuuyZtiyKNdKhF8hg.JumpPower)
        end
    end
    for _, descendant in ipairs(_NXDf15WGHv4zdyTFuuiM2w:GetDescendants()) do
        if descendant == _CQzJpPC316GgHbG6I6Rxpz then
            continue
        end
        if descendant:IsA("BasePart") then
            if not descendant:GetAttribute("OriginalTransparency") then
                descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
            end
            if not descendant:GetAttribute("OriginalCanCollide") then
                descendant:SetAttribute("OriginalCanCollide", descendant.CanCollide)
            end
            descendant.Transparency = 1
            if descendant ~= _CQzJpPC316GgHbG6I6Rxpz then
                descendant.CanCollide = false
            end
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            if not descendant:GetAttribute("OriginalTransparency") then
                descendant:SetAttribute("OriginalTransparency", descendant.Transparency)
            end
            descendant.Transparency = 1
        elseif descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
            if not descendant:GetAttribute("OriginalEnabled") then
                descendant:SetAttribute("OriginalEnabled", descendant.Enabled)
            end
            descendant.Enabled = false
        end
    end
    local _LovOfbaPAgtCeey8jCuEVQ = Players:GetPlayerFromCharacter(_NXDf15WGHv4zdyTFuuiM2w)
    if _LovOfbaPAgtCeey8jCuEVQ then
        local _oNaWDjOawk1Rr6jyktuOMu = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("PlayerGui")
        if _oNaWDjOawk1Rr6jyktuOMu then
            for _, gui in ipairs(_oNaWDjOawk1Rr6jyktuOMu:GetDescendants()) do
                if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                    if not gui:GetAttribute("OriginalEnabled") then
                        gui:SetAttribute("OriginalEnabled", gui.Enabled)
                    end
                    gui.Enabled = false
                end
            end
        end
    end
    if _CQzJpPC316GgHbG6I6Rxpz then
        if not _CQzJpPC316GgHbG6I6Rxpz:GetAttribute("OriginalTransparency") then
            _CQzJpPC316GgHbG6I6Rxpz:SetAttribute("OriginalTransparency", _CQzJpPC316GgHbG6I6Rxpz.Transparency)
        end
        _CQzJpPC316GgHbG6I6Rxpz.Transparency = 1
        for _, gui in ipairs(_CQzJpPC316GgHbG6I6Rxpz:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                if not gui:GetAttribute("OriginalEnabled") then
                    gui:SetAttribute("OriginalEnabled", gui.Enabled)
                end
                gui.Enabled = false
            end
        end
    end
    local _a9wLzDOzpLiQVPjQuE52RO = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChild("Head")
    if _a9wLzDOzpLiQVPjQuE52RO then
        for _, gui in ipairs(_a9wLzDOzpLiQVPjQuE52RO:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                if not gui:GetAttribute("OriginalEnabled") then
                    gui:SetAttribute("OriginalEnabled", gui.Enabled)
                end
                gui.Enabled = false
            end
        end
    end
    _NXDf15WGHv4zdyTFuuiM2w:SetAttribute("WasHidden", true)
    pcall(function()
        local _LovOfbaPAgtCeey8jCuEVQ = Players:GetPlayerFromCharacter(_NXDf15WGHv4zdyTFuuiM2w)
        if _LovOfbaPAgtCeey8jCuEVQ then
            _vKC1R9F3rjjPuJxlNFkK1n(_LovOfbaPAgtCeey8jCuEVQ.Name)
        end
    end)
end
local function _Eudu6n2bCJWj8O1nfmKszg(_NXDf15WGHv4zdyTFuuiM2w)
    if not _NXDf15WGHv4zdyTFuuiM2w or not _NXDf15WGHv4zdyTFuuiM2w.Parent then return end
    local _MbuECcuuyZtiyKNdKhF8hg = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChildOfClass("Humanoid")
    local _CQzJpPC316GgHbG6I6Rxpz = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChild("HumanoidRootPart")
    if _MbuECcuuyZtiyKNdKhF8hg then
        local _Nlc8dt1nHgDFEdBo5ovVYk = _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalWalkSpeed")
        if _Nlc8dt1nHgDFEdBo5ovVYk ~= nil then
            _MbuECcuuyZtiyKNdKhF8hg.WalkSpeed = _Nlc8dt1nHgDFEdBo5ovVYk
            _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalWalkSpeed", nil)
        else
            if _MbuECcuuyZtiyKNdKhF8hg.WalkSpeed == 0 then
                _MbuECcuuyZtiyKNdKhF8hg.WalkSpeed = 16
            end
        end
        local _yLIpRE7l5nJK7JOnkRUD2W = _MbuECcuuyZtiyKNdKhF8hg:GetAttribute("OriginalJumpPower")
        if _yLIpRE7l5nJK7JOnkRUD2W ~= nil then
            _MbuECcuuyZtiyKNdKhF8hg.JumpPower = _yLIpRE7l5nJK7JOnkRUD2W
            _MbuECcuuyZtiyKNdKhF8hg:SetAttribute("OriginalJumpPower", nil)
        else
            if _MbuECcuuyZtiyKNdKhF8hg.JumpPower == 0 then
                _MbuECcuuyZtiyKNdKhF8hg.JumpPower = 50
            end
        end
    end
    for _, descendant in ipairs(_NXDf15WGHv4zdyTFuuiM2w:GetDescendants()) do
        if descendant == _CQzJpPC316GgHbG6I6Rxpz then
            continue
        end
        if descendant:IsA("BasePart") then
            local _aPmeY5XeJZhgqKpnroFxUS = descendant:GetAttribute("OriginalTransparency")
            if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
                descendant.Transparency = _aPmeY5XeJZhgqKpnroFxUS
            else
                descendant.Transparency = 0
            end
            local _tmKceRjEc92aiZxMvMSIe8 = descendant:GetAttribute("OriginalCanCollide")
            if _tmKceRjEc92aiZxMvMSIe8 ~= nil then
                descendant.CanCollide = _tmKceRjEc92aiZxMvMSIe8
            else
                descendant.CanCollide = true
            end
            descendant:SetAttribute("OriginalTransparency", nil)
            descendant:SetAttribute("OriginalCanCollide", nil)
        elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
            local _aPmeY5XeJZhgqKpnroFxUS = descendant:GetAttribute("OriginalTransparency")
            if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
                descendant.Transparency = _aPmeY5XeJZhgqKpnroFxUS
            else
                descendant.Transparency = 0
            end
            descendant:SetAttribute("OriginalTransparency", nil)
        elseif descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
            local _ailtKgwUeVsgqQUdTUbW11 = descendant:GetAttribute("OriginalEnabled")
            if _ailtKgwUeVsgqQUdTUbW11 ~= nil then
                descendant.Enabled = _ailtKgwUeVsgqQUdTUbW11
            else
                descendant.Enabled = true
            end
            descendant:SetAttribute("OriginalEnabled", nil)
        end
    end
    local _LovOfbaPAgtCeey8jCuEVQ = Players:GetPlayerFromCharacter(_NXDf15WGHv4zdyTFuuiM2w)
    if _LovOfbaPAgtCeey8jCuEVQ then
        local _oNaWDjOawk1Rr6jyktuOMu = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("PlayerGui")
        if _oNaWDjOawk1Rr6jyktuOMu then
            for _, gui in ipairs(_oNaWDjOawk1Rr6jyktuOMu:GetDescendants()) do
                if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                    local _ailtKgwUeVsgqQUdTUbW11 = gui:GetAttribute("OriginalEnabled")
                    if _ailtKgwUeVsgqQUdTUbW11 ~= nil then
                        gui.Enabled = _ailtKgwUeVsgqQUdTUbW11
                    else
                        gui.Enabled = true
                    end
                    gui:SetAttribute("OriginalEnabled", nil)
                end
            end
        end
    end
    if _CQzJpPC316GgHbG6I6Rxpz then
        local _aPmeY5XeJZhgqKpnroFxUS = _CQzJpPC316GgHbG6I6Rxpz:GetAttribute("OriginalTransparency")
        if _aPmeY5XeJZhgqKpnroFxUS ~= nil then
            _CQzJpPC316GgHbG6I6Rxpz.Transparency = _aPmeY5XeJZhgqKpnroFxUS
        else
            _CQzJpPC316GgHbG6I6Rxpz.Transparency = 0
        end
        _CQzJpPC316GgHbG6I6Rxpz:SetAttribute("OriginalTransparency", nil)
        local _tmKceRjEc92aiZxMvMSIe8 = _CQzJpPC316GgHbG6I6Rxpz:GetAttribute("OriginalCanCollide")
        if _tmKceRjEc92aiZxMvMSIe8 ~= nil then
            _CQzJpPC316GgHbG6I6Rxpz.CanCollide = _tmKceRjEc92aiZxMvMSIe8
            _CQzJpPC316GgHbG6I6Rxpz:SetAttribute("OriginalCanCollide", nil)
        end
        for _, gui in ipairs(_CQzJpPC316GgHbG6I6Rxpz:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                local _ailtKgwUeVsgqQUdTUbW11 = gui:GetAttribute("OriginalEnabled")
                if _ailtKgwUeVsgqQUdTUbW11 ~= nil then
                    gui.Enabled = _ailtKgwUeVsgqQUdTUbW11
                else
                    gui.Enabled = true
                end
                gui:SetAttribute("OriginalEnabled", nil)
            end
        end
    end
    local _a9wLzDOzpLiQVPjQuE52RO = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChild("Head")
    if _a9wLzDOzpLiQVPjQuE52RO then
        for _, gui in ipairs(_a9wLzDOzpLiQVPjQuE52RO:GetChildren()) do
            if gui:IsA("BillboardGui") or gui:IsA("SurfaceGui") then
                local _ailtKgwUeVsgqQUdTUbW11 = gui:GetAttribute("OriginalEnabled")
                if _ailtKgwUeVsgqQUdTUbW11 ~= nil then
                    gui.Enabled = _ailtKgwUeVsgqQUdTUbW11
                else
                    gui.Enabled = true
                end
                gui:SetAttribute("OriginalEnabled", nil)
            end
        end
    end
    _NXDf15WGHv4zdyTFuuiM2w:SetAttribute("WasHidden", nil)
    pcall(function()
        local _LovOfbaPAgtCeey8jCuEVQ = Players:GetPlayerFromCharacter(_NXDf15WGHv4zdyTFuuiM2w)
        if _LovOfbaPAgtCeey8jCuEVQ then
            _vKC1R9F3rjjPuJxlNFkK1n(_LovOfbaPAgtCeey8jCuEVQ.Name)
        end
    end)
end
local function _dCLZefCQccupswXDbTCJyf(_LovOfbaPAgtCeey8jCuEVQ)
    return _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] == true
end
local function _r2kZoFKq2558xNdCs6TLxN(_LovOfbaPAgtCeey8jCuEVQ, hidden)
    if not _LovOfbaPAgtCeey8jCuEVQ then
        return
    end
    if hidden then
        if not _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] then
            _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] = true
        end
        if _LovOfbaPAgtCeey8jCuEVQ.Character then
            _G8XeaegcvaWae9xsIWJODT(_LovOfbaPAgtCeey8jCuEVQ.Character)
        end
        if _mwKoRu6a9p9tI6r4x6sJ9u[_LovOfbaPAgtCeey8jCuEVQ] then
            _mwKoRu6a9p9tI6r4x6sJ9u[_LovOfbaPAgtCeey8jCuEVQ]:Disconnect()
        end
        _mwKoRu6a9p9tI6r4x6sJ9u[_LovOfbaPAgtCeey8jCuEVQ] = _LovOfbaPAgtCeey8jCuEVQ.CharacterAdded:Connect(function(_NXDf15WGHv4zdyTFuuiM2w)
            if _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] then
                _G8XeaegcvaWae9xsIWJODT(_NXDf15WGHv4zdyTFuuiM2w)
            end
        end)
    else
        if _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] then
            _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] = nil
        end
        if _LovOfbaPAgtCeey8jCuEVQ.Character then
            _Eudu6n2bCJWj8O1nfmKszg(_LovOfbaPAgtCeey8jCuEVQ.Character)
        end
        if _mwKoRu6a9p9tI6r4x6sJ9u[_LovOfbaPAgtCeey8jCuEVQ] then
            _mwKoRu6a9p9tI6r4x6sJ9u[_LovOfbaPAgtCeey8jCuEVQ]:Disconnect()
            _mwKoRu6a9p9tI6r4x6sJ9u[_LovOfbaPAgtCeey8jCuEVQ] = nil
        end
    end
    _3ZY5HZFrVY4yTv85Md1bMZ:Fire(_LovOfbaPAgtCeey8jCuEVQ, _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ] == true)
end
local function _AfmX36PRCSE6dNDr45M3Rl(_LovOfbaPAgtCeey8jCuEVQ)
    _r2kZoFKq2558xNdCs6TLxN(_LovOfbaPAgtCeey8jCuEVQ, not _zPD8EKH7czjgXL3tnHh7ox[_LovOfbaPAgtCeey8jCuEVQ])
end
local function _vKC1R9F3rjjPuJxlNFkK1n(_wl1OX72rRU771TA0U2nWek)
    pcall(function()
        if not Workspace:FindFirstChild("PlayerCharacters") then
            return
        end
        local _gtzPBb2gbVdSCYQ14stqQ4 = Workspace.PlayerCharacters:FindFirstChild(_wl1OX72rRU771TA0U2nWek)
        if not _gtzPBb2gbVdSCYQ14stqQ4 then
            return
        end
        local _CQzJpPC316GgHbG6I6Rxpz = _gtzPBb2gbVdSCYQ14stqQ4:FindFirstChild("HumanoidRootPart")
        if not _CQzJpPC316GgHbG6I6Rxpz then
            return
        end
        local _Qlo2Ws6JLCYYrm2dv2tmKe = _CQzJpPC316GgHbG6I6Rxpz:FindFirstChild("AFKTag")
        if not _Qlo2Ws6JLCYYrm2dv2tmKe then
            return
        end
        local _C4uSQ1u6Szcv6SPOzz0XVi = _Qlo2Ws6JLCYYrm2dv2tmKe:FindFirstChild("Data")
        if _C4uSQ1u6Szcv6SPOzz0XVi then
            if not _C4uSQ1u6Szcv6SPOzz0XVi:GetAttribute("OriginalEnabled") then
                _C4uSQ1u6Szcv6SPOzz0XVi:SetAttribute("OriginalEnabled", _C4uSQ1u6Szcv6SPOzz0XVi.Enabled)
            end
            _C4uSQ1u6Szcv6SPOzz0XVi.Enabled = false
            print("TipStatsGUI: Disabled AFKTag for", _wl1OX72rRU771TA0U2nWek)
        else
            if not _Qlo2Ws6JLCYYrm2dv2tmKe:GetAttribute("OriginalEnabled") then
                _Qlo2Ws6JLCYYrm2dv2tmKe:SetAttribute("OriginalEnabled", _Qlo2Ws6JLCYYrm2dv2tmKe.Enabled)
            end
            _Qlo2Ws6JLCYYrm2dv2tmKe.Enabled = false
            print("TipStatsGUI: Disabled AFKTag (no Data) for", _wl1OX72rRU771TA0U2nWek)
        end
    end)
end
local function _aN4QlUTZBSSicxIfZ9QttL()
    pcall(function()
        if not Workspace:FindFirstChild("PlayerCharacters") then
            return
        end
        for _, _gtzPBb2gbVdSCYQ14stqQ4 in ipairs(Workspace.PlayerCharacters:GetChildren()) do
            if _gtzPBb2gbVdSCYQ14stqQ4:IsA("Model") or _gtzPBb2gbVdSCYQ14stqQ4:IsA("Folder") then
                _vKC1R9F3rjjPuJxlNFkK1n(_gtzPBb2gbVdSCYQ14stqQ4.Name)
            end
        end
    end)
end
local function _n3NPb7zD513M1vxzfSFhnP()
    _re5qfWtmvctI7fWtq65VEu = not _re5qfWtmvctI7fWtq65VEu
    local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
    _aN4QlUTZBSSicxIfZ9QttL()
    if _re5qfWtmvctI7fWtq65VEu then
        _aTEGfarD9aIdgCBvTozpAX = {}
        for _, _LovOfbaPAgtCeey8jCuEVQ in ipairs(Players:GetPlayers()) do
            if _LovOfbaPAgtCeey8jCuEVQ ~= _KCbu2Au1vAJIFqOuBflYpF and _LovOfbaPAgtCeey8jCuEVQ.Character then
                local _NXDf15WGHv4zdyTFuuiM2w = _LovOfbaPAgtCeey8jCuEVQ.Character
                _aTEGfarD9aIdgCBvTozpAX[_LovOfbaPAgtCeey8jCuEVQ] = _NXDf15WGHv4zdyTFuuiM2w
                _G8XeaegcvaWae9xsIWJODT(_NXDf15WGHv4zdyTFuuiM2w)
            end
        end
        if not _rLp3SE03G5reGQCebwBiUO then
            _rLp3SE03G5reGQCebwBiUO = Players.PlayerAdded:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
                if _re5qfWtmvctI7fWtq65VEu and _LovOfbaPAgtCeey8jCuEVQ ~= _KCbu2Au1vAJIFqOuBflYpF then
                    if _LovOfbaPAgtCeey8jCuEVQ.Character then
                        task.wait(0.1)
                        local _NXDf15WGHv4zdyTFuuiM2w = _LovOfbaPAgtCeey8jCuEVQ.Character
                        _aTEGfarD9aIdgCBvTozpAX[_LovOfbaPAgtCeey8jCuEVQ] = _NXDf15WGHv4zdyTFuuiM2w
                        _G8XeaegcvaWae9xsIWJODT(_NXDf15WGHv4zdyTFuuiM2w)
                    else
                        _LovOfbaPAgtCeey8jCuEVQ.CharacterAdded:Connect(function(_NXDf15WGHv4zdyTFuuiM2w)
                            if _re5qfWtmvctI7fWtq65VEu then
                                _aTEGfarD9aIdgCBvTozpAX[_LovOfbaPAgtCeey8jCuEVQ] = _NXDf15WGHv4zdyTFuuiM2w
                                _G8XeaegcvaWae9xsIWJODT(_NXDf15WGHv4zdyTFuuiM2w)
                            end
                        end)
                    end
                end
            end)
        end
        for _, _LovOfbaPAgtCeey8jCuEVQ in ipairs(Players:GetPlayers()) do
            if _LovOfbaPAgtCeey8jCuEVQ ~= _KCbu2Au1vAJIFqOuBflYpF then
                _LovOfbaPAgtCeey8jCuEVQ.CharacterAdded:Connect(function(_NXDf15WGHv4zdyTFuuiM2w)
                    if _re5qfWtmvctI7fWtq65VEu then
                        _aTEGfarD9aIdgCBvTozpAX[_LovOfbaPAgtCeey8jCuEVQ] = _NXDf15WGHv4zdyTFuuiM2w
                        _G8XeaegcvaWae9xsIWJODT(_NXDf15WGHv4zdyTFuuiM2w)
                    end
                end)
            end
        end
        print("TipStatsGUI: All other players hidden")
    else
        for _LovOfbaPAgtCeey8jCuEVQ, _NXDf15WGHv4zdyTFuuiM2w in pairs(_aTEGfarD9aIdgCBvTozpAX) do
            if _NXDf15WGHv4zdyTFuuiM2w and _NXDf15WGHv4zdyTFuuiM2w.Parent then
                _Eudu6n2bCJWj8O1nfmKszg(_NXDf15WGHv4zdyTFuuiM2w)
            end
        end
        for _, _LovOfbaPAgtCeey8jCuEVQ in ipairs(Players:GetPlayers()) do
            if _LovOfbaPAgtCeey8jCuEVQ ~= _KCbu2Au1vAJIFqOuBflYpF and _LovOfbaPAgtCeey8jCuEVQ.Character then
                local _NXDf15WGHv4zdyTFuuiM2w = _LovOfbaPAgtCeey8jCuEVQ.Character
                if _NXDf15WGHv4zdyTFuuiM2w:GetAttribute("WasHidden") then
                    _Eudu6n2bCJWj8O1nfmKszg(_NXDf15WGHv4zdyTFuuiM2w)
                end
            end
        end
        _aTEGfarD9aIdgCBvTozpAX = {}
        _aN4QlUTZBSSicxIfZ9QttL()
        print("TipStatsGUI: All players shown")
    end
    if _AwNIDCDdlvicMgb2pYfsob and _n44enpU2lKHCXN6gKY6VeW then
        _n44enpU2lKHCXN6gKY6VeW(_re5qfWtmvctI7fWtq65VEu)
    end
end
local _SxuSZaRjCjH38WIgQCltk9 = nil
local _7Yivni1NNtGsbnBz6RLzYP = nil
local _PBgzLW9WTf6RJ7lLFrx70e = nil
local _sFUmaJ8zf4eeKD0sFgl2vP = nil
local _AwNIDCDdlvicMgb2pYfsob = nil
local _n44enpU2lKHCXN6gKY6VeW = nil
local function _2H1AkfFPec8lMec571FQvn()
    if _PhMfrV9R2H6iT31hs2DeIF then
        _PhMfrV9R2H6iT31hs2DeIF.Visible = _dFoL2KYYKZmWE03gv5CfaU.showLocationHubButton
    end
    if not _dFoL2KYYKZmWE03gv5CfaU.showLocationHubButton and _SxuSZaRjCjH38WIgQCltk9 then
        _SxuSZaRjCjH38WIgQCltk9:Destroy()
        _SxuSZaRjCjH38WIgQCltk9 = nil
    end
end
local _HNR32FEPO0sAUcLjOHVmNY = nil
local function _j05LmCQpEwjJiqluer1pL8()
    if _7Yivni1NNtGsbnBz6RLzYP then
        if _HNR32FEPO0sAUcLjOHVmNY then
            _HNR32FEPO0sAUcLjOHVmNY:Disconnect()
            _HNR32FEPO0sAUcLjOHVmNY = nil
        end
        _7Yivni1NNtGsbnBz6RLzYP:Destroy()
        _7Yivni1NNtGsbnBz6RLzYP = nil
    end
end
local function _DqOG6lOPqsEbFj2BeehfQx(parent, _O3nUtiD0MLBxXQxpZteEn2, initialState, onToggle)
    local _1C3iD9ZFlk3msqh7w0gcSv = Instance.new("Frame")
    _1C3iD9ZFlk3msqh7w0gcSv.Name = _O3nUtiD0MLBxXQxpZteEn2:gsub("%s+", "") .. "Option"
    _1C3iD9ZFlk3msqh7w0gcSv.Size = UDim2.new(1, 0, 0, 50)
    _1C3iD9ZFlk3msqh7w0gcSv.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _1C3iD9ZFlk3msqh7w0gcSv.BorderSizePixel = 0
    _1C3iD9ZFlk3msqh7w0gcSv.Parent = parent
    local _6CPV0sbsq77Y10Ve9WPVRs = Instance.new("UICorner")
    _6CPV0sbsq77Y10Ve9WPVRs.CornerRadius = UDim.new(0, 8)
    _6CPV0sbsq77Y10Ve9WPVRs.Parent = _1C3iD9ZFlk3msqh7w0gcSv
    local _7TZ73K9TvlcDwHnUzH8pZy = Instance.new("UIStroke")
    _7TZ73K9TvlcDwHnUzH8pZy.Color = Color3.fromRGB(60, 60, 60)
    _7TZ73K9TvlcDwHnUzH8pZy.Thickness = 1
    _7TZ73K9TvlcDwHnUzH8pZy.Transparency = 0.4
    _7TZ73K9TvlcDwHnUzH8pZy.Parent = _1C3iD9ZFlk3msqh7w0gcSv
    local _EchJ1qx18nbrWMRHTJcMGF = Instance.new("TextLabel")
    _EchJ1qx18nbrWMRHTJcMGF.Name = "Label"
    _EchJ1qx18nbrWMRHTJcMGF.Size = UDim2.new(1, -80, 1, 0)
    _EchJ1qx18nbrWMRHTJcMGF.Position = UDim2.new(0, 10, 0, 0)
    _EchJ1qx18nbrWMRHTJcMGF.BackgroundTransparency = 1
    _EchJ1qx18nbrWMRHTJcMGF.Text = _O3nUtiD0MLBxXQxpZteEn2
    _EchJ1qx18nbrWMRHTJcMGF.TextColor3 = Color3.fromRGB(255, 255, 255)
    _EchJ1qx18nbrWMRHTJcMGF.TextSize = 14
    _EchJ1qx18nbrWMRHTJcMGF.Font = Enum.Font.GothamBold
    _EchJ1qx18nbrWMRHTJcMGF.TextXAlignment = Enum.TextXAlignment.Left
    _EchJ1qx18nbrWMRHTJcMGF.TextTruncate = Enum.TextTruncate.AtEnd
    _EchJ1qx18nbrWMRHTJcMGF.Parent = _1C3iD9ZFlk3msqh7w0gcSv
    local _G2tAf8Nnx7Vo9z4QKiljlf = Instance.new("TextButton")
    _G2tAf8Nnx7Vo9z4QKiljlf.Name = "Toggle"
    _G2tAf8Nnx7Vo9z4QKiljlf.Size = UDim2.new(0, 60, 0, 26)
    _G2tAf8Nnx7Vo9z4QKiljlf.Position = UDim2.new(1, -70, 0.5, -13)
    _G2tAf8Nnx7Vo9z4QKiljlf.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _G2tAf8Nnx7Vo9z4QKiljlf.TextColor3 = Color3.fromRGB(220, 220, 220)
    _G2tAf8Nnx7Vo9z4QKiljlf.TextSize = 12
    _G2tAf8Nnx7Vo9z4QKiljlf.Font = Enum.Font.GothamBold
    _G2tAf8Nnx7Vo9z4QKiljlf.BorderSizePixel = 0
    _G2tAf8Nnx7Vo9z4QKiljlf.Parent = _1C3iD9ZFlk3msqh7w0gcSv
    local _f2dYDherQcdYdEmEXepGV8 = Instance.new("UICorner")
    _f2dYDherQcdYdEmEXepGV8.CornerRadius = UDim.new(0, 6)
    _f2dYDherQcdYdEmEXepGV8.Parent = _G2tAf8Nnx7Vo9z4QKiljlf
    local _kSORWOElEDHqZuOvY6slqz = Instance.new("UIStroke")
    _kSORWOElEDHqZuOvY6slqz.Color = Color3.fromRGB(60, 60, 60)
    _kSORWOElEDHqZuOvY6slqz.Thickness = 1
    _kSORWOElEDHqZuOvY6slqz.Transparency = 0.3
    _kSORWOElEDHqZuOvY6slqz.Parent = _G2tAf8Nnx7Vo9z4QKiljlf
    local _0YlfhXN5VNK78DBXRoFHDA = initialState
    local function _qN6p9OQMUUt9GvrJK7kZVW()
        _G2tAf8Nnx7Vo9z4QKiljlf.Text = _0YlfhXN5VNK78DBXRoFHDA and "ON" or "OFF"
        _G2tAf8Nnx7Vo9z4QKiljlf.BackgroundColor3 = _0YlfhXN5VNK78DBXRoFHDA and Color3.fromRGB(70, 150, 90) or Color3.fromRGB(90, 90, 90)
    end
    _G2tAf8Nnx7Vo9z4QKiljlf.MouseEnter:Connect(function()
        if _0YlfhXN5VNK78DBXRoFHDA then
            _G2tAf8Nnx7Vo9z4QKiljlf.BackgroundColor3 = Color3.fromRGB(80, 170, 100)
        else
            _G2tAf8Nnx7Vo9z4QKiljlf.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end
    end)
    _G2tAf8Nnx7Vo9z4QKiljlf.MouseLeave:Connect(function()
        _qN6p9OQMUUt9GvrJK7kZVW()
    end)
    _1C3iD9ZFlk3msqh7w0gcSv.MouseEnter:Connect(function()
        _1C3iD9ZFlk3msqh7w0gcSv.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    _1C3iD9ZFlk3msqh7w0gcSv.MouseLeave:Connect(function()
        _1C3iD9ZFlk3msqh7w0gcSv.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)
    _G2tAf8Nnx7Vo9z4QKiljlf.MouseButton1Click:Connect(function()
        _0YlfhXN5VNK78DBXRoFHDA = not _0YlfhXN5VNK78DBXRoFHDA
        _qN6p9OQMUUt9GvrJK7kZVW()
        onToggle(_0YlfhXN5VNK78DBXRoFHDA)
    end)
    _qN6p9OQMUUt9GvrJK7kZVW()
    return _G2tAf8Nnx7Vo9z4QKiljlf, function(newState)
        _0YlfhXN5VNK78DBXRoFHDA = newState
        _qN6p9OQMUUt9GvrJK7kZVW()
    end
end
local function _x3WFJxFCKVMB0ge3wiS8yY(parent, _O3nUtiD0MLBxXQxpZteEn2, minValue, maxValue, initialValue, onValueChanged)
    local _8uS2G3zGTagGWD2GPci0xU = Instance.new("Frame")
    _8uS2G3zGTagGWD2GPci0xU.Name = "SliderOption"
    _8uS2G3zGTagGWD2GPci0xU.Size = UDim2.new(1, 0, 0, 60)
    _8uS2G3zGTagGWD2GPci0xU.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _8uS2G3zGTagGWD2GPci0xU.BorderSizePixel = 0
    _8uS2G3zGTagGWD2GPci0xU.Parent = parent
    local _FOSdZTBaK5piJSPiKhmyri = Instance.new("UICorner")
    _FOSdZTBaK5piJSPiKhmyri.CornerRadius = UDim.new(0, 8)
    _FOSdZTBaK5piJSPiKhmyri.Parent = _8uS2G3zGTagGWD2GPci0xU
    local _cEAMLBwjQ8y9EXmJIZnGoB = Instance.new("UIStroke")
    _cEAMLBwjQ8y9EXmJIZnGoB.Color = Color3.fromRGB(60, 60, 60)
    _cEAMLBwjQ8y9EXmJIZnGoB.Thickness = 1
    _cEAMLBwjQ8y9EXmJIZnGoB.Transparency = 0.4
    _cEAMLBwjQ8y9EXmJIZnGoB.Parent = _8uS2G3zGTagGWD2GPci0xU
    local _EchJ1qx18nbrWMRHTJcMGF = Instance.new("TextLabel")
    _EchJ1qx18nbrWMRHTJcMGF.Name = "Label"
    _EchJ1qx18nbrWMRHTJcMGF.Size = UDim2.new(1, -20, 0, 20)
    _EchJ1qx18nbrWMRHTJcMGF.Position = UDim2.new(0, 10, 0, 5)
    _EchJ1qx18nbrWMRHTJcMGF.BackgroundTransparency = 1
    _EchJ1qx18nbrWMRHTJcMGF.Text = _O3nUtiD0MLBxXQxpZteEn2
    _EchJ1qx18nbrWMRHTJcMGF.TextColor3 = Color3.fromRGB(255, 255, 255)
    _EchJ1qx18nbrWMRHTJcMGF.TextSize = 14
    _EchJ1qx18nbrWMRHTJcMGF.Font = Enum.Font.GothamBold
    _EchJ1qx18nbrWMRHTJcMGF.TextXAlignment = Enum.TextXAlignment.Left
    _EchJ1qx18nbrWMRHTJcMGF.Parent = _8uS2G3zGTagGWD2GPci0xU
    local _YOxG8oUKeShnXhc3dvTJQF = Instance.new("TextLabel")
    _YOxG8oUKeShnXhc3dvTJQF.Name = "ValueLabel"
    _YOxG8oUKeShnXhc3dvTJQF.Size = UDim2.new(0, 50, 0, 20)
    _YOxG8oUKeShnXhc3dvTJQF.Position = UDim2.new(1, -60, 0, 5)
    _YOxG8oUKeShnXhc3dvTJQF.BackgroundTransparency = 1
    _YOxG8oUKeShnXhc3dvTJQF.Text = tostring(math.floor(initialValue))
    _YOxG8oUKeShnXhc3dvTJQF.TextColor3 = Color3.fromRGB(200, 200, 200)
    _YOxG8oUKeShnXhc3dvTJQF.TextSize = 14
    _YOxG8oUKeShnXhc3dvTJQF.Font = Enum.Font.GothamBold
    _YOxG8oUKeShnXhc3dvTJQF.TextXAlignment = Enum.TextXAlignment.Right
    _YOxG8oUKeShnXhc3dvTJQF.Parent = _8uS2G3zGTagGWD2GPci0xU
    local _5GTukj9SiR97ZFi2dGRfkt = Instance.new("Frame")
    _5GTukj9SiR97ZFi2dGRfkt.Name = "SliderContainer"
    _5GTukj9SiR97ZFi2dGRfkt.Size = UDim2.new(1, -20, 0, 20)
    _5GTukj9SiR97ZFi2dGRfkt.Position = UDim2.new(0, 10, 0, 30)
    _5GTukj9SiR97ZFi2dGRfkt.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    _5GTukj9SiR97ZFi2dGRfkt.BorderSizePixel = 0
    _5GTukj9SiR97ZFi2dGRfkt.Parent = _8uS2G3zGTagGWD2GPci0xU
    local _tgXJBeKK45nJe5bZNu8bpk = Instance.new("UICorner")
    _tgXJBeKK45nJe5bZNu8bpk.CornerRadius = UDim.new(0, 4)
    _tgXJBeKK45nJe5bZNu8bpk.Parent = _5GTukj9SiR97ZFi2dGRfkt
    local _GTBPFf0N4xLyEM6LCXtgE2 = Instance.new("Frame")
    _GTBPFf0N4xLyEM6LCXtgE2.Name = "Track"
    _GTBPFf0N4xLyEM6LCXtgE2.Size = UDim2.new(1, -4, 1, -4)
    _GTBPFf0N4xLyEM6LCXtgE2.Position = UDim2.new(0, 2, 0, 2)
    _GTBPFf0N4xLyEM6LCXtgE2.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _GTBPFf0N4xLyEM6LCXtgE2.BorderSizePixel = 0
    _GTBPFf0N4xLyEM6LCXtgE2.Parent = _5GTukj9SiR97ZFi2dGRfkt
    local _QVpFVGxad4SZ4e6OXda45S = Instance.new("UICorner")
    _QVpFVGxad4SZ4e6OXda45S.CornerRadius = UDim.new(0, 4)
    _QVpFVGxad4SZ4e6OXda45S.Parent = _GTBPFf0N4xLyEM6LCXtgE2
    local _4Ca8Q0mD5BrMdJL9SlIXAn = Instance.new("Frame")
    _4Ca8Q0mD5BrMdJL9SlIXAn.Name = "Fill"
    _4Ca8Q0mD5BrMdJL9SlIXAn.Size = UDim2.new(0, 0, 1, 0)
    _4Ca8Q0mD5BrMdJL9SlIXAn.Position = UDim2.new(0, 0, 0, 0)
    _4Ca8Q0mD5BrMdJL9SlIXAn.BackgroundColor3 = Color3.fromRGB(70, 150, 90)
    _4Ca8Q0mD5BrMdJL9SlIXAn.BorderSizePixel = 0
    _4Ca8Q0mD5BrMdJL9SlIXAn.Parent = _GTBPFf0N4xLyEM6LCXtgE2
    local _erUpaFLxgEDFLipKW7qO3N = Instance.new("UICorner")
    _erUpaFLxgEDFLipKW7qO3N.CornerRadius = UDim.new(0, 4)
    _erUpaFLxgEDFLipKW7qO3N.Parent = _4Ca8Q0mD5BrMdJL9SlIXAn
    local _zJR8C6u5fGNBddDuA7smqg = Instance.new("TextButton")
    _zJR8C6u5fGNBddDuA7smqg.Name = "Button"
    _zJR8C6u5fGNBddDuA7smqg.Size = UDim2.new(0, 12, 0, 12)
    _zJR8C6u5fGNBddDuA7smqg.Position = UDim2.new(0, -6, 0.5, -6)
    _zJR8C6u5fGNBddDuA7smqg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    _zJR8C6u5fGNBddDuA7smqg.Text = ""
    _zJR8C6u5fGNBddDuA7smqg.BorderSizePixel = 0
    _zJR8C6u5fGNBddDuA7smqg.Parent = _GTBPFf0N4xLyEM6LCXtgE2
    local _FM4QYqt1MrOTUbOiexjEYq = Instance.new("UICorner")
    _FM4QYqt1MrOTUbOiexjEYq.CornerRadius = UDim.new(0, 6)
    _FM4QYqt1MrOTUbOiexjEYq.Parent = _zJR8C6u5fGNBddDuA7smqg
    local _LK4dPL0s9cwavpbH9WCbG0 = initialValue
    local _vM8SKfkpL3Qtk7IxgjCASH = false
    local function _mE64jbtTfPkWBjeVTPCiz7(value)
        _LK4dPL0s9cwavpbH9WCbG0 = math.clamp(value, minValue, maxValue)
        local _jQb4qrvhxiPozqCtRV9e9b = (_LK4dPL0s9cwavpbH9WCbG0 - minValue) / (maxValue - minValue)
        _4Ca8Q0mD5BrMdJL9SlIXAn.Size = UDim2.new(_jQb4qrvhxiPozqCtRV9e9b, 0, 1, 0)
        _zJR8C6u5fGNBddDuA7smqg.Position = UDim2.new(_jQb4qrvhxiPozqCtRV9e9b, -6, 0.5, -6)
        _YOxG8oUKeShnXhc3dvTJQF.Text = tostring(math.floor(_LK4dPL0s9cwavpbH9WCbG0))
        onValueChanged(_LK4dPL0s9cwavpbH9WCbG0)
    end
    local function _AMtX1IkuTchJU3xk5YLeTY(x)
        local _Ww7uHC8pt8oxBJvRABHmh8 = _GTBPFf0N4xLyEM6LCXtgE2.AbsoluteSize.X
        local _WwOEWhCelxVL3R5sUSiAs4 = math.clamp(x - _GTBPFf0N4xLyEM6LCXtgE2.AbsolutePosition.X, 0, _Ww7uHC8pt8oxBJvRABHmh8)
        local _jQb4qrvhxiPozqCtRV9e9b = _WwOEWhCelxVL3R5sUSiAs4 / _Ww7uHC8pt8oxBJvRABHmh8
        return minValue + (maxValue - minValue) * _jQb4qrvhxiPozqCtRV9e9b
    end
    local _SicrsXyAYhb5r1OWaDtKVV = nil
    local _DyV8pgTtkbOJY8eXrsv54M = nil
    local function _QwOn6ey4mek28ogMzIvRxz()
        _vM8SKfkpL3Qtk7IxgjCASH = true
        if _DyV8pgTtkbOJY8eXrsv54M then
            _DyV8pgTtkbOJY8eXrsv54M:Disconnect()
        end
        _DyV8pgTtkbOJY8eXrsv54M = RunService.Heartbeat:Connect(function()
            if _vM8SKfkpL3Qtk7IxgjCASH then
                local _e6Aof99neVIlCARlsKEy3g = UserInputService:GetMouseLocation()
                local _kq5ngxlVoJIhthEsdEtAah = _AMtX1IkuTchJU3xk5YLeTY(_e6Aof99neVIlCARlsKEy3g.X)
                _mE64jbtTfPkWBjeVTPCiz7(_kq5ngxlVoJIhthEsdEtAah)
            end
        end)
    end
    local function _TD1zIMLSvu34jAKrQJ2IVZ()
        _vM8SKfkpL3Qtk7IxgjCASH = false
        if _DyV8pgTtkbOJY8eXrsv54M then
            _DyV8pgTtkbOJY8eXrsv54M:Disconnect()
            _DyV8pgTtkbOJY8eXrsv54M = nil
        end
    end
    _zJR8C6u5fGNBddDuA7smqg.MouseButton1Down:Connect(function()
        _QwOn6ey4mek28ogMzIvRxz()
    end)
    _SicrsXyAYhb5r1OWaDtKVV = UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            _TD1zIMLSvu34jAKrQJ2IVZ()
        end
    end)
    _GTBPFf0N4xLyEM6LCXtgE2.MouseButton1Down:Connect(function()
        _QwOn6ey4mek28ogMzIvRxz()
        local _e6Aof99neVIlCARlsKEy3g = UserInputService:GetMouseLocation()
        local _kq5ngxlVoJIhthEsdEtAah = _AMtX1IkuTchJU3xk5YLeTY(_e6Aof99neVIlCARlsKEy3g.X)
        _mE64jbtTfPkWBjeVTPCiz7(_kq5ngxlVoJIhthEsdEtAah)
    end)
    _8uS2G3zGTagGWD2GPci0xU.AncestryChanged:Connect(function()
        if not _8uS2G3zGTagGWD2GPci0xU.Parent then
            _TD1zIMLSvu34jAKrQJ2IVZ()
            if _SicrsXyAYhb5r1OWaDtKVV then
                _SicrsXyAYhb5r1OWaDtKVV:Disconnect()
            end
        end
    end)
    _8uS2G3zGTagGWD2GPci0xU.MouseEnter:Connect(function()
        _8uS2G3zGTagGWD2GPci0xU.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    _8uS2G3zGTagGWD2GPci0xU.MouseLeave:Connect(function()
        _8uS2G3zGTagGWD2GPci0xU.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)
    _mE64jbtTfPkWBjeVTPCiz7(initialValue)
end
local function _Y0bLFx5yN8UEhfghi2prQq()
    if not _S0syiCt3DB2qEki81fRzIy then
        warn("TipStatsGUI: _S0syiCt3DB2qEki81fRzIy not available for _7IJRE0NgInWp613Mc4YtlX panel")
        return
    end
    if _7Yivni1NNtGsbnBz6RLzYP and _7Yivni1NNtGsbnBz6RLzYP.Parent then
        _j05LmCQpEwjJiqluer1pL8()
        return
    end
    _7Yivni1NNtGsbnBz6RLzYP = Instance.new("Frame")
    _7Yivni1NNtGsbnBz6RLzYP.Name = "SettingsPanel"
    _7Yivni1NNtGsbnBz6RLzYP.Size = UDim2.new(0, 320, 0, 380)
    _7Yivni1NNtGsbnBz6RLzYP.AnchorPoint = Vector2.new(0, 0)
    _7Yivni1NNtGsbnBz6RLzYP.Position = UDim2.new(1, -340, 1, -400)
    _7Yivni1NNtGsbnBz6RLzYP.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    _7Yivni1NNtGsbnBz6RLzYP.BorderSizePixel = 0
    _7Yivni1NNtGsbnBz6RLzYP.Visible = true
    _7Yivni1NNtGsbnBz6RLzYP.Parent = _S0syiCt3DB2qEki81fRzIy
    _7Yivni1NNtGsbnBz6RLzYP.ZIndex = 60
    local _XQIJ8DAbNWOgsSyAU3kg5w = Instance.new("UICorner")
    _XQIJ8DAbNWOgsSyAU3kg5w.CornerRadius = UDim.new(0, 10)
    _XQIJ8DAbNWOgsSyAU3kg5w.Parent = _7Yivni1NNtGsbnBz6RLzYP
    local _VcI7zN2vk95awni5DRxl0u = Instance.new("UIStroke")
    _VcI7zN2vk95awni5DRxl0u.Color = Color3.fromRGB(60, 60, 60)
    _VcI7zN2vk95awni5DRxl0u.Thickness = 1
    _VcI7zN2vk95awni5DRxl0u.Transparency = 0.3
    _VcI7zN2vk95awni5DRxl0u.Parent = _7Yivni1NNtGsbnBz6RLzYP
    local _dhXr4gdbReUJWK3aDjPkLN = Instance.new("Frame")
    _dhXr4gdbReUJWK3aDjPkLN.Name = "TitleBar"
    _dhXr4gdbReUJWK3aDjPkLN.Size = UDim2.new(1, 0, 0, 45)
    _dhXr4gdbReUJWK3aDjPkLN.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    _dhXr4gdbReUJWK3aDjPkLN.BorderSizePixel = 0
    _dhXr4gdbReUJWK3aDjPkLN.Parent = _7Yivni1NNtGsbnBz6RLzYP
    local _C5ixIHSwzUN4DGaygGLVzt = Instance.new("UICorner")
    _C5ixIHSwzUN4DGaygGLVzt.CornerRadius = UDim.new(0, 10)
    _C5ixIHSwzUN4DGaygGLVzt.Parent = _dhXr4gdbReUJWK3aDjPkLN
    local _Z0yQgS2MyevPs3tQK19j8D = Instance.new("UIStroke")
    _Z0yQgS2MyevPs3tQK19j8D.Color = Color3.fromRGB(60, 60, 60)
    _Z0yQgS2MyevPs3tQK19j8D.Thickness = 1
    _Z0yQgS2MyevPs3tQK19j8D.Transparency = 0.3
    _Z0yQgS2MyevPs3tQK19j8D.Parent = _dhXr4gdbReUJWK3aDjPkLN
    local _VTM8afZnepYq2PvAN7gRpS = Instance.new("TextLabel")
    _VTM8afZnepYq2PvAN7gRpS.Name = "Title"
    _VTM8afZnepYq2PvAN7gRpS.Size = UDim2.new(1, -40, 1, 0)
    _VTM8afZnepYq2PvAN7gRpS.Position = UDim2.new(0, 15, 0, 0)
    _VTM8afZnepYq2PvAN7gRpS.BackgroundTransparency = 1
    _VTM8afZnepYq2PvAN7gRpS.Text = "Settings"
    _VTM8afZnepYq2PvAN7gRpS.TextColor3 = Color3.fromRGB(240, 240, 240)
    _VTM8afZnepYq2PvAN7gRpS.TextSize = 17
    _VTM8afZnepYq2PvAN7gRpS.Font = Enum.Font.GothamSemibold
    _VTM8afZnepYq2PvAN7gRpS.TextXAlignment = Enum.TextXAlignment.Left
    _VTM8afZnepYq2PvAN7gRpS.Parent = _dhXr4gdbReUJWK3aDjPkLN
    local _X5C38blBkPgUM5Fn5Fx5Bl = Instance.new("TextButton")
    _X5C38blBkPgUM5Fn5Fx5Bl.Name = "CloseButton"
    _X5C38blBkPgUM5Fn5Fx5Bl.Size = UDim2.new(0, 32, 0, 32)
    _X5C38blBkPgUM5Fn5Fx5Bl.Position = UDim2.new(1, -40, 0, 6.5)
    _X5C38blBkPgUM5Fn5Fx5Bl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _X5C38blBkPgUM5Fn5Fx5Bl.Text = "×"
    _X5C38blBkPgUM5Fn5Fx5Bl.TextColor3 = Color3.fromRGB(220, 220, 220)
    _X5C38blBkPgUM5Fn5Fx5Bl.TextSize = 18
    _X5C38blBkPgUM5Fn5Fx5Bl.Font = Enum.Font.GothamBold
    _X5C38blBkPgUM5Fn5Fx5Bl.BorderSizePixel = 0
    _X5C38blBkPgUM5Fn5Fx5Bl.Parent = _dhXr4gdbReUJWK3aDjPkLN
    local _ocRBolScezbONP82xsKrG5 = Instance.new("UICorner")
    _ocRBolScezbONP82xsKrG5.CornerRadius = UDim.new(0, 6)
    _ocRBolScezbONP82xsKrG5.Parent = _X5C38blBkPgUM5Fn5Fx5Bl
    _X5C38blBkPgUM5Fn5Fx5Bl.MouseEnter:Connect(function()
        _X5C38blBkPgUM5Fn5Fx5Bl.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    _X5C38blBkPgUM5Fn5Fx5Bl.MouseLeave:Connect(function()
        _X5C38blBkPgUM5Fn5Fx5Bl.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _X5C38blBkPgUM5Fn5Fx5Bl.MouseButton1Click:Connect(closeSettingsPanel)
    local _sdsMsiZWrhu1RsI7NONXIm = Instance.new("TextButton")
    _sdsMsiZWrhu1RsI7NONXIm.Name = "DragArea"
    _sdsMsiZWrhu1RsI7NONXIm.Size = UDim2.new(1, -50, 1, 0)
    _sdsMsiZWrhu1RsI7NONXIm.Position = UDim2.new(0, 0, 0, 0)
    _sdsMsiZWrhu1RsI7NONXIm.BackgroundTransparency = 1
    _sdsMsiZWrhu1RsI7NONXIm.Text = ""
    _sdsMsiZWrhu1RsI7NONXIm.BorderSizePixel = 0
    _sdsMsiZWrhu1RsI7NONXIm.ZIndex = 10
    _sdsMsiZWrhu1RsI7NONXIm.Parent = _dhXr4gdbReUJWK3aDjPkLN
    local _qQlQYz3JVIu1Lp0fFjg5Ok = Instance.new("ScrollingFrame")
    _qQlQYz3JVIu1Lp0fFjg5Ok.Name = "Options"
    _qQlQYz3JVIu1Lp0fFjg5Ok.Size = UDim2.new(1, -20, 1, -79)
    _qQlQYz3JVIu1Lp0fFjg5Ok.Position = UDim2.new(0, 10, 0, 59)
    _qQlQYz3JVIu1Lp0fFjg5Ok.BackgroundTransparency = 1
    _qQlQYz3JVIu1Lp0fFjg5Ok.BorderSizePixel = 0
    _qQlQYz3JVIu1Lp0fFjg5Ok.ScrollBarThickness = 6
    _qQlQYz3JVIu1Lp0fFjg5Ok.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    _qQlQYz3JVIu1Lp0fFjg5Ok.Parent = _7Yivni1NNtGsbnBz6RLzYP
    local _Mnuixmgf8GamV4K5y3PI4C = Instance.new("UIListLayout")
    _Mnuixmgf8GamV4K5y3PI4C.Padding = UDim.new(0, 8)
    _Mnuixmgf8GamV4K5y3PI4C.SortOrder = Enum.SortOrder.LayoutOrder
    _Mnuixmgf8GamV4K5y3PI4C.Parent = _qQlQYz3JVIu1Lp0fFjg5Ok
    local _LQQzNKmd8JaJRnflCBi58z = Instance.new("UIPadding")
    _LQQzNKmd8JaJRnflCBi58z.PaddingTop = UDim.new(0, 8)
    _LQQzNKmd8JaJRnflCBi58z.PaddingBottom = UDim.new(0, 8)
    _LQQzNKmd8JaJRnflCBi58z.PaddingLeft = UDim.new(0, 10)
    _LQQzNKmd8JaJRnflCBi58z.PaddingRight = UDim.new(0, 10)
    _LQQzNKmd8JaJRnflCBi58z.Parent = _qQlQYz3JVIu1Lp0fFjg5Ok
    _Mnuixmgf8GamV4K5y3PI4C:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _Mnuixmgf8GamV4K5y3PI4C.AbsoluteContentSize
        _qQlQYz3JVIu1Lp0fFjg5Ok.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    end)
    _DqOG6lOPqsEbFj2BeehfQx(_qQlQYz3JVIu1Lp0fFjg5Ok, "Show Location Hub Button", _dFoL2KYYKZmWE03gv5CfaU.showLocationHubButton, function(state)
        _dFoL2KYYKZmWE03gv5CfaU.showLocationHubButton = state
        _2H1AkfFPec8lMec571FQvn()
        _JfvnLGBwbI7NxDCEXIRtHd()
    end)
    _DqOG6lOPqsEbFj2BeehfQx(_qQlQYz3JVIu1Lp0fFjg5Ok, "Disable Alt + Right Click requirement", _dFoL2KYYKZmWE03gv5CfaU.disableAltRequirement, function(state)
        _dFoL2KYYKZmWE03gv5CfaU.disableAltRequirement = state
        _JfvnLGBwbI7NxDCEXIRtHd()
    end)
    _DqOG6lOPqsEbFj2BeehfQx(_qQlQYz3JVIu1Lp0fFjg5Ok, "Disable Hover Quick Info", _dFoL2KYYKZmWE03gv5CfaU.disableHoverInfo, function(state)
        _dFoL2KYYKZmWE03gv5CfaU.disableHoverInfo = state
        if state then
            _LPzLpdkYAaIFIfsio0gCsu(nil)
        end
        _JfvnLGBwbI7NxDCEXIRtHd()
    end)
    _DqOG6lOPqsEbFj2BeehfQx(_qQlQYz3JVIu1Lp0fFjg5Ok, "Disable Hover Outline", _dFoL2KYYKZmWE03gv5CfaU.disableHoverOutline, function(state)
        _dFoL2KYYKZmWE03gv5CfaU.disableHoverOutline = state
        if state then
            _vVUgrstHNwmEHNOj4SErtE()
        elseif _KyudF1wlqenY1Uo94R3Tmd then
            _sZOt19lBJPz4C4RcXm1ft3(_KyudF1wlqenY1Uo94R3Tmd.Character)
        end
        _JfvnLGBwbI7NxDCEXIRtHd()
    end)
    _DqOG6lOPqsEbFj2BeehfQx(_qQlQYz3JVIu1Lp0fFjg5Ok, "Disable all Tip Jars", _dFoL2KYYKZmWE03gv5CfaU.hideAllTipJars, function(state)
        _dFoL2KYYKZmWE03gv5CfaU.hideAllTipJars = state
        _8IKAMP52MbI7fV6NZMC1bM()
        _JfvnLGBwbI7NxDCEXIRtHd()
    end)
    local hidePlayersToggleBtn, updateHidePlayersToggleFunc = _DqOG6lOPqsEbFj2BeehfQx(_qQlQYz3JVIu1Lp0fFjg5Ok, "Hide All Players", _re5qfWtmvctI7fWtq65VEu, function(state)
        if state ~= _re5qfWtmvctI7fWtq65VEu then
            _n3NPb7zD513M1vxzfSFhnP()
        end
    end)
    _AwNIDCDdlvicMgb2pYfsob = hidePlayersToggleBtn
    _n44enpU2lKHCXN6gKY6VeW = updateHidePlayersToggleFunc
    _x3WFJxFCKVMB0ge3wiS8yY(_qQlQYz3JVIu1Lp0fFjg5Ok, "Hover Range", 20, 100, math.max(20, math.min(100, _dFoL2KYYKZmWE03gv5CfaU.hoverRange or 20)), function(value)
        _dFoL2KYYKZmWE03gv5CfaU.hoverRange = value
        _JfvnLGBwbI7NxDCEXIRtHd()
    end)
    local _EHTKz5Y29c2uzaoBTAy0KV = Instance.new("Frame")
    _EHTKz5Y29c2uzaoBTAy0KV.Name = "HotkeyOption"
    _EHTKz5Y29c2uzaoBTAy0KV.Size = UDim2.new(1, 0, 0, 50)
    _EHTKz5Y29c2uzaoBTAy0KV.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _EHTKz5Y29c2uzaoBTAy0KV.BorderSizePixel = 0
    _EHTKz5Y29c2uzaoBTAy0KV.Parent = _qQlQYz3JVIu1Lp0fFjg5Ok
    local _kcnvv4qRTgXItN1QwJ1wSC = Instance.new("UICorner")
    _kcnvv4qRTgXItN1QwJ1wSC.CornerRadius = UDim.new(0, 8)
    _kcnvv4qRTgXItN1QwJ1wSC.Parent = _EHTKz5Y29c2uzaoBTAy0KV
    local _GpXkYQo35kvVduxNQfcaSY = Instance.new("UIStroke")
    _GpXkYQo35kvVduxNQfcaSY.Color = Color3.fromRGB(60, 60, 60)
    _GpXkYQo35kvVduxNQfcaSY.Thickness = 1
    _GpXkYQo35kvVduxNQfcaSY.Transparency = 0.4
    _GpXkYQo35kvVduxNQfcaSY.Parent = _EHTKz5Y29c2uzaoBTAy0KV
    local _TSi1Z9sOM08xrAlNMtPPd4 = Instance.new("TextLabel")
    _TSi1Z9sOM08xrAlNMtPPd4.Name = "Label"
    _TSi1Z9sOM08xrAlNMtPPd4.Size = UDim2.new(1, -80, 1, 0)
    _TSi1Z9sOM08xrAlNMtPPd4.Position = UDim2.new(0, 10, 0, 0)
    _TSi1Z9sOM08xrAlNMtPPd4.BackgroundTransparency = 1
    _TSi1Z9sOM08xrAlNMtPPd4.Text = "Toggle Hotkey"
    _TSi1Z9sOM08xrAlNMtPPd4.TextColor3 = Color3.fromRGB(255, 255, 255)
    _TSi1Z9sOM08xrAlNMtPPd4.TextSize = 14
    _TSi1Z9sOM08xrAlNMtPPd4.Font = Enum.Font.GothamBold
    _TSi1Z9sOM08xrAlNMtPPd4.TextXAlignment = Enum.TextXAlignment.Left
    _TSi1Z9sOM08xrAlNMtPPd4.Parent = _EHTKz5Y29c2uzaoBTAy0KV
    _6LB0HLV47jGLBY8iz9N6JF = Instance.new("TextButton")
    _6LB0HLV47jGLBY8iz9N6JF.Name = "HotkeyButton"
    _6LB0HLV47jGLBY8iz9N6JF.Size = UDim2.new(0, 60, 0, 26)
    _6LB0HLV47jGLBY8iz9N6JF.Position = UDim2.new(1, -70, 0.5, -13)
    _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _6LB0HLV47jGLBY8iz9N6JF.TextColor3 = Color3.fromRGB(220, 220, 220)
    _6LB0HLV47jGLBY8iz9N6JF.TextSize = 12
    _6LB0HLV47jGLBY8iz9N6JF.Font = Enum.Font.GothamBold
    _6LB0HLV47jGLBY8iz9N6JF.BorderSizePixel = 0
    _6LB0HLV47jGLBY8iz9N6JF.Parent = _EHTKz5Y29c2uzaoBTAy0KV
    local _WCL4KWWqbe9unMDLgkIRRu = Instance.new("UICorner")
    _WCL4KWWqbe9unMDLgkIRRu.CornerRadius = UDim.new(0, 6)
    _WCL4KWWqbe9unMDLgkIRRu.Parent = _6LB0HLV47jGLBY8iz9N6JF
    local _VyPhbTapHmx57vqZNd9GNP = Instance.new("UIStroke")
    _VyPhbTapHmx57vqZNd9GNP.Color = Color3.fromRGB(60, 60, 60)
    _VyPhbTapHmx57vqZNd9GNP.Thickness = 1
    _VyPhbTapHmx57vqZNd9GNP.Transparency = 0.3
    _VyPhbTapHmx57vqZNd9GNP.Parent = _6LB0HLV47jGLBY8iz9N6JF
    local function _Svia7aVA4iIFKek2zwQj6W()
        if _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode then
            _6LB0HLV47jGLBY8iz9N6JF.Text = _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode.Name
        else
            _6LB0HLV47jGLBY8iz9N6JF.Text = "None"
        end
    end
    _Svia7aVA4iIFKek2zwQj6W()
    _6LB0HLV47jGLBY8iz9N6JF.MouseEnter:Connect(function()
        _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    _6LB0HLV47jGLBY8iz9N6JF.MouseLeave:Connect(function()
        if not _VJRJQ2QO7FYqgIdmF26RB1 then
            _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end
    end)
    _EHTKz5Y29c2uzaoBTAy0KV.MouseEnter:Connect(function()
        _EHTKz5Y29c2uzaoBTAy0KV.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    _EHTKz5Y29c2uzaoBTAy0KV.MouseLeave:Connect(function()
        _EHTKz5Y29c2uzaoBTAy0KV.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end)
    _6LB0HLV47jGLBY8iz9N6JF.MouseButton1Click:Connect(function()
        if _LPdwPyN85X3NQKiV2nKbdR then
            _LPdwPyN85X3NQKiV2nKbdR:Disconnect()
            _LPdwPyN85X3NQKiV2nKbdR = nil
        end
        _VJRJQ2QO7FYqgIdmF26RB1 = true
        _6LB0HLV47jGLBY8iz9N6JF.Text = "Press key..."
        _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        print("TipStatsGUI: Waiting for key press...")
        _LPdwPyN85X3NQKiV2nKbdR = UserInputService.InputBegan:Connect(function(input, processed)
            if not _IwkVsc23fgHnJGQ9AHaXHj then
                return
            end
            if not _VJRJQ2QO7FYqgIdmF26RB1 then
                if _LPdwPyN85X3NQKiV2nKbdR then
                    _LPdwPyN85X3NQKiV2nKbdR:Disconnect()
                    _LPdwPyN85X3NQKiV2nKbdR = nil
                end
                return
            end
            if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode then
                if input.KeyCode == Enum.KeyCode.Escape then
                    _VJRJQ2QO7FYqgIdmF26RB1 = false
                    if _6LB0HLV47jGLBY8iz9N6JF then
                        local function _Svia7aVA4iIFKek2zwQj6W()
                            if _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode then
                                _6LB0HLV47jGLBY8iz9N6JF.Text = _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode.Name
                            else
                                _6LB0HLV47jGLBY8iz9N6JF.Text = "None"
                            end
                        end
                        _Svia7aVA4iIFKek2zwQj6W()
                        _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    print("TipStatsGUI: Hotkey listening cancelled (Escape)")
                    if _LPdwPyN85X3NQKiV2nKbdR then
                        _LPdwPyN85X3NQKiV2nKbdR:Disconnect()
                        _LPdwPyN85X3NQKiV2nKbdR = nil
                    end
                    return
                end
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode = input.KeyCode
                    _VJRJQ2QO7FYqgIdmF26RB1 = false
                    if _6LB0HLV47jGLBY8iz9N6JF then
                        _6LB0HLV47jGLBY8iz9N6JF.Text = input.KeyCode.Name
                        _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    print("TipStatsGUI: Hotkey set to", input.KeyCode.Name)
                    _JfvnLGBwbI7NxDCEXIRtHd()
                    if _LPdwPyN85X3NQKiV2nKbdR then
                        _LPdwPyN85X3NQKiV2nKbdR:Disconnect()
                        _LPdwPyN85X3NQKiV2nKbdR = nil
                    end
                    return
                end
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
                _VJRJQ2QO7FYqgIdmF26RB1 = false
                if _6LB0HLV47jGLBY8iz9N6JF then
                    local function _Svia7aVA4iIFKek2zwQj6W()
                        if _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode then
                            _6LB0HLV47jGLBY8iz9N6JF.Text = _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode.Name
                        else
                            _6LB0HLV47jGLBY8iz9N6JF.Text = "None"
                        end
                    end
                    _Svia7aVA4iIFKek2zwQj6W()
                    _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                end
                print("TipStatsGUI: Hotkey listening cancelled (mouse click)")
                if _LPdwPyN85X3NQKiV2nKbdR then
                    _LPdwPyN85X3NQKiV2nKbdR:Disconnect()
                    _LPdwPyN85X3NQKiV2nKbdR = nil
                end
            end
        end)
    end)
    task.wait(0.2)
    local _TsvDvT7RrfM9UEsk7Xq1XT = _Mnuixmgf8GamV4K5y3PI4C.AbsoluteContentSize
    _qQlQYz3JVIu1Lp0fFjg5Ok.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 20)
    _Mnuixmgf8GamV4K5y3PI4C:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local _jTCDllLIw4ysTAcQqwVPjA = _Mnuixmgf8GamV4K5y3PI4C.AbsoluteContentSize
        _qQlQYz3JVIu1Lp0fFjg5Ok.CanvasSize = UDim2.new(0, 0, 0, _jTCDllLIw4ysTAcQqwVPjA.Y + 20)
    end)
    local _GkGEedTflBevgZmdgw2MbK = false
    local _pNdKJ9oWGteGW9Jw9yhrIB = nil
    local _r9A77uoKiwz7rJXTOqa1Dp = nil
    local _eWknKEXdT2kQz0iOGX3jZZ = nil
    local function _hlkZZ67lV7p4rXxb53a6qg(input)
        local _ikNbaE6PwOMFvl5KoERaUq = input.Position - _r9A77uoKiwz7rJXTOqa1Dp
        _7Yivni1NNtGsbnBz6RLzYP.Position = UDim2.new(
            _eWknKEXdT2kQz0iOGX3jZZ.X.Scale,
            _eWknKEXdT2kQz0iOGX3jZZ.X.Offset + _ikNbaE6PwOMFvl5KoERaUq.X,
            _eWknKEXdT2kQz0iOGX3jZZ.Y.Scale,
            _eWknKEXdT2kQz0iOGX3jZZ.Y.Offset + _ikNbaE6PwOMFvl5KoERaUq.Y
        )
    end
    _sdsMsiZWrhu1RsI7NONXIm.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            _GkGEedTflBevgZmdgw2MbK = true
            _r9A77uoKiwz7rJXTOqa1Dp = input.Position
            _eWknKEXdT2kQz0iOGX3jZZ = _7Yivni1NNtGsbnBz6RLzYP.Position
            local _WU87BkEmPu7K64NkJ8cEzd
            _WU87BkEmPu7K64NkJ8cEzd = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    _GkGEedTflBevgZmdgw2MbK = false
                    if _WU87BkEmPu7K64NkJ8cEzd then
                        _WU87BkEmPu7K64NkJ8cEzd:Disconnect()
                    end
                end
            end)
        end
    end)
    _sdsMsiZWrhu1RsI7NONXIm.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            _pNdKJ9oWGteGW9Jw9yhrIB = input
        end
    end)
    if _HNR32FEPO0sAUcLjOHVmNY then
        _HNR32FEPO0sAUcLjOHVmNY:Disconnect()
        _HNR32FEPO0sAUcLjOHVmNY = nil
    end
    _HNR32FEPO0sAUcLjOHVmNY = UserInputService.InputChanged:Connect(function(input)
        if input == _pNdKJ9oWGteGW9Jw9yhrIB and _GkGEedTflBevgZmdgw2MbK then
            _hlkZZ67lV7p4rXxb53a6qg(input)
        end
    end)
end
_FJLzTE4exYHe5prmCXFjxr.MouseButton1Click:Connect(function()
    pcall(function()
        _Y0bLFx5yN8UEhfghi2prQq()
    end)
end)
local function _H6Y02m6nFzEOuTtFwBStUf()
    if _SxuSZaRjCjH38WIgQCltk9 then
        _PBgzLW9WTf6RJ7lLFrx70e = _SxuSZaRjCjH38WIgQCltk9.Position
        _SxuSZaRjCjH38WIgQCltk9:Destroy()
        _SxuSZaRjCjH38WIgQCltk9 = nil
        return
    end
    _SxuSZaRjCjH38WIgQCltk9 = Instance.new("Frame")
    _SxuSZaRjCjH38WIgQCltk9.Name = "LocationHub"
    _SxuSZaRjCjH38WIgQCltk9.Size = UDim2.new(0, 400, 0, 500)
    _SxuSZaRjCjH38WIgQCltk9.Position = _PBgzLW9WTf6RJ7lLFrx70e or UDim2.new(0.5, -200, 0.5, -250)
    _SxuSZaRjCjH38WIgQCltk9.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    _SxuSZaRjCjH38WIgQCltk9.BorderSizePixel = 0
    _SxuSZaRjCjH38WIgQCltk9.Parent = _S0syiCt3DB2qEki81fRzIy
    _SxuSZaRjCjH38WIgQCltk9.ZIndex = 15
    local _dycUYu6KZwZ2Zh9OqRQLeP = Instance.new("UICorner")
    _dycUYu6KZwZ2Zh9OqRQLeP.CornerRadius = UDim.new(0, 10)
    _dycUYu6KZwZ2Zh9OqRQLeP.Parent = _SxuSZaRjCjH38WIgQCltk9
    local _4oV7HjfS27oZVnRa1sdZc8 = Instance.new("UIStroke")
    _4oV7HjfS27oZVnRa1sdZc8.Color = Color3.fromRGB(60, 60, 60)
    _4oV7HjfS27oZVnRa1sdZc8.Thickness = 1
    _4oV7HjfS27oZVnRa1sdZc8.Transparency = 0.4
    _4oV7HjfS27oZVnRa1sdZc8.Parent = _SxuSZaRjCjH38WIgQCltk9
    local _uninyp3EDlA531EvUqfi4n = Instance.new("Frame")
    _uninyp3EDlA531EvUqfi4n.Name = "TitleBar"
    _uninyp3EDlA531EvUqfi4n.Size = UDim2.new(1, 0, 0, 45)
    _uninyp3EDlA531EvUqfi4n.Position = UDim2.new(0, 0, 0, 0)
    _uninyp3EDlA531EvUqfi4n.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    _uninyp3EDlA531EvUqfi4n.BorderSizePixel = 0
    _uninyp3EDlA531EvUqfi4n.Parent = _SxuSZaRjCjH38WIgQCltk9
    local _jrCu5T5dqJeZ2pMO2qT50G = Instance.new("UICorner")
    _jrCu5T5dqJeZ2pMO2qT50G.CornerRadius = UDim.new(0, 10)
    _jrCu5T5dqJeZ2pMO2qT50G.Parent = _uninyp3EDlA531EvUqfi4n
    local _vxP7eGRyPlQgwunbD3d5b1 = Instance.new("UIStroke")
    _vxP7eGRyPlQgwunbD3d5b1.Color = Color3.fromRGB(60, 60, 60)
    _vxP7eGRyPlQgwunbD3d5b1.Thickness = 1
    _vxP7eGRyPlQgwunbD3d5b1.Transparency = 0.3
    _vxP7eGRyPlQgwunbD3d5b1.Parent = _uninyp3EDlA531EvUqfi4n
    local _TE8wCsIiUs8teGjmwHNFUi = Instance.new("TextLabel")
    _TE8wCsIiUs8teGjmwHNFUi.Name = "TitleText"
    _TE8wCsIiUs8teGjmwHNFUi.Size = UDim2.new(1, -20, 1, 0)
    _TE8wCsIiUs8teGjmwHNFUi.Position = UDim2.new(0, 15, 0, 0)
    _TE8wCsIiUs8teGjmwHNFUi.BackgroundTransparency = 1
    _TE8wCsIiUs8teGjmwHNFUi.Text = "Location Hub"
    _TE8wCsIiUs8teGjmwHNFUi.TextColor3 = Color3.fromRGB(240, 240, 240)
    _TE8wCsIiUs8teGjmwHNFUi.TextSize = 17
    _TE8wCsIiUs8teGjmwHNFUi.Font = Enum.Font.GothamSemibold
    _TE8wCsIiUs8teGjmwHNFUi.TextXAlignment = Enum.TextXAlignment.Left
    _TE8wCsIiUs8teGjmwHNFUi.Parent = _uninyp3EDlA531EvUqfi4n
    local _cL75sWBI0pwTWpK2BrmSXb = Instance.new("TextButton")
    _cL75sWBI0pwTWpK2BrmSXb.Name = "CloseButton"
    _cL75sWBI0pwTWpK2BrmSXb.Size = UDim2.new(0, 32, 0, 32)
    _cL75sWBI0pwTWpK2BrmSXb.Position = UDim2.new(1, -40, 0, 6.5)
    _cL75sWBI0pwTWpK2BrmSXb.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _cL75sWBI0pwTWpK2BrmSXb.Text = "×"
    _cL75sWBI0pwTWpK2BrmSXb.TextColor3 = Color3.fromRGB(220, 220, 220)
    _cL75sWBI0pwTWpK2BrmSXb.TextSize = 18
    _cL75sWBI0pwTWpK2BrmSXb.Font = Enum.Font.GothamBold
    _cL75sWBI0pwTWpK2BrmSXb.BorderSizePixel = 0
    _cL75sWBI0pwTWpK2BrmSXb.Parent = _uninyp3EDlA531EvUqfi4n
    local _nTrySsyBz8663psJRyLIA1 = Instance.new("UICorner")
    _nTrySsyBz8663psJRyLIA1.CornerRadius = UDim.new(0, 6)
    _nTrySsyBz8663psJRyLIA1.Parent = _cL75sWBI0pwTWpK2BrmSXb
    local _9kqn0eYVrUXPS0ZVHjpEY9 = Instance.new("UIStroke")
    _9kqn0eYVrUXPS0ZVHjpEY9.Color = Color3.fromRGB(60, 60, 60)
    _9kqn0eYVrUXPS0ZVHjpEY9.Thickness = 1
    _9kqn0eYVrUXPS0ZVHjpEY9.Transparency = 0.3
    _9kqn0eYVrUXPS0ZVHjpEY9.Parent = _cL75sWBI0pwTWpK2BrmSXb
    _cL75sWBI0pwTWpK2BrmSXb.MouseEnter:Connect(function()
        _cL75sWBI0pwTWpK2BrmSXb.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    _cL75sWBI0pwTWpK2BrmSXb.MouseLeave:Connect(function()
        _cL75sWBI0pwTWpK2BrmSXb.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _cL75sWBI0pwTWpK2BrmSXb.MouseButton1Click:Connect(function()
        if _SxuSZaRjCjH38WIgQCltk9 then
            _PBgzLW9WTf6RJ7lLFrx70e = _SxuSZaRjCjH38WIgQCltk9.Position
        end
        _SxuSZaRjCjH38WIgQCltk9:Destroy()
        _SxuSZaRjCjH38WIgQCltk9 = nil
    end)
    local _66kuPtb7UsLoyMrzfbpcBT = false
    local _BvjgSaalQs1l0V8YEsvO1j = nil
    local _WxP7FeLLare9Pem476idy4 = nil
    local _Gh5QDZkudmOOXuq0R4qJxI = nil
    local function _3Bjkohqw0G79MGZVWelRXB(input)
        if _66kuPtb7UsLoyMrzfbpcBT and _WxP7FeLLare9Pem476idy4 and _Gh5QDZkudmOOXuq0R4qJxI then
            local _ikNbaE6PwOMFvl5KoERaUq = input.Position - _WxP7FeLLare9Pem476idy4
            _SxuSZaRjCjH38WIgQCltk9.Position = UDim2.new(
                _Gh5QDZkudmOOXuq0R4qJxI.X.Scale, _Gh5QDZkudmOOXuq0R4qJxI.X.Offset + _ikNbaE6PwOMFvl5KoERaUq.X,
                _Gh5QDZkudmOOXuq0R4qJxI.Y.Scale, _Gh5QDZkudmOOXuq0R4qJxI.Y.Offset + _ikNbaE6PwOMFvl5KoERaUq.Y
            )
        end
    end
    _uninyp3EDlA531EvUqfi4n.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            _66kuPtb7UsLoyMrzfbpcBT = true
            _WxP7FeLLare9Pem476idy4 = input.Position
            _Gh5QDZkudmOOXuq0R4qJxI = _SxuSZaRjCjH38WIgQCltk9.Position
            local _WU87BkEmPu7K64NkJ8cEzd
            _WU87BkEmPu7K64NkJ8cEzd = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    _66kuPtb7UsLoyMrzfbpcBT = false
                    _BvjgSaalQs1l0V8YEsvO1j = nil
                    _WU87BkEmPu7K64NkJ8cEzd:Disconnect()
                end
            end)
        end
    end)
    _uninyp3EDlA531EvUqfi4n.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            _BvjgSaalQs1l0V8YEsvO1j = input
        end
    end)
    local _SicrsXyAYhb5r1OWaDtKVV
    _SicrsXyAYhb5r1OWaDtKVV = UserInputService.InputChanged:Connect(function(input)
        if _66kuPtb7UsLoyMrzfbpcBT and input == _BvjgSaalQs1l0V8YEsvO1j then
            _3Bjkohqw0G79MGZVWelRXB(input)
        end
    end)
    _SxuSZaRjCjH38WIgQCltk9.AncestryChanged:Connect(function()
        pcall(function()
            if _SxuSZaRjCjH38WIgQCltk9 and not _SxuSZaRjCjH38WIgQCltk9.Parent then
                if _SicrsXyAYhb5r1OWaDtKVV then
                    _SicrsXyAYhb5r1OWaDtKVV:Disconnect()
                end
            end
        end)
    end)
    local _NvXvFp7lPCcVNScKpDIyAE = Instance.new("ScrollingFrame")
    _NvXvFp7lPCcVNScKpDIyAE.Name = "Content"
    _NvXvFp7lPCcVNScKpDIyAE.Size = UDim2.new(1, -20, 1, -65)
    _NvXvFp7lPCcVNScKpDIyAE.Position = UDim2.new(0, 10, 0, 55)
    _NvXvFp7lPCcVNScKpDIyAE.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    _NvXvFp7lPCcVNScKpDIyAE.BorderSizePixel = 0
    _NvXvFp7lPCcVNScKpDIyAE.ScrollBarThickness = 6
    _NvXvFp7lPCcVNScKpDIyAE.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
    _NvXvFp7lPCcVNScKpDIyAE.Parent = _SxuSZaRjCjH38WIgQCltk9
    local _RjADZJJiLuNsG2IaWjDtov = Instance.new("UICorner")
    _RjADZJJiLuNsG2IaWjDtov.CornerRadius = UDim.new(0, 6)
    _RjADZJJiLuNsG2IaWjDtov.Parent = _NvXvFp7lPCcVNScKpDIyAE
    local _mZSCwkRPjlYtkmmRJGsaKT = Instance.new("UIListLayout")
    _mZSCwkRPjlYtkmmRJGsaKT.Padding = UDim.new(0, 4)
    _mZSCwkRPjlYtkmmRJGsaKT.SortOrder = Enum.SortOrder.LayoutOrder
    _mZSCwkRPjlYtkmmRJGsaKT.Parent = _NvXvFp7lPCcVNScKpDIyAE
    local _TlNqggqM2JEq5Pz3i2ZOGt = Instance.new("UIPadding")
    _TlNqggqM2JEq5Pz3i2ZOGt.PaddingTop = UDim.new(0, 5)
    _TlNqggqM2JEq5Pz3i2ZOGt.PaddingBottom = UDim.new(0, 5)
    _TlNqggqM2JEq5Pz3i2ZOGt.PaddingLeft = UDim.new(0, 0)
    _TlNqggqM2JEq5Pz3i2ZOGt.PaddingRight = UDim.new(0, 0)
    _TlNqggqM2JEq5Pz3i2ZOGt.Parent = _NvXvFp7lPCcVNScKpDIyAE
    local _DlMoEQBFcJZgJSTJdwEAvP = {
        {name = "Toilet hidden spot", position = Vector3.new(-401.484, -99.925, 382.643)},
        {name = "777", position = Vector3.new(-544.519, 5.501, -228.711)},
        {name = "Cave", position = Vector3.new(-477.880, -49.337, 283.521)},
        {name = "Piano", position = Vector3.new(-119.136, 8.733, -244.815)},
        {name = "Tower", position = Vector3.new(205.746, 291.924, -226.568)},
        {name = "Island", position = Vector3.new(415.040, 39.866, -19.076)},
        {name = "Deleted Spawn", position = Vector3.new(-96.276, 2614.579, 3177.841), deleted = true}
    }
    local function _EphX8vTmwXM6e3VvJc1MqH(locationData, index)
        local _HCS6qLV3SBei25O6r15Fcb = Instance.new("TextButton")
        _HCS6qLV3SBei25O6r15Fcb.Name = "Location" .. index
        _HCS6qLV3SBei25O6r15Fcb.Size = UDim2.new(1, 0, 0, 60)
        _HCS6qLV3SBei25O6r15Fcb.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        _HCS6qLV3SBei25O6r15Fcb.BorderSizePixel = 0
        _HCS6qLV3SBei25O6r15Fcb.Text = ""
        _HCS6qLV3SBei25O6r15Fcb.Parent = _NvXvFp7lPCcVNScKpDIyAE
        _HCS6qLV3SBei25O6r15Fcb.LayoutOrder = index
        local _FM4QYqt1MrOTUbOiexjEYq = Instance.new("UICorner")
        _FM4QYqt1MrOTUbOiexjEYq.CornerRadius = UDim.new(0, 8)
        _FM4QYqt1MrOTUbOiexjEYq.Parent = _HCS6qLV3SBei25O6r15Fcb
        local _Km2UUq6eFv6Xcy0XmfPuAF = Instance.new("UIStroke")
        _Km2UUq6eFv6Xcy0XmfPuAF.Color = Color3.fromRGB(60, 60, 60)
        _Km2UUq6eFv6Xcy0XmfPuAF.Thickness = 1
        _Km2UUq6eFv6Xcy0XmfPuAF.Transparency = 0.3
        _Km2UUq6eFv6Xcy0XmfPuAF.Parent = _HCS6qLV3SBei25O6r15Fcb
        local _02nR22gaiFHPUU8hl9HHNk = Instance.new("TextLabel")
        _02nR22gaiFHPUU8hl9HHNk.Name = "NameLabel"
        _02nR22gaiFHPUU8hl9HHNk.Size = UDim2.new(1, -110, 0, 22)
        _02nR22gaiFHPUU8hl9HHNk.Position = UDim2.new(0, 10, 0, 4)
        _02nR22gaiFHPUU8hl9HHNk.BackgroundTransparency = 1
        _02nR22gaiFHPUU8hl9HHNk.Text = locationData.name
        _02nR22gaiFHPUU8hl9HHNk.TextColor3 = Color3.fromRGB(255, 255, 255)
        _02nR22gaiFHPUU8hl9HHNk.TextSize = 15
        _02nR22gaiFHPUU8hl9HHNk.Font = Enum.Font.GothamBold
        _02nR22gaiFHPUU8hl9HHNk.TextXAlignment = Enum.TextXAlignment.Left
        _02nR22gaiFHPUU8hl9HHNk.TextTruncate = Enum.TextTruncate.AtEnd
        _02nR22gaiFHPUU8hl9HHNk.Parent = _HCS6qLV3SBei25O6r15Fcb
        local _zb65GjeIPVJSOF3DN2CSCT = Instance.new("TextLabel")
        _zb65GjeIPVJSOF3DN2CSCT.Name = "CoordsLabel"
        _zb65GjeIPVJSOF3DN2CSCT.Size = UDim2.new(1, -110, 0, 20)
        _zb65GjeIPVJSOF3DN2CSCT.Position = UDim2.new(0, 10, 0, 30)
        _zb65GjeIPVJSOF3DN2CSCT.BackgroundTransparency = 1
        _zb65GjeIPVJSOF3DN2CSCT.Text = string.format("X: %.2f, Y: %.2f, Z: %.2f", locationData.position.X, locationData.position.Y, locationData.position.Z)
        _zb65GjeIPVJSOF3DN2CSCT.TextColor3 = Color3.fromRGB(180, 180, 180)
        _zb65GjeIPVJSOF3DN2CSCT.TextSize = 12
        _zb65GjeIPVJSOF3DN2CSCT.Font = Enum.Font.Gotham
        _zb65GjeIPVJSOF3DN2CSCT.TextXAlignment = Enum.TextXAlignment.Left
        _zb65GjeIPVJSOF3DN2CSCT.Parent = _HCS6qLV3SBei25O6r15Fcb
        local _20xgpSS2GUS8VzcW7WZVcG = Instance.new("TextButton")
        _20xgpSS2GUS8VzcW7WZVcG.Name = "TeleportButton"
        _20xgpSS2GUS8VzcW7WZVcG.Size = UDim2.new(0, 22, 0, 22)
        _20xgpSS2GUS8VzcW7WZVcG.Position = UDim2.new(1, -32, 0, 4)
        _20xgpSS2GUS8VzcW7WZVcG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _20xgpSS2GUS8VzcW7WZVcG.TextColor3 = Color3.fromRGB(220, 220, 220)
        _20xgpSS2GUS8VzcW7WZVcG.Text = "→"
        _20xgpSS2GUS8VzcW7WZVcG.TextSize = 14
        _20xgpSS2GUS8VzcW7WZVcG.Font = Enum.Font.GothamBold
        _20xgpSS2GUS8VzcW7WZVcG.BorderSizePixel = 0
        _20xgpSS2GUS8VzcW7WZVcG.Parent = _HCS6qLV3SBei25O6r15Fcb
        local _lEw60oVuKkj217w2zMYPOT = Instance.new("UICorner")
        _lEw60oVuKkj217w2zMYPOT.CornerRadius = UDim.new(0, 4)
        _lEw60oVuKkj217w2zMYPOT.Parent = _20xgpSS2GUS8VzcW7WZVcG
        local _Bj8vHHgTxuwPjLOpJCTp6Q = Instance.new("UIStroke")
        _Bj8vHHgTxuwPjLOpJCTp6Q.Color = Color3.fromRGB(60, 60, 60)
        _Bj8vHHgTxuwPjLOpJCTp6Q.Thickness = 1
        _Bj8vHHgTxuwPjLOpJCTp6Q.Transparency = 0.3
        _Bj8vHHgTxuwPjLOpJCTp6Q.Parent = _20xgpSS2GUS8VzcW7WZVcG
        _20xgpSS2GUS8VzcW7WZVcG.MouseEnter:Connect(function()
            _20xgpSS2GUS8VzcW7WZVcG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
        _20xgpSS2GUS8VzcW7WZVcG.MouseLeave:Connect(function()
            _20xgpSS2GUS8VzcW7WZVcG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
        _20xgpSS2GUS8VzcW7WZVcG.MouseButton1Click:Connect(function()
            local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
            if not _KCbu2Au1vAJIFqOuBflYpF or not _KCbu2Au1vAJIFqOuBflYpF.Character then
                return
            end
            local _nKrEOvVfSDdgYSpSeX9Vhb = _RJjERYng8mXMJfhQnnCyT2(_KCbu2Au1vAJIFqOuBflYpF.Character)
            if _nKrEOvVfSDdgYSpSeX9Vhb then
                _nKrEOvVfSDdgYSpSeX9Vhb.CFrame = CFrame.new(locationData.position)
                print("Teleported to:", locationData.name, locationData.position)
                if _SxuSZaRjCjH38WIgQCltk9 then
                    _PBgzLW9WTf6RJ7lLFrx70e = _SxuSZaRjCjH38WIgQCltk9.Position
                end
                _SxuSZaRjCjH38WIgQCltk9:Destroy()
                _SxuSZaRjCjH38WIgQCltk9 = nil
        end
    end)
        _HCS6qLV3SBei25O6r15Fcb.MouseEnter:Connect(function()
            _HCS6qLV3SBei25O6r15Fcb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)
        _HCS6qLV3SBei25O6r15Fcb.MouseLeave:Connect(function()
            _HCS6qLV3SBei25O6r15Fcb.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end)
    end
    for i, locationData in ipairs(_DlMoEQBFcJZgJSTJdwEAvP) do
        _EphX8vTmwXM6e3VvJc1MqH(locationData, i)
    end
    _mZSCwkRPjlYtkmmRJGsaKT:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _mZSCwkRPjlYtkmmRJGsaKT.AbsoluteContentSize
        _NvXvFp7lPCcVNScKpDIyAE.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    end)
    task.wait()
    local _TsvDvT7RrfM9UEsk7Xq1XT = _mZSCwkRPjlYtkmmRJGsaKT.AbsoluteContentSize
    _NvXvFp7lPCcVNScKpDIyAE.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    local _8fntnU6fUc9hciR1BrJB4Z = _PBgzLW9WTf6RJ7lLFrx70e or UDim2.new(0.5, -200, 0.5, -250)
    _SxuSZaRjCjH38WIgQCltk9.Size = UDim2.new(0, 0, 0, 0)
    _SxuSZaRjCjH38WIgQCltk9.Position = UDim2.new(0.5, 0, 0.5, 0)
    _SxuSZaRjCjH38WIgQCltk9.BackgroundTransparency = 1
    local _3Dr7v7xMPhOi7Ip0oyTXar = TweenService:Create(
        _SxuSZaRjCjH38WIgQCltk9,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 400, 0, 500), Position = _8fntnU6fUc9hciR1BrJB4Z, BackgroundTransparency = 0}
    )
    _3Dr7v7xMPhOi7Ip0oyTXar:Play()
end
_PhMfrV9R2H6iT31hs2DeIF = Instance.new("TextButton")
_PhMfrV9R2H6iT31hs2DeIF.Name = "LocationHubButton"
_PhMfrV9R2H6iT31hs2DeIF.Size = UDim2.new(0, 50, 0, 50)
_PhMfrV9R2H6iT31hs2DeIF.AnchorPoint = Vector2.new(0, 1)
_PhMfrV9R2H6iT31hs2DeIF.Position = UDim2.new(0, 20, 1, -20)
_PhMfrV9R2H6iT31hs2DeIF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_PhMfrV9R2H6iT31hs2DeIF.Text = "◉"
_PhMfrV9R2H6iT31hs2DeIF.TextColor3 = Color3.fromRGB(220, 220, 220)
_PhMfrV9R2H6iT31hs2DeIF.TextSize = 24
_PhMfrV9R2H6iT31hs2DeIF.Font = Enum.Font.GothamBold
_PhMfrV9R2H6iT31hs2DeIF.BorderSizePixel = 0
_PhMfrV9R2H6iT31hs2DeIF.Parent = _S0syiCt3DB2qEki81fRzIy
_PhMfrV9R2H6iT31hs2DeIF.ZIndex = 20
local _65LyioSI8yrUKkOeMXvaJ7 = Instance.new("UICorner")
_65LyioSI8yrUKkOeMXvaJ7.CornerRadius = UDim.new(0, 8)
_65LyioSI8yrUKkOeMXvaJ7.Parent = _PhMfrV9R2H6iT31hs2DeIF
local _6vJaknK7VQea3NErnRouf1 = Instance.new("UIStroke")
_6vJaknK7VQea3NErnRouf1.Color = Color3.fromRGB(50, 50, 50)
_6vJaknK7VQea3NErnRouf1.Thickness = 2
_6vJaknK7VQea3NErnRouf1.Transparency = 0.3
_6vJaknK7VQea3NErnRouf1.Parent = _PhMfrV9R2H6iT31hs2DeIF
_PhMfrV9R2H6iT31hs2DeIF.MouseEnter:Connect(function()
    _PhMfrV9R2H6iT31hs2DeIF.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
_PhMfrV9R2H6iT31hs2DeIF.MouseLeave:Connect(function()
    _PhMfrV9R2H6iT31hs2DeIF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
_H8mOWlkdsZzqVD0T9SFm5G(_PhMfrV9R2H6iT31hs2DeIF, "Location Hub")
_PhMfrV9R2H6iT31hs2DeIF.MouseButton1Click:Connect(function()
    print("Location Hub button clicked")
    _H6Y02m6nFzEOuTtFwBStUf()
end)
local _2O0nArsovay1CWxl6uAfTJ = Instance.new("TextButton")
_2O0nArsovay1CWxl6uAfTJ.Name = "SearchButton"
_2O0nArsovay1CWxl6uAfTJ.Size = UDim2.new(0, 32, 0, 32)
_2O0nArsovay1CWxl6uAfTJ.Position = UDim2.new(1, -151, 0, 6.5)
_2O0nArsovay1CWxl6uAfTJ.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_2O0nArsovay1CWxl6uAfTJ.Text = "S"
_2O0nArsovay1CWxl6uAfTJ.TextColor3 = Color3.fromRGB(220, 220, 220)
_2O0nArsovay1CWxl6uAfTJ.TextSize = 16
_2O0nArsovay1CWxl6uAfTJ.Font = Enum.Font.GothamBold
_2O0nArsovay1CWxl6uAfTJ.BorderSizePixel = 0
_2O0nArsovay1CWxl6uAfTJ.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _tIHOj1w2kvrAmjILtyLSht = Instance.new("UICorner")
_tIHOj1w2kvrAmjILtyLSht.CornerRadius = UDim.new(0, 6)
_tIHOj1w2kvrAmjILtyLSht.Parent = _2O0nArsovay1CWxl6uAfTJ
_2O0nArsovay1CWxl6uAfTJ.MouseEnter:Connect(function()
    _2O0nArsovay1CWxl6uAfTJ.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
_2O0nArsovay1CWxl6uAfTJ.MouseLeave:Connect(function()
    _2O0nArsovay1CWxl6uAfTJ.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
_H8mOWlkdsZzqVD0T9SFm5G(_2O0nArsovay1CWxl6uAfTJ, "Search players")
local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
local _dx0PljZptJJQVhhAhCzzBe = Instance.new("ImageButton")
_dx0PljZptJJQVhhAhCzzBe.Name = "AvatarIcon"
_dx0PljZptJJQVhhAhCzzBe.Size = UDim2.new(0, 32, 0, 32)
_dx0PljZptJJQVhhAhCzzBe.Position = UDim2.new(1, -114, 0, 6.5)
_dx0PljZptJJQVhhAhCzzBe.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_dx0PljZptJJQVhhAhCzzBe.BorderSizePixel = 0
_dx0PljZptJJQVhhAhCzzBe.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. _KCbu2Au1vAJIFqOuBflYpF.UserId .. "&width=150&height=150&format=png"
_dx0PljZptJJQVhhAhCzzBe.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _7RASEp0Iq0RVTaiu1ox31S = Instance.new("UICorner")
_7RASEp0Iq0RVTaiu1ox31S.CornerRadius = UDim.new(0, 6)
_7RASEp0Iq0RVTaiu1ox31S.Parent = _dx0PljZptJJQVhhAhCzzBe
_dx0PljZptJJQVhhAhCzzBe.MouseEnter:Connect(function()
    _dx0PljZptJJQVhhAhCzzBe.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
_dx0PljZptJJQVhhAhCzzBe.MouseLeave:Connect(function()
    _dx0PljZptJJQVhhAhCzzBe.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
_H8mOWlkdsZzqVD0T9SFm5G(_dx0PljZptJJQVhhAhCzzBe, "View your stats")
local _CVlaVHjClWDwMEqa3BUP9M = Instance.new("TextButton")
_CVlaVHjClWDwMEqa3BUP9M.Name = "MinimizeButton"
_CVlaVHjClWDwMEqa3BUP9M.Size = UDim2.new(0, 32, 0, 32)
_CVlaVHjClWDwMEqa3BUP9M.Position = UDim2.new(1, -77, 0, 6.5)
_CVlaVHjClWDwMEqa3BUP9M.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_CVlaVHjClWDwMEqa3BUP9M.Text = "−"
_CVlaVHjClWDwMEqa3BUP9M.TextColor3 = Color3.fromRGB(220, 220, 220)
_CVlaVHjClWDwMEqa3BUP9M.TextSize = 18
_CVlaVHjClWDwMEqa3BUP9M.Font = Enum.Font.GothamBold
_CVlaVHjClWDwMEqa3BUP9M.BorderSizePixel = 0
_CVlaVHjClWDwMEqa3BUP9M.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _joEAxzzQgy5lhwd6b1Yk3J = Instance.new("UICorner")
_joEAxzzQgy5lhwd6b1Yk3J.CornerRadius = UDim.new(0, 6)
_joEAxzzQgy5lhwd6b1Yk3J.Parent = _CVlaVHjClWDwMEqa3BUP9M
_CVlaVHjClWDwMEqa3BUP9M.MouseEnter:Connect(function()
    _CVlaVHjClWDwMEqa3BUP9M.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
_CVlaVHjClWDwMEqa3BUP9M.MouseLeave:Connect(function()
    _CVlaVHjClWDwMEqa3BUP9M.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
_H8mOWlkdsZzqVD0T9SFm5G(_CVlaVHjClWDwMEqa3BUP9M, "Minimize")
local _G4SfCYLf9wy64ThKKWAeRg = Instance.new("TextButton")
_G4SfCYLf9wy64ThKKWAeRg.Name = "CloseButton"
_G4SfCYLf9wy64ThKKWAeRg.Size = UDim2.new(0, 32, 0, 32)
_G4SfCYLf9wy64ThKKWAeRg.Position = UDim2.new(1, -40, 0, 6.5)
_G4SfCYLf9wy64ThKKWAeRg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
_G4SfCYLf9wy64ThKKWAeRg.Text = "×"
_G4SfCYLf9wy64ThKKWAeRg.TextColor3 = Color3.fromRGB(220, 220, 220)
_G4SfCYLf9wy64ThKKWAeRg.TextSize = 18
_G4SfCYLf9wy64ThKKWAeRg.Font = Enum.Font.GothamBold
_G4SfCYLf9wy64ThKKWAeRg.BorderSizePixel = 0
_G4SfCYLf9wy64ThKKWAeRg.Parent = _fKMemYRdzhQUqvhuQd0XnY
local _2TJk7c5RkudmpG0SS2MUnP = Instance.new("UICorner")
_2TJk7c5RkudmpG0SS2MUnP.CornerRadius = UDim.new(0, 6)
_2TJk7c5RkudmpG0SS2MUnP.Parent = _G4SfCYLf9wy64ThKKWAeRg
_G4SfCYLf9wy64ThKKWAeRg.MouseEnter:Connect(function()
    _G4SfCYLf9wy64ThKKWAeRg.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
end)
_G4SfCYLf9wy64ThKKWAeRg.MouseLeave:Connect(function()
    _G4SfCYLf9wy64ThKKWAeRg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
end)
_H8mOWlkdsZzqVD0T9SFm5G(_G4SfCYLf9wy64ThKKWAeRg, "Close")
local _ujmeruBCNLr7VXV7x8rVS8 = nil
local _IXyykbQnn8nQE0PddYhrTs = nil
local _kBJ1VTw7atBoNFCIya5jGe = Instance.new("TextButton")
_kBJ1VTw7atBoNFCIya5jGe.Name = "RestoreButton"
_kBJ1VTw7atBoNFCIya5jGe.Size = UDim2.new(0, 120, 0, 35)
_kBJ1VTw7atBoNFCIya5jGe.Position = UDim2.new(1, -130, 0, 10)
_kBJ1VTw7atBoNFCIya5jGe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_kBJ1VTw7atBoNFCIya5jGe.Text = "Tip Stats"
_kBJ1VTw7atBoNFCIya5jGe.TextColor3 = Color3.fromRGB(240, 240, 240)
_kBJ1VTw7atBoNFCIya5jGe.TextSize = 14
_kBJ1VTw7atBoNFCIya5jGe.Font = Enum.Font.GothamBold
_kBJ1VTw7atBoNFCIya5jGe.BorderSizePixel = 0
_kBJ1VTw7atBoNFCIya5jGe.Visible = false
_kBJ1VTw7atBoNFCIya5jGe.Parent = _S0syiCt3DB2qEki81fRzIy
local _jYyDzKscgx1gSdRSFM6aNI = Instance.new("UICorner")
_jYyDzKscgx1gSdRSFM6aNI.CornerRadius = UDim.new(0, 6)
_jYyDzKscgx1gSdRSFM6aNI.Parent = _kBJ1VTw7atBoNFCIya5jGe
_kBJ1VTw7atBoNFCIya5jGe.MouseEnter:Connect(function()
    _kBJ1VTw7atBoNFCIya5jGe.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
_kBJ1VTw7atBoNFCIya5jGe.MouseLeave:Connect(function()
    _kBJ1VTw7atBoNFCIya5jGe.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
end)
local _4L4AEVnEwY4CA2z6oAXXaX = false
local function _Vr62nrXGygZ9sIYancO0Ks()
    if _4L4AEVnEwY4CA2z6oAXXaX then
        return
    end
    if _zTeqPiwjdJh5tq8nBTQY68 then
        _zTeqPiwjdJh5tq8nBTQY68 = false
        _xmVJGdBcbIclOrYzVq8q5t.Visible = true
        _kBJ1VTw7atBoNFCIya5jGe.Visible = false
        local _8fntnU6fUc9hciR1BrJB4Z = _sFUmaJ8zf4eeKD0sFgl2vP or UDim2.new(0.5, -250, 0.5, -300)
        _xmVJGdBcbIclOrYzVq8q5t.Size = UDim2.new(0, 0, 0, 0)
        _xmVJGdBcbIclOrYzVq8q5t.Position = UDim2.new(0.5, 0, 0.5, 0)
        _xmVJGdBcbIclOrYzVq8q5t.BackgroundTransparency = 1
        local _34kVnxrtBUL5VzEoRUcWNC = TweenService:Create(
            _xmVJGdBcbIclOrYzVq8q5t,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = _sg3OAQ4e8v2XYKYhGZ6XjV and _c0cYO8uIBF1EnoGYrNyIOQ or _5vzTy4daSqNr8qalAXBZAk}
        )
        local _LfegRMqEenhHU2RSmftuF6 = TweenService:Create(
            _xmVJGdBcbIclOrYzVq8q5t,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Position = _8fntnU6fUc9hciR1BrJB4Z}
        )
        local _5gmO3XRtOKcVsTpWqqQxuy = TweenService:Create(
            _xmVJGdBcbIclOrYzVq8q5t,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}
        )
        _34kVnxrtBUL5VzEoRUcWNC:Play()
        _LfegRMqEenhHU2RSmftuF6:Play()
        _5gmO3XRtOKcVsTpWqqQxuy:Play()
        if _sg3OAQ4e8v2XYKYhGZ6XjV then
            _34kVnxrtBUL5VzEoRUcWNC.Completed:Wait()
            _ujmeruBCNLr7VXV7x8rVS8()
        end
    else
        _zTeqPiwjdJh5tq8nBTQY68 = true
        _4L4AEVnEwY4CA2z6oAXXaX = true
        _j05LmCQpEwjJiqluer1pL8()
        _sFUmaJ8zf4eeKD0sFgl2vP = _xmVJGdBcbIclOrYzVq8q5t.Position
        local _bwd5AWB4JduQZx75C8NyWC = TweenService:Create(
            _xmVJGdBcbIclOrYzVq8q5t,
            TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Size = UDim2.new(0, 0, 0, 0)}
        )
        local _z43kG5R0qtlaLHKmwlLy0z = TweenService:Create(
            _xmVJGdBcbIclOrYzVq8q5t,
            TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
            {Position = UDim2.new(0.5, 0, 0.5, 0)}
        )
        local _sVuSRZ3Xlz6wYyuHDEqK46 = TweenService:Create(
            _xmVJGdBcbIclOrYzVq8q5t,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {BackgroundTransparency = 1}
        )
        if _d75So8o8erdtGFSA4AQfW7 then
            _d75So8o8erdtGFSA4AQfW7.Visible = false
        end
        _bwd5AWB4JduQZx75C8NyWC:Play()
        _z43kG5R0qtlaLHKmwlLy0z:Play()
        _sVuSRZ3Xlz6wYyuHDEqK46:Play()
        _sVuSRZ3Xlz6wYyuHDEqK46.Completed:Connect(function()
            _4L4AEVnEwY4CA2z6oAXXaX = false
            _xmVJGdBcbIclOrYzVq8q5t.Visible = false
            if _kBJ1VTw7atBoNFCIya5jGe then
                _kBJ1VTw7atBoNFCIya5jGe.Visible = false
            end
        end)
    end
end
_kBJ1VTw7atBoNFCIya5jGe.Visible = false
_kBJ1VTw7atBoNFCIya5jGe.MouseButton1Click:Connect(toggleClose)
_G4SfCYLf9wy64ThKKWAeRg.MouseButton1Click:Connect(toggleClose)
local _XwhJkmKK4LIRMCbi6wrr4l = false
local dragInput, dragStart, startPos
local function _mUaLE97kPo64UpxQ5RPGXO(input)
    local _ikNbaE6PwOMFvl5KoERaUq = input.Position - dragStart
    _xmVJGdBcbIclOrYzVq8q5t.Position = UDim2.new(
        startPos.X.Scale, startPos.X.Offset + _ikNbaE6PwOMFvl5KoERaUq.X,
        startPos.Y.Scale, startPos.Y.Offset + _ikNbaE6PwOMFvl5KoERaUq.Y
    )
end
_fKMemYRdzhQUqvhuQd0XnY.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        _XwhJkmKK4LIRMCbi6wrr4l = true
        dragStart = input.Position
        startPos = _xmVJGdBcbIclOrYzVq8q5t.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                _XwhJkmKK4LIRMCbi6wrr4l = false
            end
        end)
    end
end)
_fKMemYRdzhQUqvhuQd0XnY.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and _XwhJkmKK4LIRMCbi6wrr4l then
        _mUaLE97kPo64UpxQ5RPGXO(input)
    end
end)
local _d75So8o8erdtGFSA4AQfW7 = Instance.new("ScrollingFrame")
_d75So8o8erdtGFSA4AQfW7.Name = "ScrollingFrame"
_d75So8o8erdtGFSA4AQfW7.Size = UDim2.new(1, -20, 1, -65)
_d75So8o8erdtGFSA4AQfW7.Position = UDim2.new(0, 10, 0, 55)
_d75So8o8erdtGFSA4AQfW7.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_d75So8o8erdtGFSA4AQfW7.BorderSizePixel = 0
_d75So8o8erdtGFSA4AQfW7.ScrollBarThickness = 6
_d75So8o8erdtGFSA4AQfW7.ScrollBarImageColor3 = Color3.fromRGB(40, 40, 40)
_d75So8o8erdtGFSA4AQfW7.Parent = _xmVJGdBcbIclOrYzVq8q5t
local _639LgywMIIoynUYqHx51GT = Instance.new("UICorner")
_639LgywMIIoynUYqHx51GT.CornerRadius = UDim.new(0, 6)
_639LgywMIIoynUYqHx51GT.Parent = _d75So8o8erdtGFSA4AQfW7
_ujmeruBCNLr7VXV7x8rVS8 = function()
    if _4L4AEVnEwY4CA2z6oAXXaX then
        _4L4AEVnEwY4CA2z6oAXXaX = false
        _zTeqPiwjdJh5tq8nBTQY68 = false
        if _xmVJGdBcbIclOrYzVq8q5t then
            _xmVJGdBcbIclOrYzVq8q5t.Visible = true
        end
    end
    if _zTeqPiwjdJh5tq8nBTQY68 then return end
    _sg3OAQ4e8v2XYKYhGZ6XjV = not _sg3OAQ4e8v2XYKYhGZ6XjV
    local _ImWvrH1kzVWNKxYv8llmfK = _sg3OAQ4e8v2XYKYhGZ6XjV and _c0cYO8uIBF1EnoGYrNyIOQ or _5vzTy4daSqNr8qalAXBZAk
    local _0IJ12Z7URLPpICQ5AYRVc4 = TweenService:Create(
        _xmVJGdBcbIclOrYzVq8q5t,
        TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
        {Size = _ImWvrH1kzVWNKxYv8llmfK}
    )
    if _sg3OAQ4e8v2XYKYhGZ6XjV then
        if _d75So8o8erdtGFSA4AQfW7 then
            _d75So8o8erdtGFSA4AQfW7.Visible = false
        end
        _CVlaVHjClWDwMEqa3BUP9M.Text = "+"
        if _IXyykbQnn8nQE0PddYhrTs then
            _IXyykbQnn8nQE0PddYhrTs(true)
        end
    else
        if _d75So8o8erdtGFSA4AQfW7 then
            _d75So8o8erdtGFSA4AQfW7.Visible = true
            _d75So8o8erdtGFSA4AQfW7.BackgroundTransparency = 1
        end
        if _d75So8o8erdtGFSA4AQfW7 then
            local _x1iqA6BLuLU1SZr5sD93tC = TweenService:Create(
                _d75So8o8erdtGFSA4AQfW7,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0}
            )
            _x1iqA6BLuLU1SZr5sD93tC:Play()
        end
        _CVlaVHjClWDwMEqa3BUP9M.Text = "−"
    end
    _0IJ12Z7URLPpICQ5AYRVc4:Play()
end
_CVlaVHjClWDwMEqa3BUP9M.MouseButton1Click:Connect(_ujmeruBCNLr7VXV7x8rVS8)
local _QCTFbMebAo92ycQ4E7TDJ4 = Instance.new("UIListLayout")
_QCTFbMebAo92ycQ4E7TDJ4.Padding = UDim.new(0, 8)
_QCTFbMebAo92ycQ4E7TDJ4.SortOrder = Enum.SortOrder.Name
_QCTFbMebAo92ycQ4E7TDJ4.Parent = _d75So8o8erdtGFSA4AQfW7
local _K5xyOXEnXzAlytRgO0usg1 = Instance.new("UIPadding")
_K5xyOXEnXzAlytRgO0usg1.PaddingTop = UDim.new(0, 8)
_K5xyOXEnXzAlytRgO0usg1.PaddingBottom = UDim.new(0, 8)
_K5xyOXEnXzAlytRgO0usg1.PaddingLeft = UDim.new(0, 8)
_K5xyOXEnXzAlytRgO0usg1.PaddingRight = UDim.new(0, 8)
_K5xyOXEnXzAlytRgO0usg1.Parent = _d75So8o8erdtGFSA4AQfW7
local _2L7NkdEYutvmUFgtv7mjdx = {}
local _Lk0TEFnFH56LGx3hLD5SPA = nil
local function _ml1IqDY5Wu0yipe5WAO7Ad(frame)
    if not frame or not frame.Parent then
        return
    end
    if frame:GetAttribute("Closing") then
        return
    end
    frame:SetAttribute("Closing", true)
    local _UfHRhKLS45WY9bqa3kBaHc = {}
    pcall(function()
        local _fKMemYRdzhQUqvhuQd0XnY = frame:FindFirstChild("TitleBar")
        local _XnCofYiGM3axujBs9mBXr8 = frame:FindFirstChild("ContentFrame")
        if _fKMemYRdzhQUqvhuQd0XnY then table.insert(_UfHRhKLS45WY9bqa3kBaHc, _fKMemYRdzhQUqvhuQd0XnY) end
        if _XnCofYiGM3axujBs9mBXr8 then table.insert(_UfHRhKLS45WY9bqa3kBaHc, _XnCofYiGM3axujBs9mBXr8) end
        for _, child in ipairs(frame:GetChildren()) do
            if child ~= _fKMemYRdzhQUqvhuQd0XnY and child ~= _XnCofYiGM3axujBs9mBXr8 then
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") or child:IsA("ImageButton") or child:IsA("Frame") then
                    table.insert(_UfHRhKLS45WY9bqa3kBaHc, child)
                end
            end
        end
        local _IdJBKxSC1R0xCYGoDxkbek = {}
        for _, element in ipairs(_UfHRhKLS45WY9bqa3kBaHc) do
            _IdJBKxSC1R0xCYGoDxkbek[element] = true
        end
        for _, descendant in ipairs(frame:GetDescendants()) do
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") or descendant:IsA("UIStroke") then
                if not _IdJBKxSC1R0xCYGoDxkbek[descendant] then
                    _IdJBKxSC1R0xCYGoDxkbek[descendant] = true
                    table.insert(_UfHRhKLS45WY9bqa3kBaHc, descendant)
                end
            end
        end
    end)
    local _bwd5AWB4JduQZx75C8NyWC = TweenService:Create(
        frame,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Size = UDim2.new(0, 0, 0, 0)}
    )
    local _z43kG5R0qtlaLHKmwlLy0z = TweenService:Create(
        frame,
        TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {Position = _LP6d70swKkUntJEjvGWJTW}
    )
    local _0HCOlecubsBeKj6mWezcLE = {}
    pcall(function()
        for _, element in ipairs(_UfHRhKLS45WY9bqa3kBaHc) do
            if element and element.Parent and frame.Parent then
                local success, _oTBszlGVnMdDvMOLiCys6T = pcall(function()
                    if element:IsA("TextLabel") or element:IsA("TextButton") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {TextTransparency = 1, BackgroundTransparency = element:IsA("TextButton") and 1 or element.BackgroundTransparency}
                        )
                    elseif element:IsA("ImageLabel") or element:IsA("ImageButton") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {ImageTransparency = 1, BackgroundTransparency = element:IsA("ImageButton") and 1 or element.BackgroundTransparency}
                        )
                    elseif element:IsA("Frame") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {BackgroundTransparency = 1}
                        )
                    elseif element:IsA("UIStroke") then
                        return TweenService:Create(
                            element,
                            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                            {Transparency = 1}
                        )
                    end
                end)
                if success and _oTBszlGVnMdDvMOLiCys6T then
                    table.insert(_0HCOlecubsBeKj6mWezcLE, _oTBszlGVnMdDvMOLiCys6T)
                end
            end
        end
    end)
    pcall(function()
        if frame and frame.Parent then
            _bwd5AWB4JduQZx75C8NyWC:Play()
            _z43kG5R0qtlaLHKmwlLy0z:Play()
            for _, _oTBszlGVnMdDvMOLiCys6T in ipairs(_0HCOlecubsBeKj6mWezcLE) do
                if _oTBszlGVnMdDvMOLiCys6T then
                    _oTBszlGVnMdDvMOLiCys6T:Play()
                end
            end
            _bwd5AWB4JduQZx75C8NyWC.Completed:Connect(function()
                if frame and frame.Parent then
                    frame:Destroy()
                end
            end)
        end
    end)
end
local function _B10Q6DuTvsKysMO7ZXLlkK(playerOrName, previewOnly)
    if not _S0syiCt3DB2qEki81fRzIy then
        return
    end
    local _b2ksCtLLRL6zxtzvjWrsmb = nil
    if typeof(playerOrName) == "Instance" and playerOrName:IsA("Player") then
        _b2ksCtLLRL6zxtzvjWrsmb = playerOrName.Name
    elseif typeof(playerOrName) == "string" then
        _b2ksCtLLRL6zxtzvjWrsmb = playerOrName
    end
    if not _b2ksCtLLRL6zxtzvjWrsmb then
        return
    end
    local _0zNLYKehE7PLomIZcFPOMz = _S0syiCt3DB2qEki81fRzIy:FindFirstChild("PlayerInfo_" .. _b2ksCtLLRL6zxtzvjWrsmb)
    if _0zNLYKehE7PLomIZcFPOMz then
        if previewOnly and _0zNLYKehE7PLomIZcFPOMz:GetAttribute("HoverPreview") ~= true then
            return
        end
        _ml1IqDY5Wu0yipe5WAO7Ad(_0zNLYKehE7PLomIZcFPOMz)
    end
end
local function _TD6d1gRCCxfiPBundKd0Dy(exceptPlayerName)
    if not _S0syiCt3DB2qEki81fRzIy then
        return
    end
    for _, child in ipairs(_S0syiCt3DB2qEki81fRzIy:GetChildren()) do
        if child:IsA("Frame") and string.sub(child.Name, 1, 11) == "PlayerInfo_" then
            if not exceptPlayerName or child.Name ~= "PlayerInfo_" .. exceptPlayerName then
                _ml1IqDY5Wu0yipe5WAO7Ad(child)
            end
        end
    end
end
local createPlayerInfoUI
createPlayerInfoUI = function(_bnwqb2xyJmweNiyo22vo3w, options)
    options = options or {}
    local _PHcFIHx0owCHST8F75rkzF = options._PHcFIHx0owCHST8F75rkzF ~= false
    local _9Srl9jcFEI63PIpqv1Ykqt = options._9Srl9jcFEI63PIpqv1Ykqt == true
    _42UwvlhNCVR9J2pMs0oU5M(_bnwqb2xyJmweNiyo22vo3w)
    if not _9Srl9jcFEI63PIpqv1Ykqt then
        _TD6d1gRCCxfiPBundKd0Dy(_bnwqb2xyJmweNiyo22vo3w.Name)
    end
    local _1uTMtTXjbBL38QO3P2RHHr = _S0syiCt3DB2qEki81fRzIy:FindFirstChild("PlayerInfo_" .. _bnwqb2xyJmweNiyo22vo3w.Name)
    if _1uTMtTXjbBL38QO3P2RHHr then
        local _4L4AEVnEwY4CA2z6oAXXaX = _1uTMtTXjbBL38QO3P2RHHr:GetAttribute("Closing") == true
        local _qupH5QrfYcqTpqd7zPZ8A1 = _1uTMtTXjbBL38QO3P2RHHr:GetAttribute("HoverPreview") == true
        if _4L4AEVnEwY4CA2z6oAXXaX then
            _1uTMtTXjbBL38QO3P2RHHr:Destroy()
        elseif _9Srl9jcFEI63PIpqv1Ykqt and _qupH5QrfYcqTpqd7zPZ8A1 then
            return _1uTMtTXjbBL38QO3P2RHHr
        elseif _qupH5QrfYcqTpqd7zPZ8A1 and not _9Srl9jcFEI63PIpqv1Ykqt then
            if _Lk0TEFnFH56LGx3hLD5SPA == _bnwqb2xyJmweNiyo22vo3w then
                _Lk0TEFnFH56LGx3hLD5SPA = nil
            end
            _ml1IqDY5Wu0yipe5WAO7Ad(_1uTMtTXjbBL38QO3P2RHHr)
        else
            if _PHcFIHx0owCHST8F75rkzF then
                _ml1IqDY5Wu0yipe5WAO7Ad(_1uTMtTXjbBL38QO3P2RHHr)
                return nil
            end
            return _1uTMtTXjbBL38QO3P2RHHr
        end
    end
    local _N0fWuvHIa5rL0Yg9YsOUoq = Instance.new("Frame")
    _N0fWuvHIa5rL0Yg9YsOUoq.Name = "PlayerInfo_" .. _bnwqb2xyJmweNiyo22vo3w.Name
    _N0fWuvHIa5rL0Yg9YsOUoq.Size = UDim2.new(0, 350, 0, 500)
    _N0fWuvHIa5rL0Yg9YsOUoq.Position = _LP6d70swKkUntJEjvGWJTW
    _N0fWuvHIa5rL0Yg9YsOUoq.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    _N0fWuvHIa5rL0Yg9YsOUoq.BorderSizePixel = 0
    _N0fWuvHIa5rL0Yg9YsOUoq.Visible = true
    _N0fWuvHIa5rL0Yg9YsOUoq.Parent = _S0syiCt3DB2qEki81fRzIy
    _N0fWuvHIa5rL0Yg9YsOUoq.ZIndex = 10
    _N0fWuvHIa5rL0Yg9YsOUoq.AnchorPoint = Vector2.new(1, 0)
    local _l3QnKPwZkIZ74wUCc1FtBW = Instance.new("UICorner")
    _l3QnKPwZkIZ74wUCc1FtBW.CornerRadius = UDim.new(0, 10)
    _l3QnKPwZkIZ74wUCc1FtBW.Parent = _N0fWuvHIa5rL0Yg9YsOUoq
    local _LX1QmMt39lM9P35w9aAy5m = Instance.new("UIStroke")
    _LX1QmMt39lM9P35w9aAy5m.Color = Color3.fromRGB(50, 50, 50)
    _LX1QmMt39lM9P35w9aAy5m.Thickness = 1
    _LX1QmMt39lM9P35w9aAy5m.Transparency = 0.2
    _LX1QmMt39lM9P35w9aAy5m.Parent = _N0fWuvHIa5rL0Yg9YsOUoq
    _N0fWuvHIa5rL0Yg9YsOUoq:SetAttribute("HoverPreview", _9Srl9jcFEI63PIpqv1Ykqt and true or false)
    local _OEPkdtczWkOlM3uGGAFAQS = Instance.new("Frame")
    _OEPkdtczWkOlM3uGGAFAQS.Name = "TitleBar"
    _OEPkdtczWkOlM3uGGAFAQS.Size = UDim2.new(1, 0, 0, 45)
    _OEPkdtczWkOlM3uGGAFAQS.Position = UDim2.new(0, 0, 0, 0)
    _OEPkdtczWkOlM3uGGAFAQS.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    _OEPkdtczWkOlM3uGGAFAQS.BorderSizePixel = 0
    _OEPkdtczWkOlM3uGGAFAQS.Parent = _N0fWuvHIa5rL0Yg9YsOUoq
    local _JSAzSg1uNt7lkLN9VLRdri = Instance.new("UICorner")
    _JSAzSg1uNt7lkLN9VLRdri.CornerRadius = UDim.new(0, 10)
    _JSAzSg1uNt7lkLN9VLRdri.Parent = _OEPkdtczWkOlM3uGGAFAQS
    local _Y7ltynDBrER06GLyT5a93q = Instance.new("TextLabel")
    _Y7ltynDBrER06GLyT5a93q.Name = "TitleText"
    _Y7ltynDBrER06GLyT5a93q.Size = UDim2.new(1, -50, 1, 0)
    _Y7ltynDBrER06GLyT5a93q.Position = UDim2.new(0, 15, 0, 0)
    _Y7ltynDBrER06GLyT5a93q.BackgroundTransparency = 1
    local _JicNv0VjnCZ1NKP5516Juu = _bnwqb2xyJmweNiyo22vo3w.DisplayName ~= _bnwqb2xyJmweNiyo22vo3w.Name and _bnwqb2xyJmweNiyo22vo3w.DisplayName or _bnwqb2xyJmweNiyo22vo3w.Name
    _Y7ltynDBrER06GLyT5a93q.Text = _JicNv0VjnCZ1NKP5516Juu .. " (" .. _bnwqb2xyJmweNiyo22vo3w.Name .. ")"
    _Y7ltynDBrER06GLyT5a93q.TextColor3 = Color3.fromRGB(240, 240, 240)
    _Y7ltynDBrER06GLyT5a93q.TextSize = 16
    _Y7ltynDBrER06GLyT5a93q.Font = Enum.Font.GothamSemibold
    _Y7ltynDBrER06GLyT5a93q.TextXAlignment = Enum.TextXAlignment.Left
    _Y7ltynDBrER06GLyT5a93q.TextTruncate = Enum.TextTruncate.AtEnd
    _Y7ltynDBrER06GLyT5a93q.Parent = _OEPkdtczWkOlM3uGGAFAQS
    local _i3StVfruAl21kGgG8VaTnM = Instance.new("TextButton")
    _i3StVfruAl21kGgG8VaTnM.Name = "HideButton"
    _i3StVfruAl21kGgG8VaTnM.Size = UDim2.new(0, 32, 0, 32)
    _i3StVfruAl21kGgG8VaTnM.Position = UDim2.new(1, -114, 0, 6.5)
    _i3StVfruAl21kGgG8VaTnM.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _i3StVfruAl21kGgG8VaTnM.Text = "H"
    _i3StVfruAl21kGgG8VaTnM.TextColor3 = Color3.fromRGB(150, 150, 150)
    _i3StVfruAl21kGgG8VaTnM.TextSize = 16
    _i3StVfruAl21kGgG8VaTnM.Font = Enum.Font.GothamBold
    _i3StVfruAl21kGgG8VaTnM.BorderSizePixel = 0
    _i3StVfruAl21kGgG8VaTnM.Parent = _OEPkdtczWkOlM3uGGAFAQS
    local _bvCbS8oZitGWnJKZB6qt0B = Instance.new("UICorner")
    _bvCbS8oZitGWnJKZB6qt0B.CornerRadius = UDim.new(0, 6)
    _bvCbS8oZitGWnJKZB6qt0B.Parent = _i3StVfruAl21kGgG8VaTnM
    _H8mOWlkdsZzqVD0T9SFm5G(_i3StVfruAl21kGgG8VaTnM, "Hide this _LovOfbaPAgtCeey8jCuEVQ")
    local _qNJpcF3llvQXdoISfe46Qr = Instance.new("TextButton")
    _qNJpcF3llvQXdoISfe46Qr.Name = "CopyButton"
    _qNJpcF3llvQXdoISfe46Qr.Size = UDim2.new(0, 32, 0, 32)
    _qNJpcF3llvQXdoISfe46Qr.Position = UDim2.new(1, -77, 0, 6.5)
    _qNJpcF3llvQXdoISfe46Qr.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _qNJpcF3llvQXdoISfe46Qr.Text = "📋"
    _qNJpcF3llvQXdoISfe46Qr.TextColor3 = Color3.fromRGB(150, 150, 150)
    _qNJpcF3llvQXdoISfe46Qr.TextSize = 16
    _qNJpcF3llvQXdoISfe46Qr.Font = Enum.Font.GothamBold
    _qNJpcF3llvQXdoISfe46Qr.BorderSizePixel = 0
    _qNJpcF3llvQXdoISfe46Qr.Parent = _OEPkdtczWkOlM3uGGAFAQS
    local _TfcKyuMBq8WRKWnm3zP6pT = Instance.new("UICorner")
    _TfcKyuMBq8WRKWnm3zP6pT.CornerRadius = UDim.new(0, 6)
    _TfcKyuMBq8WRKWnm3zP6pT.Parent = _qNJpcF3llvQXdoISfe46Qr
    _qNJpcF3llvQXdoISfe46Qr.MouseEnter:Connect(function()
        _qNJpcF3llvQXdoISfe46Qr.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        _qNJpcF3llvQXdoISfe46Qr.TextColor3 = Color3.fromRGB(230, 230, 230)
    end)
    _qNJpcF3llvQXdoISfe46Qr.MouseLeave:Connect(function()
        _qNJpcF3llvQXdoISfe46Qr.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _qNJpcF3llvQXdoISfe46Qr.TextColor3 = Color3.fromRGB(150, 150, 150)
    end)
    _qNJpcF3llvQXdoISfe46Qr.MouseButton1Click:Connect(function()
        local _weQyOZBTQQdpo8gERhU6TO = _bnwqb2xyJmweNiyo22vo3w.Name
        pcall(function()
            setclipboard(_weQyOZBTQQdpo8gERhU6TO)
        end)
    end)
    local _EvbGjBMjYZ8iBs9V03ggKX = false
    local function _ieGIER9aniUHDPdcemqxiB(hidden, hovering)
        local _kpm6giTrUqh18vEkktD7pJ = hidden
        if _kpm6giTrUqh18vEkktD7pJ == nil then
            _kpm6giTrUqh18vEkktD7pJ = _dCLZefCQccupswXDbTCJyf(_bnwqb2xyJmweNiyo22vo3w)
        end
        local _sFgJjh2KWT6axld7BFqqTN = hovering
        if _sFgJjh2KWT6axld7BFqqTN == nil then
            _sFgJjh2KWT6axld7BFqqTN = _EvbGjBMjYZ8iBs9V03ggKX
        end
        local _Bz2d69ownDwxUZIxYveCRo = _kpm6giTrUqh18vEkktD7pJ and Color3.fromRGB(200, 120, 120) or Color3.fromRGB(150, 150, 150)
        local _53dy7vMXjLusRK7yYuvDFH = _kpm6giTrUqh18vEkktD7pJ and Color3.fromRGB(255, 170, 170) or Color3.fromRGB(230, 230, 230)
        _i3StVfruAl21kGgG8VaTnM.TextColor3 = _sFgJjh2KWT6axld7BFqqTN and _53dy7vMXjLusRK7yYuvDFH or _Bz2d69ownDwxUZIxYveCRo
    end
    _ieGIER9aniUHDPdcemqxiB()
    _i3StVfruAl21kGgG8VaTnM.MouseEnter:Connect(function()
        _EvbGjBMjYZ8iBs9V03ggKX = true
        _i3StVfruAl21kGgG8VaTnM.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        _ieGIER9aniUHDPdcemqxiB(nil, true)
    end)
    _i3StVfruAl21kGgG8VaTnM.MouseLeave:Connect(function()
        _EvbGjBMjYZ8iBs9V03ggKX = false
        _i3StVfruAl21kGgG8VaTnM.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _ieGIER9aniUHDPdcemqxiB(nil, false)
    end)
    _i3StVfruAl21kGgG8VaTnM.MouseButton1Click:Connect(function()
        _AfmX36PRCSE6dNDr45M3Rl(_bnwqb2xyJmweNiyo22vo3w)
        _ieGIER9aniUHDPdcemqxiB()
    end)
    local _XfLcIodjknizolSvJuESJ8 = _3ZY5HZFrVY4yTv85Md1bMZ.Event:Connect(function(changedPlayer, hidden)
        if changedPlayer == _bnwqb2xyJmweNiyo22vo3w then
            _ieGIER9aniUHDPdcemqxiB(hidden)
        end
    end)
    local _kOktNOtmFITnZdM4X5ZqPm = Instance.new("TextButton")
    _kOktNOtmFITnZdM4X5ZqPm.Name = "CloseButton"
    _kOktNOtmFITnZdM4X5ZqPm.Size = UDim2.new(0, 32, 0, 32)
    _kOktNOtmFITnZdM4X5ZqPm.Position = UDim2.new(1, -40, 0, 6.5)
    _kOktNOtmFITnZdM4X5ZqPm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _kOktNOtmFITnZdM4X5ZqPm.Text = "×"
    _kOktNOtmFITnZdM4X5ZqPm.TextColor3 = Color3.fromRGB(150, 150, 150)
    _kOktNOtmFITnZdM4X5ZqPm.TextSize = 18
    _kOktNOtmFITnZdM4X5ZqPm.Font = Enum.Font.GothamBold
    _kOktNOtmFITnZdM4X5ZqPm.BorderSizePixel = 0
    _kOktNOtmFITnZdM4X5ZqPm.Parent = _OEPkdtczWkOlM3uGGAFAQS
    local _exwZpE1Tg9aT6lF6VVzpXc = Instance.new("UICorner")
    _exwZpE1Tg9aT6lF6VVzpXc.CornerRadius = UDim.new(0, 6)
    _exwZpE1Tg9aT6lF6VVzpXc.Parent = _kOktNOtmFITnZdM4X5ZqPm
    _kOktNOtmFITnZdM4X5ZqPm.MouseEnter:Connect(function()
        _kOktNOtmFITnZdM4X5ZqPm.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        _kOktNOtmFITnZdM4X5ZqPm.TextColor3 = Color3.fromRGB(230, 230, 230)
    end)
    _kOktNOtmFITnZdM4X5ZqPm.MouseLeave:Connect(function()
        _kOktNOtmFITnZdM4X5ZqPm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _kOktNOtmFITnZdM4X5ZqPm.TextColor3 = Color3.fromRGB(150, 150, 150)
    end)
    _kOktNOtmFITnZdM4X5ZqPm.MouseButton1Click:Connect(function()
        _ml1IqDY5Wu0yipe5WAO7Ad(_N0fWuvHIa5rL0Yg9YsOUoq)
    end)
    if _9Srl9jcFEI63PIpqv1Ykqt then
        _N0fWuvHIa5rL0Yg9YsOUoq.Destroying:Connect(function()
            if _Lk0TEFnFH56LGx3hLD5SPA == _bnwqb2xyJmweNiyo22vo3w then
                _Lk0TEFnFH56LGx3hLD5SPA = nil
            end
        end)
    end
    _N0fWuvHIa5rL0Yg9YsOUoq.Destroying:Connect(function()
        if _XfLcIodjknizolSvJuESJ8 then
            _XfLcIodjknizolSvJuESJ8:Disconnect()
            _XfLcIodjknizolSvJuESJ8 = nil
        end
    end)
    local _XwhJkmKK4LIRMCbi6wrr4l = false
    local dragInput, dragStart, startPos
    local function _mUaLE97kPo64UpxQ5RPGXO(input)
        local _ikNbaE6PwOMFvl5KoERaUq = input.Position - dragStart
        _N0fWuvHIa5rL0Yg9YsOUoq.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + _ikNbaE6PwOMFvl5KoERaUq.X,
            startPos.Y.Scale, startPos.Y.Offset + _ikNbaE6PwOMFvl5KoERaUq.Y
        )
    end
    _OEPkdtczWkOlM3uGGAFAQS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            _XwhJkmKK4LIRMCbi6wrr4l = true
            dragStart = input.Position
            startPos = _N0fWuvHIa5rL0Yg9YsOUoq.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    _XwhJkmKK4LIRMCbi6wrr4l = false
                end
            end)
        end
    end)
    _OEPkdtczWkOlM3uGGAFAQS.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and _XwhJkmKK4LIRMCbi6wrr4l then
            _mUaLE97kPo64UpxQ5RPGXO(input)
        end
    end)
    local _XnCofYiGM3axujBs9mBXr8 = Instance.new("Frame")
    _XnCofYiGM3axujBs9mBXr8.Name = "ContentFrame"
    _XnCofYiGM3axujBs9mBXr8.Size = UDim2.new(1, -20, 1, -65)
    _XnCofYiGM3axujBs9mBXr8.Position = UDim2.new(0, 10, 0, 55)
    _XnCofYiGM3axujBs9mBXr8.BackgroundTransparency = 1
    _XnCofYiGM3axujBs9mBXr8.Parent = _N0fWuvHIa5rL0Yg9YsOUoq
    _XnCofYiGM3axujBs9mBXr8.Parent = _N0fWuvHIa5rL0Yg9YsOUoq
    local _tulBcpSy7Dhn4VPm8GNLm1 = Instance.new("ImageLabel")
    _tulBcpSy7Dhn4VPm8GNLm1.Name = "Avatar"
    _tulBcpSy7Dhn4VPm8GNLm1.Size = UDim2.new(0, 100, 0, 100)
    _tulBcpSy7Dhn4VPm8GNLm1.Position = UDim2.new(0.5, -50, 0, 10)
    _tulBcpSy7Dhn4VPm8GNLm1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _tulBcpSy7Dhn4VPm8GNLm1.BorderSizePixel = 0
    _tulBcpSy7Dhn4VPm8GNLm1.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. _bnwqb2xyJmweNiyo22vo3w.UserId .. "&width=150&height=150&format=png"
    _tulBcpSy7Dhn4VPm8GNLm1.Parent = _XnCofYiGM3axujBs9mBXr8
    local _7RASEp0Iq0RVTaiu1ox31S = Instance.new("UICorner")
    _7RASEp0Iq0RVTaiu1ox31S.CornerRadius = UDim.new(0, 8)
    _7RASEp0Iq0RVTaiu1ox31S.Parent = _tulBcpSy7Dhn4VPm8GNLm1
    local _eBsFJu3f0a6WWgGOwIjQaA = Instance.new("ScrollingFrame")
    _eBsFJu3f0a6WWgGOwIjQaA.Name = "StatsList"
    _eBsFJu3f0a6WWgGOwIjQaA.Size = UDim2.new(1, 0, 1, -110)
    _eBsFJu3f0a6WWgGOwIjQaA.Position = UDim2.new(0, 0, 0, 120)
    _eBsFJu3f0a6WWgGOwIjQaA.BackgroundTransparency = 1
    _eBsFJu3f0a6WWgGOwIjQaA.BorderSizePixel = 0
    _eBsFJu3f0a6WWgGOwIjQaA.ScrollBarThickness = 6
    _eBsFJu3f0a6WWgGOwIjQaA.ScrollBarImageColor3 = Color3.fromRGB(70, 70, 70)
    _eBsFJu3f0a6WWgGOwIjQaA.Parent = _XnCofYiGM3axujBs9mBXr8
    local _X2Nzr4hGbJDrp2beqF0D3Q = Instance.new("UIListLayout")
    _X2Nzr4hGbJDrp2beqF0D3Q.Padding = UDim.new(0, 5)
    _X2Nzr4hGbJDrp2beqF0D3Q.SortOrder = Enum.SortOrder.LayoutOrder
    _X2Nzr4hGbJDrp2beqF0D3Q.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    local _amnLupEzVoo0yG2bMEA2ig = Instance.new("UIPadding")
    _amnLupEzVoo0yG2bMEA2ig.PaddingTop = UDim.new(0, 0)
    _amnLupEzVoo0yG2bMEA2ig.PaddingBottom = UDim.new(0, 5)
    _amnLupEzVoo0yG2bMEA2ig.PaddingLeft = UDim.new(0, 0)
    _amnLupEzVoo0yG2bMEA2ig.PaddingRight = UDim.new(0, 0)
    _amnLupEzVoo0yG2bMEA2ig.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    local function _QyHNkhLpTO3bryItA4XvD5(_EchJ1qx18nbrWMRHTJcMGF, value)
        local _O1uQtVaVEckAx1rSQW6Nty = Instance.new("Frame")
        _O1uQtVaVEckAx1rSQW6Nty.Name = _EchJ1qx18nbrWMRHTJcMGF
        _O1uQtVaVEckAx1rSQW6Nty.Size = UDim2.new(1, 0, 0, 35)
        _O1uQtVaVEckAx1rSQW6Nty.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        _O1uQtVaVEckAx1rSQW6Nty.BorderSizePixel = 0
        _O1uQtVaVEckAx1rSQW6Nty.Parent = _eBsFJu3f0a6WWgGOwIjQaA
        local _p17iE2a1QEBLGTtbRkPZvs = Instance.new("UICorner")
        _p17iE2a1QEBLGTtbRkPZvs.CornerRadius = UDim.new(0, 6)
        _p17iE2a1QEBLGTtbRkPZvs.Parent = _O1uQtVaVEckAx1rSQW6Nty
        local _AyXvRldwzvoPC7zEx2XeEq = Instance.new("UIStroke")
        _AyXvRldwzvoPC7zEx2XeEq.Color = Color3.fromRGB(60, 60, 60)
        _AyXvRldwzvoPC7zEx2XeEq.Thickness = 1
        _AyXvRldwzvoPC7zEx2XeEq.Transparency = 0.4
        _AyXvRldwzvoPC7zEx2XeEq.Parent = _O1uQtVaVEckAx1rSQW6Nty
        local _O3nUtiD0MLBxXQxpZteEn2 = Instance.new("TextLabel")
        _O3nUtiD0MLBxXQxpZteEn2.Name = "Label"
        _O3nUtiD0MLBxXQxpZteEn2.Size = UDim2.new(0, 100, 1, 0)
        _O3nUtiD0MLBxXQxpZteEn2.Position = UDim2.new(0, 10, 0, 0)
        _O3nUtiD0MLBxXQxpZteEn2.BackgroundTransparency = 1
        _O3nUtiD0MLBxXQxpZteEn2.Text = _EchJ1qx18nbrWMRHTJcMGF .. ":"
        _O3nUtiD0MLBxXQxpZteEn2.TextColor3 = Color3.fromRGB(180, 180, 180)
        _O3nUtiD0MLBxXQxpZteEn2.TextSize = 14
        _O3nUtiD0MLBxXQxpZteEn2.Font = Enum.Font.Gotham
        _O3nUtiD0MLBxXQxpZteEn2.TextXAlignment = Enum.TextXAlignment.Left
        _O3nUtiD0MLBxXQxpZteEn2.Parent = _O1uQtVaVEckAx1rSQW6Nty
        local _bV6n29u4AOtHI3rRGNqclH = Instance.new("TextLabel")
        _bV6n29u4AOtHI3rRGNqclH.Name = "Value"
        _bV6n29u4AOtHI3rRGNqclH.Size = UDim2.new(1, -120, 1, 0)
        _bV6n29u4AOtHI3rRGNqclH.Position = UDim2.new(0, 110, 0, 0)
        _bV6n29u4AOtHI3rRGNqclH.BackgroundTransparency = 1
        _bV6n29u4AOtHI3rRGNqclH.Text = value
        _bV6n29u4AOtHI3rRGNqclH.TextColor3 = Color3.fromRGB(230, 230, 230)
        _bV6n29u4AOtHI3rRGNqclH.TextSize = 14
        _bV6n29u4AOtHI3rRGNqclH.Font = Enum.Font.GothamBold
        _bV6n29u4AOtHI3rRGNqclH.TextXAlignment = Enum.TextXAlignment.Left
        _bV6n29u4AOtHI3rRGNqclH.Parent = _O1uQtVaVEckAx1rSQW6Nty
        return _bV6n29u4AOtHI3rRGNqclH
    end
    local _B2YAT8QxnBuZGBfmnNVfag = _QyHNkhLpTO3bryItA4XvD5("Received", "0")
    _B2YAT8QxnBuZGBfmnNVfag.Parent.LayoutOrder = 1
    local _NEIBh5AvbX2u2qfTwwpCPG = _QyHNkhLpTO3bryItA4XvD5("Donated", "0")
    _NEIBh5AvbX2u2qfTwwpCPG.Parent.LayoutOrder = 2
    local _UJQ3tKQK2Uro7Vr7fN86xu = _QyHNkhLpTO3bryItA4XvD5("Played Time", "0m")
    _UJQ3tKQK2Uro7Vr7fN86xu.Parent.LayoutOrder = 3
    local _4u1K6d9HcgtLO8BbGvRbbw = _QyHNkhLpTO3bryItA4XvD5("Credits", "0")
    _4u1K6d9HcgtLO8BbGvRbbw.Parent.LayoutOrder = 4
    local _Lv4aWjlN1FWRpwTUO6XktM = Instance.new("Frame")
    _Lv4aWjlN1FWRpwTUO6XktM.Name = "SettingsHeader"
    _Lv4aWjlN1FWRpwTUO6XktM.Size = UDim2.new(1, 0, 0, 35)
    _Lv4aWjlN1FWRpwTUO6XktM.BackgroundTransparency = 1
    _Lv4aWjlN1FWRpwTUO6XktM.LayoutOrder = 5
    _Lv4aWjlN1FWRpwTUO6XktM.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    local _FXe9uxG507gV4sbzVWu5d7 = Instance.new("TextLabel")
    _FXe9uxG507gV4sbzVWu5d7.Name = "HeaderText"
    _FXe9uxG507gV4sbzVWu5d7.Size = UDim2.new(1, -20, 1, 0)
    _FXe9uxG507gV4sbzVWu5d7.Position = UDim2.new(0, 10, 0, 0)
    _FXe9uxG507gV4sbzVWu5d7.BackgroundTransparency = 1
    _FXe9uxG507gV4sbzVWu5d7.Text = "Their Settings"
    _FXe9uxG507gV4sbzVWu5d7.TextColor3 = Color3.fromRGB(240, 240, 240)
    _FXe9uxG507gV4sbzVWu5d7.TextSize = 16
    _FXe9uxG507gV4sbzVWu5d7.Font = Enum.Font.GothamBold
    _FXe9uxG507gV4sbzVWu5d7.TextXAlignment = Enum.TextXAlignment.Left
    _FXe9uxG507gV4sbzVWu5d7.Parent = _Lv4aWjlN1FWRpwTUO6XktM
    local _9xXv4VFGs12Bwj8yuJ3Tty = Instance.new("Frame")
    _9xXv4VFGs12Bwj8yuJ3Tty.Name = "Divider"
    _9xXv4VFGs12Bwj8yuJ3Tty.Size = UDim2.new(1, -20, 0, 1)
    _9xXv4VFGs12Bwj8yuJ3Tty.Position = UDim2.new(0, 10, 1, -1)
    _9xXv4VFGs12Bwj8yuJ3Tty.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _9xXv4VFGs12Bwj8yuJ3Tty.BorderSizePixel = 0
    _9xXv4VFGs12Bwj8yuJ3Tty.Parent = _Lv4aWjlN1FWRpwTUO6XktM
    local _8tjczUmGkv36s9UJQcqcp7 = _QyHNkhLpTO3bryItA4XvD5("Auras", "Off")
    _8tjczUmGkv36s9UJQcqcp7.Parent.LayoutOrder = 6
    local _8ovn86yjcvYUUbLtJCSCl5 = _QyHNkhLpTO3bryItA4XvD5("Gifts", "Off")
    _8ovn86yjcvYUUbLtJCSCl5.Parent.LayoutOrder = 7
    local _v2z1haOSJDjS32flyfm3WP = _QyHNkhLpTO3bryItA4XvD5("Piano", "Off")
    _v2z1haOSJDjS32flyfm3WP.Parent.LayoutOrder = 8
    local _lIeq0cxjVFTO34wZZHc00r = _QyHNkhLpTO3bryItA4XvD5("Title", "Off")
    _lIeq0cxjVFTO34wZZHc00r.Parent.LayoutOrder = 9
    local _Ch6O06pt3JHL7flNWY5tMa = _QyHNkhLpTO3bryItA4XvD5("Shadow", "Off")
    _Ch6O06pt3JHL7flNWY5tMa.Parent.LayoutOrder = 10
    local _cvyAfMOlgdA4dJlBwXJfRR = _QyHNkhLpTO3bryItA4XvD5("Teleport", "Off")
    _cvyAfMOlgdA4dJlBwXJfRR.Parent.LayoutOrder = 11
    local _z14zQzX77kcOWFhGdOnLQX = _QyHNkhLpTO3bryItA4XvD5("Show Total Time", "Off")
    _z14zQzX77kcOWFhGdOnLQX.Parent.LayoutOrder = 12
    local _pvWQCCq2kyWa6t3RYK9qEI = Instance.new("Frame")
    _pvWQCCq2kyWa6t3RYK9qEI.Name = "BackpackHeader"
    _pvWQCCq2kyWa6t3RYK9qEI.Size = UDim2.new(1, 0, 0, 35)
    _pvWQCCq2kyWa6t3RYK9qEI.BackgroundTransparency = 1
    _pvWQCCq2kyWa6t3RYK9qEI.LayoutOrder = 13
    _pvWQCCq2kyWa6t3RYK9qEI.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    local _oUffGbyhbO18YEW6XmMSCO = Instance.new("TextLabel")
    _oUffGbyhbO18YEW6XmMSCO.Name = "HeaderText"
    _oUffGbyhbO18YEW6XmMSCO.Size = UDim2.new(1, -20, 1, 0)
    _oUffGbyhbO18YEW6XmMSCO.Position = UDim2.new(0, 10, 0, 0)
    _oUffGbyhbO18YEW6XmMSCO.BackgroundTransparency = 1
    _oUffGbyhbO18YEW6XmMSCO.Text = "Backpack Items"
    _oUffGbyhbO18YEW6XmMSCO.TextColor3 = Color3.fromRGB(240, 240, 240)
    _oUffGbyhbO18YEW6XmMSCO.TextSize = 16
    _oUffGbyhbO18YEW6XmMSCO.Font = Enum.Font.GothamBold
    _oUffGbyhbO18YEW6XmMSCO.TextXAlignment = Enum.TextXAlignment.Left
    _oUffGbyhbO18YEW6XmMSCO.Parent = _pvWQCCq2kyWa6t3RYK9qEI
    local _FiWtVT4HSoG30BL0KG1i2x = Instance.new("Frame")
    _FiWtVT4HSoG30BL0KG1i2x.Name = "Divider"
    _FiWtVT4HSoG30BL0KG1i2x.Size = UDim2.new(1, -20, 0, 1)
    _FiWtVT4HSoG30BL0KG1i2x.Position = UDim2.new(0, 10, 1, -1)
    _FiWtVT4HSoG30BL0KG1i2x.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _FiWtVT4HSoG30BL0KG1i2x.BorderSizePixel = 0
    _FiWtVT4HSoG30BL0KG1i2x.Parent = _pvWQCCq2kyWa6t3RYK9qEI
    local _PGOA35HJ0SwaA5RK602Z4g = Instance.new("Frame")
    _PGOA35HJ0SwaA5RK602Z4g.Name = "BackpackItemsContainer"
    _PGOA35HJ0SwaA5RK602Z4g.Size = UDim2.new(1, 0, 0, 0)
    _PGOA35HJ0SwaA5RK602Z4g.BackgroundTransparency = 1
    _PGOA35HJ0SwaA5RK602Z4g.LayoutOrder = 14
    _PGOA35HJ0SwaA5RK602Z4g.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    local _Pp6iojYsguWEL0V4wOAeby = Instance.new("UIListLayout")
    _Pp6iojYsguWEL0V4wOAeby.Padding = UDim.new(0, 3)
    _Pp6iojYsguWEL0V4wOAeby.SortOrder = Enum.SortOrder.LayoutOrder
    _Pp6iojYsguWEL0V4wOAeby.Parent = _PGOA35HJ0SwaA5RK602Z4g
    local function _68pRjjmVHDi7k6y7edhTeY(itemName, itemClass)
        local _kS53XjG3hZUYxPFNVUCNSH = Instance.new("Frame")
        _kS53XjG3hZUYxPFNVUCNSH.Name = itemName
        _kS53XjG3hZUYxPFNVUCNSH.Size = UDim2.new(1, 0, 0, 25)
        _kS53XjG3hZUYxPFNVUCNSH.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _kS53XjG3hZUYxPFNVUCNSH.BorderSizePixel = 0
        _kS53XjG3hZUYxPFNVUCNSH.Parent = _PGOA35HJ0SwaA5RK602Z4g
        local _GNK5XESmbthH4Ld8BMIq3x = Instance.new("UICorner")
        _GNK5XESmbthH4Ld8BMIq3x.CornerRadius = UDim.new(0, 4)
        _GNK5XESmbthH4Ld8BMIq3x.Parent = _kS53XjG3hZUYxPFNVUCNSH
        local _oevI2KBNVajvToFn9hBKyk = Instance.new("TextLabel")
        _oevI2KBNVajvToFn9hBKyk.Name = "ItemLabel"
        _oevI2KBNVajvToFn9hBKyk.Size = UDim2.new(1, -20, 1, 0)
        _oevI2KBNVajvToFn9hBKyk.Position = UDim2.new(0, 10, 0, 0)
        _oevI2KBNVajvToFn9hBKyk.BackgroundTransparency = 1
        _oevI2KBNVajvToFn9hBKyk.Text = itemName .. " (" .. itemClass .. ")"
        _oevI2KBNVajvToFn9hBKyk.TextColor3 = Color3.fromRGB(220, 220, 220)
        _oevI2KBNVajvToFn9hBKyk.TextSize = 12
        _oevI2KBNVajvToFn9hBKyk.Font = Enum.Font.Gotham
        _oevI2KBNVajvToFn9hBKyk.TextXAlignment = Enum.TextXAlignment.Left
        _oevI2KBNVajvToFn9hBKyk.TextTruncate = Enum.TextTruncate.AtEnd
        _oevI2KBNVajvToFn9hBKyk.Parent = _kS53XjG3hZUYxPFNVUCNSH
        return _kS53XjG3hZUYxPFNVUCNSH
    end
    local function _AhN1wQKMHeVcfApkVJkFYw()
        for _, child in ipairs(_PGOA35HJ0SwaA5RK602Z4g:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        local _eFeI6z5h3sgZdZDgySG4fN = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Backpack")
        if not _eFeI6z5h3sgZdZDgySG4fN then
            local _tVmLO2k6uhG02FnjO7uTTy = Instance.new("TextLabel")
            _tVmLO2k6uhG02FnjO7uTTy.Name = "NoItems"
            _tVmLO2k6uhG02FnjO7uTTy.Size = UDim2.new(1, -20, 0, 20)
            _tVmLO2k6uhG02FnjO7uTTy.Position = UDim2.new(0, 10, 0, 0)
            _tVmLO2k6uhG02FnjO7uTTy.BackgroundTransparency = 1
            _tVmLO2k6uhG02FnjO7uTTy.Text = "No _eFeI6z5h3sgZdZDgySG4fN found"
            _tVmLO2k6uhG02FnjO7uTTy.TextColor3 = Color3.fromRGB(150, 150, 150)
            _tVmLO2k6uhG02FnjO7uTTy.TextSize = 12
            _tVmLO2k6uhG02FnjO7uTTy.Font = Enum.Font.Gotham
            _tVmLO2k6uhG02FnjO7uTTy.TextXAlignment = Enum.TextXAlignment.Left
            _tVmLO2k6uhG02FnjO7uTTy.Parent = _PGOA35HJ0SwaA5RK602Z4g
            return
        end
        local _2frulmMeju3yeUsOqVpxnZ = {}
        for _, item in ipairs(_eFeI6z5h3sgZdZDgySG4fN:GetChildren()) do
            if item:IsA("Tool") or item:IsA("HopperBin") then
                table.insert(_2frulmMeju3yeUsOqVpxnZ, {name = item.Name, class = item.ClassName})
            end
        end
        table.sort(_2frulmMeju3yeUsOqVpxnZ, function(a, b)
            return a.name < b.name
        end)
        if #_2frulmMeju3yeUsOqVpxnZ == 0 then
            local _tVmLO2k6uhG02FnjO7uTTy = Instance.new("TextLabel")
            _tVmLO2k6uhG02FnjO7uTTy.Name = "NoItems"
            _tVmLO2k6uhG02FnjO7uTTy.Size = UDim2.new(1, -20, 0, 20)
            _tVmLO2k6uhG02FnjO7uTTy.Position = UDim2.new(0, 10, 0, 0)
            _tVmLO2k6uhG02FnjO7uTTy.BackgroundTransparency = 1
            _tVmLO2k6uhG02FnjO7uTTy.Text = "No _2frulmMeju3yeUsOqVpxnZ in _eFeI6z5h3sgZdZDgySG4fN"
            _tVmLO2k6uhG02FnjO7uTTy.TextColor3 = Color3.fromRGB(150, 150, 150)
            _tVmLO2k6uhG02FnjO7uTTy.TextSize = 12
            _tVmLO2k6uhG02FnjO7uTTy.Font = Enum.Font.Gotham
            _tVmLO2k6uhG02FnjO7uTTy.TextXAlignment = Enum.TextXAlignment.Left
            _tVmLO2k6uhG02FnjO7uTTy.Parent = _PGOA35HJ0SwaA5RK602Z4g
        else
            for _, itemData in ipairs(_2frulmMeju3yeUsOqVpxnZ) do
                _68pRjjmVHDi7k6y7edhTeY(itemData.name, itemData.class)
            end
        end
        task.wait()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _Pp6iojYsguWEL0V4wOAeby.AbsoluteContentSize
        _PGOA35HJ0SwaA5RK602Z4g.Size = UDim2.new(1, 0, 0, math.max(_TsvDvT7RrfM9UEsk7Xq1XT.Y, 20))
    end
    local _lIU5KukfBQzfFiWb1J0tFX = Instance.new("Frame")
    _lIU5KukfBQzfFiWb1J0tFX.Name = "GamepassesHeader"
    _lIU5KukfBQzfFiWb1J0tFX.Size = UDim2.new(1, 0, 0, 35)
    _lIU5KukfBQzfFiWb1J0tFX.BackgroundTransparency = 1
    _lIU5KukfBQzfFiWb1J0tFX.LayoutOrder = 15
    _lIU5KukfBQzfFiWb1J0tFX.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    local _Vki87H12CjJF8EPDIK67Av = Instance.new("TextLabel")
    _Vki87H12CjJF8EPDIK67Av.Name = "HeaderText"
    _Vki87H12CjJF8EPDIK67Av.Size = UDim2.new(1, -50, 1, 0)
    _Vki87H12CjJF8EPDIK67Av.Position = UDim2.new(0, 10, 0, 0)
    _Vki87H12CjJF8EPDIK67Av.BackgroundTransparency = 1
    _Vki87H12CjJF8EPDIK67Av.Text = "Gamepasses"
    _Vki87H12CjJF8EPDIK67Av.TextColor3 = Color3.fromRGB(240, 240, 240)
    _Vki87H12CjJF8EPDIK67Av.TextSize = 16
    _Vki87H12CjJF8EPDIK67Av.Font = Enum.Font.GothamBold
    _Vki87H12CjJF8EPDIK67Av.TextXAlignment = Enum.TextXAlignment.Left
    _Vki87H12CjJF8EPDIK67Av.Parent = _lIU5KukfBQzfFiWb1J0tFX
    local _xzc1mHaIk58aWC4ZgHvqg5 = Instance.new("TextButton")
    _xzc1mHaIk58aWC4ZgHvqg5.Name = "ToggleButton"
    _xzc1mHaIk58aWC4ZgHvqg5.Size = UDim2.new(0, 30, 0, 30)
    _xzc1mHaIk58aWC4ZgHvqg5.Position = UDim2.new(1, -40, 0, 2.5)
    _xzc1mHaIk58aWC4ZgHvqg5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _xzc1mHaIk58aWC4ZgHvqg5.Text = "▼"
    _xzc1mHaIk58aWC4ZgHvqg5.TextColor3 = Color3.fromRGB(220, 220, 220)
    _xzc1mHaIk58aWC4ZgHvqg5.TextSize = 16
    _xzc1mHaIk58aWC4ZgHvqg5.Font = Enum.Font.GothamBold
    _xzc1mHaIk58aWC4ZgHvqg5.BorderSizePixel = 0
    _xzc1mHaIk58aWC4ZgHvqg5.Parent = _lIU5KukfBQzfFiWb1J0tFX
    local _f2dYDherQcdYdEmEXepGV8 = Instance.new("UICorner")
    _f2dYDherQcdYdEmEXepGV8.CornerRadius = UDim.new(0, 6)
    _f2dYDherQcdYdEmEXepGV8.Parent = _xzc1mHaIk58aWC4ZgHvqg5
    _xzc1mHaIk58aWC4ZgHvqg5.MouseEnter:Connect(function()
        _xzc1mHaIk58aWC4ZgHvqg5.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    end)
    _xzc1mHaIk58aWC4ZgHvqg5.MouseLeave:Connect(function()
        _xzc1mHaIk58aWC4ZgHvqg5.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    local _RWNliaavHMJYXaMccESgue = Instance.new("Frame")
    _RWNliaavHMJYXaMccESgue.Name = "Divider"
    _RWNliaavHMJYXaMccESgue.Size = UDim2.new(1, -20, 0, 1)
    _RWNliaavHMJYXaMccESgue.Position = UDim2.new(0, 10, 1, -1)
    _RWNliaavHMJYXaMccESgue.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    _RWNliaavHMJYXaMccESgue.BorderSizePixel = 0
    _RWNliaavHMJYXaMccESgue.Parent = _lIU5KukfBQzfFiWb1J0tFX
    local _T7QVZ1rHBiAnDlvQeOnmAv = Instance.new("Frame")
    _T7QVZ1rHBiAnDlvQeOnmAv.Name = "GamepassesContainer"
    _T7QVZ1rHBiAnDlvQeOnmAv.Size = UDim2.new(1, 0, 0, 0)
    _T7QVZ1rHBiAnDlvQeOnmAv.BackgroundTransparency = 1
    _T7QVZ1rHBiAnDlvQeOnmAv.LayoutOrder = 16
    _T7QVZ1rHBiAnDlvQeOnmAv.Parent = _eBsFJu3f0a6WWgGOwIjQaA
    _T7QVZ1rHBiAnDlvQeOnmAv.Visible = false
    local _oDK9wBP1nQKCLv8xWw4XHx = Instance.new("UIListLayout")
    _oDK9wBP1nQKCLv8xWw4XHx.Padding = UDim.new(0, 5)
    _oDK9wBP1nQKCLv8xWw4XHx.SortOrder = Enum.SortOrder.LayoutOrder
    _oDK9wBP1nQKCLv8xWw4XHx.Parent = _T7QVZ1rHBiAnDlvQeOnmAv
    local _J7c5F7CEelBdFtEpefxHyt = false
    local function _14SoEUH5B4hDBsrJMdzplu()
        _J7c5F7CEelBdFtEpefxHyt = not _J7c5F7CEelBdFtEpefxHyt
        _T7QVZ1rHBiAnDlvQeOnmAv.Visible = _J7c5F7CEelBdFtEpefxHyt
        if _J7c5F7CEelBdFtEpefxHyt then
            _xzc1mHaIk58aWC4ZgHvqg5.Text = "▲"
        else
            _xzc1mHaIk58aWC4ZgHvqg5.Text = "▼"
        end
    end
    _xzc1mHaIk58aWC4ZgHvqg5.MouseButton1Click:Connect(toggleGamepasses)
    local function _ciITp2aDKz7QKcu0Bfiyy4(_b7LDV6edY9NnDRW713tKsW, _QBXPylej0YIj0weSlEUYH9, gamepassFolder, _jQS6I5prpCOjLwmo8P4SdR)
        local _8vDBw5p3jkPsgMLS3MqORs = Instance.new("Frame")
        _8vDBw5p3jkPsgMLS3MqORs.Name = tostring(_b7LDV6edY9NnDRW713tKsW)
        _8vDBw5p3jkPsgMLS3MqORs.Size = UDim2.new(1, 0, 0, 50)
        _8vDBw5p3jkPsgMLS3MqORs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _8vDBw5p3jkPsgMLS3MqORs.BorderSizePixel = 0
        _8vDBw5p3jkPsgMLS3MqORs.Parent = _T7QVZ1rHBiAnDlvQeOnmAv
        local _EaDU6Pr22KSERewhtkSK9e = Instance.new("UICorner")
        _EaDU6Pr22KSERewhtkSK9e.CornerRadius = UDim.new(0, 6)
        _EaDU6Pr22KSERewhtkSK9e.Parent = _8vDBw5p3jkPsgMLS3MqORs
        local _3iXSgbhFXhWRCtQNRxR0oc = Instance.new("UIStroke")
        _3iXSgbhFXhWRCtQNRxR0oc.Color = Color3.fromRGB(60, 60, 60)
        _3iXSgbhFXhWRCtQNRxR0oc.Thickness = 1
        _3iXSgbhFXhWRCtQNRxR0oc.Transparency = 0.4
        _3iXSgbhFXhWRCtQNRxR0oc.Parent = _8vDBw5p3jkPsgMLS3MqORs
        local _9WTCaLeAE5Pwpa3ZnkTpuX = Instance.new("TextLabel")
        _9WTCaLeAE5Pwpa3ZnkTpuX.Name = "GamepassName"
        _9WTCaLeAE5Pwpa3ZnkTpuX.Size = UDim2.new(1, -100, 0, 25)
        _9WTCaLeAE5Pwpa3ZnkTpuX.Position = UDim2.new(0, 10, 0, 5)
        _9WTCaLeAE5Pwpa3ZnkTpuX.BackgroundTransparency = 1
        _9WTCaLeAE5Pwpa3ZnkTpuX.Text = _QBXPylej0YIj0weSlEUYH9 or "Gamepass " .. _b7LDV6edY9NnDRW713tKsW
        _9WTCaLeAE5Pwpa3ZnkTpuX.TextColor3 = Color3.fromRGB(240, 240, 240)
        _9WTCaLeAE5Pwpa3ZnkTpuX.TextSize = 14
        _9WTCaLeAE5Pwpa3ZnkTpuX.Font = Enum.Font.GothamBold
        _9WTCaLeAE5Pwpa3ZnkTpuX.TextXAlignment = Enum.TextXAlignment.Left
        _9WTCaLeAE5Pwpa3ZnkTpuX.TextTruncate = Enum.TextTruncate.AtEnd
        _9WTCaLeAE5Pwpa3ZnkTpuX.Parent = _8vDBw5p3jkPsgMLS3MqORs
        local _jLd420KbOOfYZKkXaSQHh3 = Instance.new("TextLabel")
        _jLd420KbOOfYZKkXaSQHh3.Name = "GamepassId"
        _jLd420KbOOfYZKkXaSQHh3.Size = UDim2.new(1, -180, 0, 20)
        _jLd420KbOOfYZKkXaSQHh3.Position = UDim2.new(0, 10, 0, 28)
        _jLd420KbOOfYZKkXaSQHh3.BackgroundTransparency = 1
        _jLd420KbOOfYZKkXaSQHh3.Text = "ID: " .. _b7LDV6edY9NnDRW713tKsW
        _jLd420KbOOfYZKkXaSQHh3.TextColor3 = Color3.fromRGB(180, 180, 180)
        _jLd420KbOOfYZKkXaSQHh3.TextSize = 12
        _jLd420KbOOfYZKkXaSQHh3.Font = Enum.Font.Gotham
        _jLd420KbOOfYZKkXaSQHh3.TextXAlignment = Enum.TextXAlignment.Left
        _jLd420KbOOfYZKkXaSQHh3.Parent = _8vDBw5p3jkPsgMLS3MqORs
        local _pSXq9KX5CPm4xgvoTw0Mhn = Instance.new("TextLabel")
        _pSXq9KX5CPm4xgvoTw0Mhn.Name = "PriceLabel"
        _pSXq9KX5CPm4xgvoTw0Mhn.Size = UDim2.new(0, 70, 0, 35)
        _pSXq9KX5CPm4xgvoTw0Mhn.Position = UDim2.new(1, -170, 0, 7.5)
        _pSXq9KX5CPm4xgvoTw0Mhn.BackgroundTransparency = 1
        if _jQS6I5prpCOjLwmo8P4SdR and tonumber(_jQS6I5prpCOjLwmo8P4SdR) and tonumber(_jQS6I5prpCOjLwmo8P4SdR) > 0 then
            _pSXq9KX5CPm4xgvoTw0Mhn.Text = tostring(_jQS6I5prpCOjLwmo8P4SdR) .. " R$"
        else
            _pSXq9KX5CPm4xgvoTw0Mhn.Text = "N/A"
        end
        print("Creating gamepass _O1uQtVaVEckAx1rSQW6Nty - ID:", _b7LDV6edY9NnDRW713tKsW, "Price:", _jQS6I5prpCOjLwmo8P4SdR, "Price type:", type(_jQS6I5prpCOjLwmo8P4SdR))
        _pSXq9KX5CPm4xgvoTw0Mhn.TextColor3 = Color3.fromRGB(255, 215, 0)
        _pSXq9KX5CPm4xgvoTw0Mhn.TextSize = 14
        _pSXq9KX5CPm4xgvoTw0Mhn.Font = Enum.Font.GothamBold
        _pSXq9KX5CPm4xgvoTw0Mhn.TextXAlignment = Enum.TextXAlignment.Center
        _pSXq9KX5CPm4xgvoTw0Mhn.Parent = _8vDBw5p3jkPsgMLS3MqORs
        local _YfETiDXlA4bQRw5HVrDcpv = Instance.new("TextButton")
        _YfETiDXlA4bQRw5HVrDcpv.Name = "BuyButton"
        _YfETiDXlA4bQRw5HVrDcpv.Size = UDim2.new(0, 80, 0, 35)
        _YfETiDXlA4bQRw5HVrDcpv.Position = UDim2.new(1, -90, 0, 7.5)
        _YfETiDXlA4bQRw5HVrDcpv.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        _YfETiDXlA4bQRw5HVrDcpv.Text = "Buy"
        _YfETiDXlA4bQRw5HVrDcpv.TextColor3 = Color3.fromRGB(255, 255, 255)
        _YfETiDXlA4bQRw5HVrDcpv.TextSize = 14
        _YfETiDXlA4bQRw5HVrDcpv.Font = Enum.Font.GothamBold
        _YfETiDXlA4bQRw5HVrDcpv.BorderSizePixel = 0
        _YfETiDXlA4bQRw5HVrDcpv.Parent = _8vDBw5p3jkPsgMLS3MqORs
        local _P4kJ8eIuyFDt9khJUZjwqL = Instance.new("UICorner")
        _P4kJ8eIuyFDt9khJUZjwqL.CornerRadius = UDim.new(0, 6)
        _P4kJ8eIuyFDt9khJUZjwqL.Parent = _YfETiDXlA4bQRw5HVrDcpv
        _YfETiDXlA4bQRw5HVrDcpv.MouseEnter:Connect(function()
            _YfETiDXlA4bQRw5HVrDcpv.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
        end)
        _YfETiDXlA4bQRw5HVrDcpv.MouseLeave:Connect(function()
            _YfETiDXlA4bQRw5HVrDcpv.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        end)
        _YfETiDXlA4bQRw5HVrDcpv.MouseButton1Click:Connect(function()
            local _pzRKOXrlHs0wd2BRw8Wo20 = tonumber(_b7LDV6edY9NnDRW713tKsW)
            print("Attempting to purchase gamepass ID:", _pzRKOXrlHs0wd2BRw8Wo20)
            if _pzRKOXrlHs0wd2BRw8Wo20 then
                local success, err = pcall(function()
                    MarketplaceService:PromptGamePassPurchase(Players.LocalPlayer, _pzRKOXrlHs0wd2BRw8Wo20)
                end)
                if not success then
                    warn("Failed to prompt gamepass purchase:", err)
                    print("Error details:", tostring(err))
                else
                    print("Purchase prompt sent successfully for gamepass ID:", _pzRKOXrlHs0wd2BRw8Wo20)
                end
            else
                warn("Invalid gamepass ID: " .. tostring(_b7LDV6edY9NnDRW713tKsW))
                print("Gamepass ID could not be converted to number:", _b7LDV6edY9NnDRW713tKsW)
            end
        end)
        return _8vDBw5p3jkPsgMLS3MqORs
    end
    local function _uqHEFHLRRCL2RamOUA9Rkk()
        for _, child in ipairs(_T7QVZ1rHBiAnDlvQeOnmAv:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextLabel") then
                child:Destroy()
            end
        end
        local _syO5EWbIW6cexv6V7QM9Z3 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("UserCreatedGamepasses")
        if not _syO5EWbIW6cexv6V7QM9Z3 then
            local _fPzBB68LqBqzapfP1LtCxX = Instance.new("TextLabel")
            _fPzBB68LqBqzapfP1LtCxX.Name = "NoGamepasses"
            _fPzBB68LqBqzapfP1LtCxX.Size = UDim2.new(1, -20, 0, 30)
            _fPzBB68LqBqzapfP1LtCxX.Position = UDim2.new(0, 10, 0, 0)
            _fPzBB68LqBqzapfP1LtCxX.BackgroundTransparency = 1
            _fPzBB68LqBqzapfP1LtCxX.Text = "No gamepasses available"
            _fPzBB68LqBqzapfP1LtCxX.TextColor3 = Color3.fromRGB(150, 150, 150)
            _fPzBB68LqBqzapfP1LtCxX.TextSize = 12
            _fPzBB68LqBqzapfP1LtCxX.Font = Enum.Font.Gotham
            _fPzBB68LqBqzapfP1LtCxX.TextXAlignment = Enum.TextXAlignment.Left
            _fPzBB68LqBqzapfP1LtCxX.Parent = _T7QVZ1rHBiAnDlvQeOnmAv
            return
        end
        local _8pD4pwX2R8UIq5huArCXhV = {}
        local success, children = pcall(function()
            return _syO5EWbIW6cexv6V7QM9Z3:GetChildren()
        end)
        if not success or not children then
            return
        end
        for _, gamepassFolder in ipairs(children) do
            if gamepassFolder:IsA("Folder") then
                local _b7LDV6edY9NnDRW713tKsW = gamepassFolder.Name
                local _QBXPylej0YIj0weSlEUYH9 = nil
                local _jQS6I5prpCOjLwmo8P4SdR = nil
                local _SBg0Asv1n6s9lH9oBRjcjV = gamepassFolder:FindFirstChild("Name")
                if _SBg0Asv1n6s9lH9oBRjcjV then
                    if _SBg0Asv1n6s9lH9oBRjcjV:IsA("StringValue") then
                        _QBXPylej0YIj0weSlEUYH9 = _SBg0Asv1n6s9lH9oBRjcjV.Value
                    elseif _SBg0Asv1n6s9lH9oBRjcjV:IsA("ValueBase") then
                        _QBXPylej0YIj0weSlEUYH9 = tostring(_SBg0Asv1n6s9lH9oBRjcjV.Value)
                    end
                end
                local _gs74Wc17NBcujLjd37BPFN = gamepassFolder:FindFirstChild("Price")
                if _gs74Wc17NBcujLjd37BPFN then
                    if _gs74Wc17NBcujLjd37BPFN:IsA("IntValue") or _gs74Wc17NBcujLjd37BPFN:IsA("NumberValue") then
                        _jQS6I5prpCOjLwmo8P4SdR = _gs74Wc17NBcujLjd37BPFN.Value
                    elseif _gs74Wc17NBcujLjd37BPFN:IsA("StringValue") then
                        _jQS6I5prpCOjLwmo8P4SdR = tonumber(_gs74Wc17NBcujLjd37BPFN.Value)
                    end
                end
                print("Gamepass ID:", _b7LDV6edY9NnDRW713tKsW, "Name:", _QBXPylej0YIj0weSlEUYH9, "Price:", _jQS6I5prpCOjLwmo8P4SdR)
                print("Folder children:", #gamepassFolder:GetChildren())
                for _, child in ipairs(gamepassFolder:GetChildren()) do
                    print("  - Child:", child.Name, "Type:", child.ClassName)
                end
                table.insert(_8pD4pwX2R8UIq5huArCXhV, {
                    _pzRKOXrlHs0wd2BRw8Wo20 = _b7LDV6edY9NnDRW713tKsW,
                    name = _QBXPylej0YIj0weSlEUYH9,
                    price = _jQS6I5prpCOjLwmo8P4SdR,
                    folder = gamepassFolder
                })
            end
        end
        table.sort(_8pD4pwX2R8UIq5huArCXhV, function(a, b)
            local _hDLwmOfjDLdVxGIu0QutRj = a.name or a._pzRKOXrlHs0wd2BRw8Wo20
            local _tGvWuCBnevIu5RA1M7JkJM = b.name or b._pzRKOXrlHs0wd2BRw8Wo20
            return _hDLwmOfjDLdVxGIu0QutRj < _tGvWuCBnevIu5RA1M7JkJM
        end)
        if #_8pD4pwX2R8UIq5huArCXhV == 0 then
            local _fPzBB68LqBqzapfP1LtCxX = Instance.new("TextLabel")
            _fPzBB68LqBqzapfP1LtCxX.Name = "NoGamepasses"
            _fPzBB68LqBqzapfP1LtCxX.Size = UDim2.new(1, -20, 0, 30)
            _fPzBB68LqBqzapfP1LtCxX.Position = UDim2.new(0, 10, 0, 0)
            _fPzBB68LqBqzapfP1LtCxX.BackgroundTransparency = 1
            _fPzBB68LqBqzapfP1LtCxX.Text = "No gamepasses available"
            _fPzBB68LqBqzapfP1LtCxX.TextColor3 = Color3.fromRGB(150, 150, 150)
            _fPzBB68LqBqzapfP1LtCxX.TextSize = 12
            _fPzBB68LqBqzapfP1LtCxX.Font = Enum.Font.Gotham
            _fPzBB68LqBqzapfP1LtCxX.TextXAlignment = Enum.TextXAlignment.Left
            _fPzBB68LqBqzapfP1LtCxX.Parent = _T7QVZ1rHBiAnDlvQeOnmAv
        else
            for _, gamepassData in ipairs(_8pD4pwX2R8UIq5huArCXhV) do
                _ciITp2aDKz7QKcu0Bfiyy4(gamepassData._pzRKOXrlHs0wd2BRw8Wo20, gamepassData.name, gamepassData.folder, gamepassData.price)
            end
        end
        task.wait()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _oDK9wBP1nQKCLv8xWw4XHx.AbsoluteContentSize
        _T7QVZ1rHBiAnDlvQeOnmAv.Size = UDim2.new(1, 0, 0, math.max(_TsvDvT7RrfM9UEsk7Xq1XT.Y, 30))
    end
    local function _UT4UghuXB0uVve3p1spZb2()
        if not _3VUJ8SiQbUz6exE1M0KCLV(_bnwqb2xyJmweNiyo22vo3w) then
            local _O3nUtiD0MLBxXQxpZteEn2 = _B2YAT8QxnBuZGBfmnNVfag.Parent:FindFirstChild("Label")
            if _O3nUtiD0MLBxXQxpZteEn2 then
                _O3nUtiD0MLBxXQxpZteEn2.Text = "Doesn't own Tip Jar"
                _O3nUtiD0MLBxXQxpZteEn2.TextXAlignment = Enum.TextXAlignment.Center
                _O3nUtiD0MLBxXQxpZteEn2.Size = UDim2.new(1, 0, 1, 0)
                _O3nUtiD0MLBxXQxpZteEn2.Position = UDim2.new(0, 0, 0, 0)
            end
            _B2YAT8QxnBuZGBfmnNVfag.Text = ""
            return
        end
        local _O3nUtiD0MLBxXQxpZteEn2 = _B2YAT8QxnBuZGBfmnNVfag.Parent:FindFirstChild("Label")
        if _O3nUtiD0MLBxXQxpZteEn2 then
            _O3nUtiD0MLBxXQxpZteEn2.Text = "Received:"
            _O3nUtiD0MLBxXQxpZteEn2.TextXAlignment = Enum.TextXAlignment.Left
            _O3nUtiD0MLBxXQxpZteEn2.Size = UDim2.new(0, 100, 1, 0)
            _O3nUtiD0MLBxXQxpZteEn2.Position = UDim2.new(0, 10, 0, 0)
        end
        local _Ae7vISWaNHvb31mAIQfuJr = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("TipJarStats")
        if not _Ae7vISWaNHvb31mAIQfuJr then
            _Ae7vISWaNHvb31mAIQfuJr = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("TipJarStats", 1)
        end
        if _Ae7vISWaNHvb31mAIQfuJr then
            local _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr.Raised
            if not _dxbusk3cmLdj8aqj5RJbAD then
                _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Raised")
            end
            local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
            if not _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
            end
            if _dxbusk3cmLdj8aqj5RJbAD then
                if _dxbusk3cmLdj8aqj5RJbAD:IsA("IntValue") or _dxbusk3cmLdj8aqj5RJbAD:IsA("NumberValue") then
                    local _VfPDz5GJznUmh17oHwfVUK = _dxbusk3cmLdj8aqj5RJbAD.Value
                    local _gyPmTcHBSOeX5g1zbjY3jz = tostring(_VfPDz5GJznUmh17oHwfVUK)
                    local _GGCVFMRapXYdnLaIr32qPl = math.floor(_VfPDz5GJznUmh17oHwfVUK * 0.6)
                    _gyPmTcHBSOeX5g1zbjY3jz = _gyPmTcHBSOeX5g1zbjY3jz .. " (" .. tostring(_GGCVFMRapXYdnLaIr32qPl) .. ")"
                    _B2YAT8QxnBuZGBfmnNVfag.Text = _gyPmTcHBSOeX5g1zbjY3jz
                else
                    _B2YAT8QxnBuZGBfmnNVfag.Text = "0"
                end
            else
                _B2YAT8QxnBuZGBfmnNVfag.Text = "0"
            end
        else
            _B2YAT8QxnBuZGBfmnNVfag.Text = "0"
        end
    end
    local function _bbnJIuAnWy59UVUBaTyVmR()
        local _Ae7vISWaNHvb31mAIQfuJr = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("TipJarStats")
        if not _Ae7vISWaNHvb31mAIQfuJr then
            _Ae7vISWaNHvb31mAIQfuJr = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("TipJarStats", 1)
        end
        if _Ae7vISWaNHvb31mAIQfuJr then
            local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
            if not _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
            end
            if _ZKi3dfVVGlvV4TM9u0f6bf then
                if _ZKi3dfVVGlvV4TM9u0f6bf:IsA("IntValue") or _ZKi3dfVVGlvV4TM9u0f6bf:IsA("NumberValue") then
                    _NEIBh5AvbX2u2qfTwwpCPG.Text = tostring(_ZKi3dfVVGlvV4TM9u0f6bf.Value)
                else
                    _NEIBh5AvbX2u2qfTwwpCPG.Text = "0"
                end
            else
                _NEIBh5AvbX2u2qfTwwpCPG.Text = "0"
            end
        else
            _NEIBh5AvbX2u2qfTwwpCPG.Text = "0"
        end
    end
    local function _a3UcL3ZWmSt3RhKe2HAgV0()
        local _CRhs1xmXzXmdFn625mLemE = nil
        local _3z4wkr9prc8ygzJ49T0Iy9 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Minutes")
        if _3z4wkr9prc8ygzJ49T0Iy9 then
            _CRhs1xmXzXmdFn625mLemE = _3z4wkr9prc8ygzJ49T0Iy9
        else
            local _enjHRmbSlKjPkCFZNCpxE8 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("_enjHRmbSlKjPkCFZNCpxE8")
            if _enjHRmbSlKjPkCFZNCpxE8 then
                _CRhs1xmXzXmdFn625mLemE = _enjHRmbSlKjPkCFZNCpxE8:FindFirstChild("Minutes")
            end
        end
        if _CRhs1xmXzXmdFn625mLemE then
            local _fmfHPt1JO3vhGn6muT6JNS = _CRhs1xmXzXmdFn625mLemE.Value
            if _fmfHPt1JO3vhGn6muT6JNS >= 60 then
                local _pqkLMiOVKqDAySJCleSQNm = math.floor(_fmfHPt1JO3vhGn6muT6JNS / 60)
                local _C5px8HiW0KsiiHABEgfm5A = _fmfHPt1JO3vhGn6muT6JNS % 60
                _UJQ3tKQK2Uro7Vr7fN86xu.Text = _pqkLMiOVKqDAySJCleSQNm .. "h " .. _C5px8HiW0KsiiHABEgfm5A .. "m (" .. _fmfHPt1JO3vhGn6muT6JNS .. ")"
            else
                _UJQ3tKQK2Uro7Vr7fN86xu.Text = _fmfHPt1JO3vhGn6muT6JNS .. "m (" .. _fmfHPt1JO3vhGn6muT6JNS .. ")"
            end
        else
            _UJQ3tKQK2Uro7Vr7fN86xu.Text = "0m (0)"
        end
    end
    local function _ckxyF6oj7KT3B5FoV27ULf()
        local _P9uA8snTTWt8nDnsKyWhv6 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Credits")
        if _P9uA8snTTWt8nDnsKyWhv6 then
            _4u1K6d9HcgtLO8BbGvRbbw.Text = tostring(_P9uA8snTTWt8nDnsKyWhv6.Value)
        else
            _4u1K6d9HcgtLO8BbGvRbbw.Text = "0"
        end
    end
    local function _tg5ggRahsu4mgforrks7r7()
        local _7IJRE0NgInWp613Mc4YtlX = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Settings")
        if _7IJRE0NgInWp613Mc4YtlX then
            local _U6dYlrxAmwPsMJNf8ceYI2 = _7IJRE0NgInWp613Mc4YtlX.Auras or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Auras")
            local _i4sVA3WkU1H2XLzkvtC04s = _7IJRE0NgInWp613Mc4YtlX.Gifts or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Gifts")
            local _W3EZy0BMtIHsab8Fodqv3Q = _7IJRE0NgInWp613Mc4YtlX.Piano or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Piano")
            local _fXFMohljmJmjyS3k8BQytR = _7IJRE0NgInWp613Mc4YtlX.Rank or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Rank")
            local _vsqiwaZsvqXiF8aSBhCASp = _7IJRE0NgInWp613Mc4YtlX.Shadow or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Shadow")
            local _jt4m4Xvcn00JWRlzUTIReQ = _7IJRE0NgInWp613Mc4YtlX.Teleport or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Teleport")
            local _LYEvHanoPklGsmWPnYVSFp = _7IJRE0NgInWp613Mc4YtlX.Time or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Time")
            if _8tjczUmGkv36s9UJQcqcp7 then
                if _U6dYlrxAmwPsMJNf8ceYI2 and _U6dYlrxAmwPsMJNf8ceYI2:IsA("BoolValue") then
                    _8tjczUmGkv36s9UJQcqcp7.Text = _U6dYlrxAmwPsMJNf8ceYI2.Value and "Off" or "On"
                else
                    _8tjczUmGkv36s9UJQcqcp7.Text = "On"
                end
            end
            if _8ovn86yjcvYUUbLtJCSCl5 then
                if _i4sVA3WkU1H2XLzkvtC04s and _i4sVA3WkU1H2XLzkvtC04s:IsA("BoolValue") then
                    _8ovn86yjcvYUUbLtJCSCl5.Text = _i4sVA3WkU1H2XLzkvtC04s.Value and "Off" or "On"
                else
                    _8ovn86yjcvYUUbLtJCSCl5.Text = "On"
                end
            end
            if _v2z1haOSJDjS32flyfm3WP then
                if _W3EZy0BMtIHsab8Fodqv3Q and _W3EZy0BMtIHsab8Fodqv3Q:IsA("BoolValue") then
                    _v2z1haOSJDjS32flyfm3WP.Text = _W3EZy0BMtIHsab8Fodqv3Q.Value and "Off" or "On"
                else
                    _v2z1haOSJDjS32flyfm3WP.Text = "On"
                end
            end
            if _lIeq0cxjVFTO34wZZHc00r then
                if _fXFMohljmJmjyS3k8BQytR and _fXFMohljmJmjyS3k8BQytR:IsA("BoolValue") then
                    _lIeq0cxjVFTO34wZZHc00r.Text = _fXFMohljmJmjyS3k8BQytR.Value and "Off" or "On"
                else
                    _lIeq0cxjVFTO34wZZHc00r.Text = "On"
                end
            end
            if _Ch6O06pt3JHL7flNWY5tMa then
                if _vsqiwaZsvqXiF8aSBhCASp and _vsqiwaZsvqXiF8aSBhCASp:IsA("BoolValue") then
                    _Ch6O06pt3JHL7flNWY5tMa.Text = _vsqiwaZsvqXiF8aSBhCASp.Value and "Off" or "On"
                else
                    _Ch6O06pt3JHL7flNWY5tMa.Text = "On"
                end
            end
            if _cvyAfMOlgdA4dJlBwXJfRR then
                if _jt4m4Xvcn00JWRlzUTIReQ and _jt4m4Xvcn00JWRlzUTIReQ:IsA("BoolValue") then
                    _cvyAfMOlgdA4dJlBwXJfRR.Text = _jt4m4Xvcn00JWRlzUTIReQ.Value and "Off" or "On"
                else
                    _cvyAfMOlgdA4dJlBwXJfRR.Text = "On"
                end
            end
            if _z14zQzX77kcOWFhGdOnLQX then
                if _LYEvHanoPklGsmWPnYVSFp and _LYEvHanoPklGsmWPnYVSFp:IsA("BoolValue") then
                    _z14zQzX77kcOWFhGdOnLQX.Text = _LYEvHanoPklGsmWPnYVSFp.Value and "On" or "Off"
                else
                    _z14zQzX77kcOWFhGdOnLQX.Text = "Off"
                end
            end
        else
            if _8tjczUmGkv36s9UJQcqcp7 then _8tjczUmGkv36s9UJQcqcp7.Text = "On" end
            if _8ovn86yjcvYUUbLtJCSCl5 then _8ovn86yjcvYUUbLtJCSCl5.Text = "On" end
            if _v2z1haOSJDjS32flyfm3WP then _v2z1haOSJDjS32flyfm3WP.Text = "On" end
            if _lIeq0cxjVFTO34wZZHc00r then _lIeq0cxjVFTO34wZZHc00r.Text = "On" end
            if _Ch6O06pt3JHL7flNWY5tMa then _Ch6O06pt3JHL7flNWY5tMa.Text = "On" end
            if _cvyAfMOlgdA4dJlBwXJfRR then _cvyAfMOlgdA4dJlBwXJfRR.Text = "On" end
            if _z14zQzX77kcOWFhGdOnLQX then _z14zQzX77kcOWFhGdOnLQX.Text = "Off" end
        end
    end
    _UT4UghuXB0uVve3p1spZb2()
    _bbnJIuAnWy59UVUBaTyVmR()
    _a3UcL3ZWmSt3RhKe2HAgV0()
    _ckxyF6oj7KT3B5FoV27ULf()
    _tg5ggRahsu4mgforrks7r7()
    _AhN1wQKMHeVcfApkVJkFYw()
    _uqHEFHLRRCL2RamOUA9Rkk()
    spawn(function()
        local _Ae7vISWaNHvb31mAIQfuJr = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("TipJarStats")
        if not _Ae7vISWaNHvb31mAIQfuJr then
            _Ae7vISWaNHvb31mAIQfuJr = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("TipJarStats", 10)
        end
        if _Ae7vISWaNHvb31mAIQfuJr then
            local _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr.Raised
            if not _dxbusk3cmLdj8aqj5RJbAD then
                _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Raised")
            end
            if _dxbusk3cmLdj8aqj5RJbAD then
                _UT4UghuXB0uVve3p1spZb2()
                _dxbusk3cmLdj8aqj5RJbAD:GetPropertyChangedSignal("Value"):Connect(updateReceived)
            else
                local success, _eKTxAJGhWv60Q3NzobjTpg = pcall(function()
                    return _Ae7vISWaNHvb31mAIQfuJr:WaitForChild("Raised", 5)
                end)
                if success and _eKTxAJGhWv60Q3NzobjTpg then
                    _dxbusk3cmLdj8aqj5RJbAD = _eKTxAJGhWv60Q3NzobjTpg
                    _UT4UghuXB0uVve3p1spZb2()
                    _dxbusk3cmLdj8aqj5RJbAD:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                else
                    _Ae7vISWaNHvb31mAIQfuJr.ChildAdded:Connect(function(child)
                        if child.Name == "Raised" then
                            _UT4UghuXB0uVve3p1spZb2()
                            child:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                        end
                    end)
                    _UT4UghuXB0uVve3p1spZb2()
                end
            end
            local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
            if not _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
            end
            if _ZKi3dfVVGlvV4TM9u0f6bf then
                _bbnJIuAnWy59UVUBaTyVmR()
                pcall(function()
                    _ZKi3dfVVGlvV4TM9u0f6bf:GetPropertyChangedSignal("Value"):Connect(updateDonated)
                end)
            else
                local success, _eKTxAJGhWv60Q3NzobjTpg = pcall(function()
                    return _Ae7vISWaNHvb31mAIQfuJr:WaitForChild("Donated", 5)
                end)
                if success and _eKTxAJGhWv60Q3NzobjTpg then
                    _ZKi3dfVVGlvV4TM9u0f6bf = _eKTxAJGhWv60Q3NzobjTpg
                    _bbnJIuAnWy59UVUBaTyVmR()
                    _ZKi3dfVVGlvV4TM9u0f6bf:GetPropertyChangedSignal("Value"):Connect(updateDonated)
                else
                    _bbnJIuAnWy59UVUBaTyVmR()
                end
            end
        end
        local _CRhs1xmXzXmdFn625mLemE = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Minutes")
        if not _CRhs1xmXzXmdFn625mLemE then
            local _enjHRmbSlKjPkCFZNCpxE8 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("_enjHRmbSlKjPkCFZNCpxE8")
            if not _enjHRmbSlKjPkCFZNCpxE8 then
                _enjHRmbSlKjPkCFZNCpxE8 = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("_enjHRmbSlKjPkCFZNCpxE8", 10)
            end
            if _enjHRmbSlKjPkCFZNCpxE8 then
                _CRhs1xmXzXmdFn625mLemE = _enjHRmbSlKjPkCFZNCpxE8:FindFirstChild("Minutes")
            end
        end
        if _CRhs1xmXzXmdFn625mLemE then
            _a3UcL3ZWmSt3RhKe2HAgV0()
            _CRhs1xmXzXmdFn625mLemE:GetPropertyChangedSignal("Value"):Connect(updateTime)
        end
        local _P9uA8snTTWt8nDnsKyWhv6 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Credits")
        if not _P9uA8snTTWt8nDnsKyWhv6 then
            _P9uA8snTTWt8nDnsKyWhv6 = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("Credits", 10)
        end
        if _P9uA8snTTWt8nDnsKyWhv6 then
            _P9uA8snTTWt8nDnsKyWhv6:GetPropertyChangedSignal("Value"):Connect(updateCredits)
        end
        local _7IJRE0NgInWp613Mc4YtlX = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Settings")
        if not _7IJRE0NgInWp613Mc4YtlX then
            _7IJRE0NgInWp613Mc4YtlX = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("Settings", 10)
        end
        if _7IJRE0NgInWp613Mc4YtlX then
            local _U6dYlrxAmwPsMJNf8ceYI2 = _7IJRE0NgInWp613Mc4YtlX.Auras or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Auras")
            local _i4sVA3WkU1H2XLzkvtC04s = _7IJRE0NgInWp613Mc4YtlX.Gifts or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Gifts")
            local _W3EZy0BMtIHsab8Fodqv3Q = _7IJRE0NgInWp613Mc4YtlX.Piano or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Piano")
            local _fXFMohljmJmjyS3k8BQytR = _7IJRE0NgInWp613Mc4YtlX.Rank or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Rank")
            local _vsqiwaZsvqXiF8aSBhCASp = _7IJRE0NgInWp613Mc4YtlX.Shadow or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Shadow")
            local _jt4m4Xvcn00JWRlzUTIReQ = _7IJRE0NgInWp613Mc4YtlX.Teleport or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Teleport")
            local _LYEvHanoPklGsmWPnYVSFp = _7IJRE0NgInWp613Mc4YtlX.Time or _7IJRE0NgInWp613Mc4YtlX:FindFirstChild("Time")
            if _U6dYlrxAmwPsMJNf8ceYI2 and _U6dYlrxAmwPsMJNf8ceYI2:IsA("BoolValue") then
                _U6dYlrxAmwPsMJNf8ceYI2:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if _i4sVA3WkU1H2XLzkvtC04s and _i4sVA3WkU1H2XLzkvtC04s:IsA("BoolValue") then
                _i4sVA3WkU1H2XLzkvtC04s:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if _W3EZy0BMtIHsab8Fodqv3Q and _W3EZy0BMtIHsab8Fodqv3Q:IsA("BoolValue") then
                _W3EZy0BMtIHsab8Fodqv3Q:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if _fXFMohljmJmjyS3k8BQytR and _fXFMohljmJmjyS3k8BQytR:IsA("BoolValue") then
                _fXFMohljmJmjyS3k8BQytR:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if _vsqiwaZsvqXiF8aSBhCASp and _vsqiwaZsvqXiF8aSBhCASp:IsA("BoolValue") then
                _vsqiwaZsvqXiF8aSBhCASp:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if _jt4m4Xvcn00JWRlzUTIReQ and _jt4m4Xvcn00JWRlzUTIReQ:IsA("BoolValue") then
                _jt4m4Xvcn00JWRlzUTIReQ:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
            if _LYEvHanoPklGsmWPnYVSFp and _LYEvHanoPklGsmWPnYVSFp:IsA("BoolValue") then
                _LYEvHanoPklGsmWPnYVSFp:GetPropertyChangedSignal("Value"):Connect(updateSettings)
            end
        end
        local _eFeI6z5h3sgZdZDgySG4fN = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("Backpack")
        if not _eFeI6z5h3sgZdZDgySG4fN then
            _eFeI6z5h3sgZdZDgySG4fN = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("Backpack", 10)
        end
        if _eFeI6z5h3sgZdZDgySG4fN then
            _AhN1wQKMHeVcfApkVJkFYw()
            _eFeI6z5h3sgZdZDgySG4fN.ChildAdded:Connect(function(child)
                if child:IsA("Tool") or child:IsA("HopperBin") then
                    _AhN1wQKMHeVcfApkVJkFYw()
                    if child.Name == "TipJar" then
                        _wZfqLs3LjJppkdDdMw1wsB(_bnwqb2xyJmweNiyo22vo3w)
                        _UT4UghuXB0uVve3p1spZb2()
                    end
                end
            end)
            _eFeI6z5h3sgZdZDgySG4fN.ChildRemoved:Connect(function(child)
                if child:IsA("Tool") or child:IsA("HopperBin") then
                    _AhN1wQKMHeVcfApkVJkFYw()
                    if child.Name == "TipJar" then
                        _wZfqLs3LjJppkdDdMw1wsB(_bnwqb2xyJmweNiyo22vo3w)
                        _UT4UghuXB0uVve3p1spZb2()
                    end
                end
            end)
        end
        local _syO5EWbIW6cexv6V7QM9Z3 = _bnwqb2xyJmweNiyo22vo3w:FindFirstChild("UserCreatedGamepasses")
        if not _syO5EWbIW6cexv6V7QM9Z3 then
            _syO5EWbIW6cexv6V7QM9Z3 = _bnwqb2xyJmweNiyo22vo3w:WaitForChild("UserCreatedGamepasses", 10)
        end
        if _syO5EWbIW6cexv6V7QM9Z3 then
            _uqHEFHLRRCL2RamOUA9Rkk()
            _syO5EWbIW6cexv6V7QM9Z3.ChildAdded:Connect(function()
                _uqHEFHLRRCL2RamOUA9Rkk()
            end)
            _syO5EWbIW6cexv6V7QM9Z3.ChildRemoved:Connect(function()
                _uqHEFHLRRCL2RamOUA9Rkk()
            end)
        end
    end)
    _X2Nzr4hGbJDrp2beqF0D3Q:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _X2Nzr4hGbJDrp2beqF0D3Q.AbsoluteContentSize
        _eBsFJu3f0a6WWgGOwIjQaA.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    end)
    _Pp6iojYsguWEL0V4wOAeby:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _X2Nzr4hGbJDrp2beqF0D3Q.AbsoluteContentSize
        _eBsFJu3f0a6WWgGOwIjQaA.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    end)
    _oDK9wBP1nQKCLv8xWw4XHx:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local _TsvDvT7RrfM9UEsk7Xq1XT = _X2Nzr4hGbJDrp2beqF0D3Q.AbsoluteContentSize
        _eBsFJu3f0a6WWgGOwIjQaA.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    end)
    task.wait()
    local _TsvDvT7RrfM9UEsk7Xq1XT = _X2Nzr4hGbJDrp2beqF0D3Q.AbsoluteContentSize
    _eBsFJu3f0a6WWgGOwIjQaA.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 10)
    _N0fWuvHIa5rL0Yg9YsOUoq.Size = UDim2.new(0, 0, 0, 0)
    _N0fWuvHIa5rL0Yg9YsOUoq.Position = _LP6d70swKkUntJEjvGWJTW
    _N0fWuvHIa5rL0Yg9YsOUoq.BackgroundTransparency = 1
    local _3Dr7v7xMPhOi7Ip0oyTXar = TweenService:Create(
        _N0fWuvHIa5rL0Yg9YsOUoq,
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 350, 0, 500), Position = _LP6d70swKkUntJEjvGWJTW, BackgroundTransparency = 0}
    )
    _3Dr7v7xMPhOi7Ip0oyTXar:Play()
    return _N0fWuvHIa5rL0Yg9YsOUoq
end
local _fHX9ZQQA5bf17PmEj0Y7hl = 0.2
local _ZBmN5biEt23rELgRNYL1ZQ = 0.35
local _4VjfcpB4mLgqkyICmx9ewG = 0
local _KyudF1wlqenY1Uo94R3Tmd = nil
local _XgVZSxipJ7tAAN0zy3w1K5 = nil
local _8KA16DhcL1jBITUfqrXNSp = nil
local _VMLNExLRDyJxCopIvZIRnC = nil
local _Kcc7nsqdcmbaE4MqPv6hzW = nil
local _LFi0qZdc4oWnTq64V89tZ4 = nil
local _jVymzWIAXaQnBPRt81eciW = nil
local _uildZL1vmEeTCJmgMl8lD1 = nil
local _KoOJhJwixuZLBGlb7s5Q2v = nil
local _adWVLfhn3lVdKmDMUrMS73 = nil
local _ntsH4qYQYx5cyFphyVPUKU = nil
local _ympEGlqTKafZ6F0uSDMDOK = nil
local _pGZxdI1iQehtz9LNA6cTqX = false
local _dGzNFbhgyafBcUkg28RtNo = nil
local _kZLMzu0qJ5RkScwAjSsSdf = nil
local _XBKJwUTSyCjW8FKhNjahnR = UDim2.new(0, 300, 0, 72)
local _sbro9F2eGsfFxwn5qqGn4a = UDim2.new(0, 300, 0, 0)
local _haOFiWjH6ZorNv6hLTx2tt = false
local _VJRJQ2QO7FYqgIdmF26RB1 = false
local _6LB0HLV47jGLBY8iz9N6JF = nil
local _LPdwPyN85X3NQKiV2nKbdR = nil
local function _6iVms7cv6rY0XzIYa0yeHJ(inputObject)
    if _dFoL2KYYKZmWE03gv5CfaU.disableAltRequirement then
        return true
    end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
        return true
    end
    if inputObject and inputObject.IsModifierKeyDown then
        local success, _eKTxAJGhWv60Q3NzobjTpg = pcall(function()
            return inputObject:IsModifierKeyDown(Enum.ModifierKey.Alt)
        end)
        if success and _eKTxAJGhWv60Q3NzobjTpg then
            return true
        end
    end
    if _haOFiWjH6ZorNv6hLTx2tt then
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) or UserInputService:IsKeyDown(Enum.KeyCode.RightAlt) then
            return true
        else
            _haOFiWjH6ZorNv6hLTx2tt = false
        end
    end
    return false
end
local function _dvPTaGQC82d390q5Xnevx6()
    if _Kcc7nsqdcmbaE4MqPv6hzW then
        return
    end
    _Kcc7nsqdcmbaE4MqPv6hzW = Instance.new("Frame")
    _Kcc7nsqdcmbaE4MqPv6hzW.Name = "HoverInfoBanner"
    _Kcc7nsqdcmbaE4MqPv6hzW.Size = _sbro9F2eGsfFxwn5qqGn4a
    _Kcc7nsqdcmbaE4MqPv6hzW.AnchorPoint = Vector2.new(0.5, 1)
    _Kcc7nsqdcmbaE4MqPv6hzW.Position = UDim2.new(0.5, 0, 1, 100)
    _Kcc7nsqdcmbaE4MqPv6hzW.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    _Kcc7nsqdcmbaE4MqPv6hzW.BackgroundTransparency = 1
    _Kcc7nsqdcmbaE4MqPv6hzW.BorderSizePixel = 0
    _Kcc7nsqdcmbaE4MqPv6hzW.Visible = false
    _Kcc7nsqdcmbaE4MqPv6hzW.Parent = _S0syiCt3DB2qEki81fRzIy
    _Kcc7nsqdcmbaE4MqPv6hzW.ZIndex = 50
    local _jzNzpjmoJ5AO9JJUtJvqbs = Instance.new("UICorner")
    _jzNzpjmoJ5AO9JJUtJvqbs.CornerRadius = UDim.new(0, 10)
    _jzNzpjmoJ5AO9JJUtJvqbs.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    local _ZUaiVJe6jdqIs0iDz5d5eI = Instance.new("UIStroke")
    _ZUaiVJe6jdqIs0iDz5d5eI.Color = Color3.fromRGB(60, 60, 60)
    _ZUaiVJe6jdqIs0iDz5d5eI.Thickness = 1
    _ZUaiVJe6jdqIs0iDz5d5eI.Transparency = 0.3
    _ZUaiVJe6jdqIs0iDz5d5eI.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    _LFi0qZdc4oWnTq64V89tZ4 = Instance.new("ImageLabel")
    _LFi0qZdc4oWnTq64V89tZ4.Name = "Avatar"
    _LFi0qZdc4oWnTq64V89tZ4.Size = UDim2.new(0, 44, 0, 44)
    _LFi0qZdc4oWnTq64V89tZ4.Position = UDim2.new(0, 8, 0.5, -22)
    _LFi0qZdc4oWnTq64V89tZ4.BackgroundTransparency = 1
    _LFi0qZdc4oWnTq64V89tZ4.Image = ""
    _LFi0qZdc4oWnTq64V89tZ4.ImageTransparency = 1
    _LFi0qZdc4oWnTq64V89tZ4.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    local _7RASEp0Iq0RVTaiu1ox31S = Instance.new("UICorner")
    _7RASEp0Iq0RVTaiu1ox31S.CornerRadius = UDim.new(1, 0)
    _7RASEp0Iq0RVTaiu1ox31S.Parent = _LFi0qZdc4oWnTq64V89tZ4
    _jVymzWIAXaQnBPRt81eciW = Instance.new("TextLabel")
    _jVymzWIAXaQnBPRt81eciW.Name = "DisplayName"
    _jVymzWIAXaQnBPRt81eciW.Size = UDim2.new(1, -70, 0, 26)
    _jVymzWIAXaQnBPRt81eciW.Position = UDim2.new(0, 60, 0, 8)
    _jVymzWIAXaQnBPRt81eciW.BackgroundTransparency = 1
    _jVymzWIAXaQnBPRt81eciW.Text = ""
    _jVymzWIAXaQnBPRt81eciW.TextColor3 = Color3.fromRGB(235, 235, 235)
    _jVymzWIAXaQnBPRt81eciW.TextSize = 16
    _jVymzWIAXaQnBPRt81eciW.Font = Enum.Font.GothamBold
    _jVymzWIAXaQnBPRt81eciW.TextXAlignment = Enum.TextXAlignment.Left
    _jVymzWIAXaQnBPRt81eciW.TextTruncate = Enum.TextTruncate.AtEnd
    _jVymzWIAXaQnBPRt81eciW.TextTransparency = 1
    _jVymzWIAXaQnBPRt81eciW.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    _uildZL1vmEeTCJmgMl8lD1 = Instance.new("TextLabel")
    _uildZL1vmEeTCJmgMl8lD1.Name = "Username"
    _uildZL1vmEeTCJmgMl8lD1.Size = UDim2.new(1, -70, 0, 20)
    _uildZL1vmEeTCJmgMl8lD1.Position = UDim2.new(0, 60, 0, 38)
    _uildZL1vmEeTCJmgMl8lD1.BackgroundTransparency = 1
    _uildZL1vmEeTCJmgMl8lD1.Text = ""
    _uildZL1vmEeTCJmgMl8lD1.TextColor3 = Color3.fromRGB(170, 170, 170)
    _uildZL1vmEeTCJmgMl8lD1.TextSize = 14
    _uildZL1vmEeTCJmgMl8lD1.Font = Enum.Font.Gotham
    _uildZL1vmEeTCJmgMl8lD1.TextXAlignment = Enum.TextXAlignment.Left
    _uildZL1vmEeTCJmgMl8lD1.TextTruncate = Enum.TextTruncate.AtEnd
    _uildZL1vmEeTCJmgMl8lD1.TextTransparency = 1
    _uildZL1vmEeTCJmgMl8lD1.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    _KoOJhJwixuZLBGlb7s5Q2v = Instance.new("ImageLabel")
    _KoOJhJwixuZLBGlb7s5Q2v.Name = "DonatedIcon"
    _KoOJhJwixuZLBGlb7s5Q2v.Size = UDim2.new(0, 16, 0, 16)
    _KoOJhJwixuZLBGlb7s5Q2v.Position = UDim2.new(1, -110, 0, 10)
    _KoOJhJwixuZLBGlb7s5Q2v.BackgroundTransparency = 1
    _KoOJhJwixuZLBGlb7s5Q2v.Image = "rbxassetid://6031288895"
    _KoOJhJwixuZLBGlb7s5Q2v.ImageColor3 = Color3.fromRGB(0, 170, 0)
    _KoOJhJwixuZLBGlb7s5Q2v.ImageTransparency = 1
    _KoOJhJwixuZLBGlb7s5Q2v.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    _adWVLfhn3lVdKmDMUrMS73 = Instance.new("TextLabel")
    _adWVLfhn3lVdKmDMUrMS73.Name = "DonatedText"
    _adWVLfhn3lVdKmDMUrMS73.Size = UDim2.new(0, 90, 0, 18)
    _adWVLfhn3lVdKmDMUrMS73.Position = UDim2.new(1, -90, 0, 8)
    _adWVLfhn3lVdKmDMUrMS73.BackgroundTransparency = 1
    _adWVLfhn3lVdKmDMUrMS73.Text = "D:
    _adWVLfhn3lVdKmDMUrMS73.TextColor3 = Color3.fromRGB(200, 200, 200)
    _adWVLfhn3lVdKmDMUrMS73.TextSize = 14
    _adWVLfhn3lVdKmDMUrMS73.Font = Enum.Font.GothamBold
    _adWVLfhn3lVdKmDMUrMS73.TextXAlignment = Enum.TextXAlignment.Left
    _adWVLfhn3lVdKmDMUrMS73.TextTruncate = Enum.TextTruncate.AtEnd
    _adWVLfhn3lVdKmDMUrMS73.TextTransparency = 1
    _adWVLfhn3lVdKmDMUrMS73.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    _ntsH4qYQYx5cyFphyVPUKU = Instance.new("ImageLabel")
    _ntsH4qYQYx5cyFphyVPUKU.Name = "ReceivedIcon"
    _ntsH4qYQYx5cyFphyVPUKU.Size = UDim2.new(0, 16, 0, 16)
    _ntsH4qYQYx5cyFphyVPUKU.Position = UDim2.new(1, -110, 0, 40)
    _ntsH4qYQYx5cyFphyVPUKU.BackgroundTransparency = 1
    _ntsH4qYQYx5cyFphyVPUKU.Image = "rbxassetid://6031288895"
    _ntsH4qYQYx5cyFphyVPUKU.ImageColor3 = Color3.fromRGB(0, 170, 0)
    _ntsH4qYQYx5cyFphyVPUKU.ImageTransparency = 1
    _ntsH4qYQYx5cyFphyVPUKU.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
    _ympEGlqTKafZ6F0uSDMDOK = Instance.new("TextLabel")
    _ympEGlqTKafZ6F0uSDMDOK.Name = "ReceivedText"
    _ympEGlqTKafZ6F0uSDMDOK.Size = UDim2.new(0, 90, 0, 18)
    _ympEGlqTKafZ6F0uSDMDOK.Position = UDim2.new(1, -90, 0, 38)
    _ympEGlqTKafZ6F0uSDMDOK.BackgroundTransparency = 1
    _ympEGlqTKafZ6F0uSDMDOK.Text = "R:
    _ympEGlqTKafZ6F0uSDMDOK.TextColor3 = Color3.fromRGB(200, 200, 200)
    _ympEGlqTKafZ6F0uSDMDOK.TextSize = 14
    _ympEGlqTKafZ6F0uSDMDOK.Font = Enum.Font.Gotham
    _ympEGlqTKafZ6F0uSDMDOK.TextXAlignment = Enum.TextXAlignment.Left
    _ympEGlqTKafZ6F0uSDMDOK.TextTruncate = Enum.TextTruncate.AtEnd
    _ympEGlqTKafZ6F0uSDMDOK.TextTransparency = 1
    _ympEGlqTKafZ6F0uSDMDOK.Parent = _Kcc7nsqdcmbaE4MqPv6hzW
end
local function _JIPdE5A8BGSXaJgEToCgCf(visible)
    _dvPTaGQC82d390q5Xnevx6()
    if _pGZxdI1iQehtz9LNA6cTqX == visible then
        return
    end
    _pGZxdI1iQehtz9LNA6cTqX = visible
    if _dGzNFbhgyafBcUkg28RtNo then
        _dGzNFbhgyafBcUkg28RtNo:Cancel()
    end
    if visible then
        _Kcc7nsqdcmbaE4MqPv6hzW.Visible = true
        _Kcc7nsqdcmbaE4MqPv6hzW.Size = _sbro9F2eGsfFxwn5qqGn4a
    end
    local _8fntnU6fUc9hciR1BrJB4Z = visible and UDim2.new(0.5, 0, 1, -20) or UDim2.new(0.5, 0, 1, 100)
    local _fbtDenOfI61ecKOUiG7kQp = visible and 0 or 1
    _dGzNFbhgyafBcUkg28RtNo = TweenService:Create(
        _Kcc7nsqdcmbaE4MqPv6hzW,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, visible and Enum.EasingDirection.Out or Enum.EasingDirection.In),
        {
            Position = _8fntnU6fUc9hciR1BrJB4Z,
            BackgroundTransparency = _fbtDenOfI61ecKOUiG7kQp,
            Size = visible and _XBKJwUTSyCjW8FKhNjahnR or _sbro9F2eGsfFxwn5qqGn4a,
        }
    )
    _dGzNFbhgyafBcUkg28RtNo:Play()
    _dGzNFbhgyafBcUkg28RtNo.Completed:Connect(function()
        if not _pGZxdI1iQehtz9LNA6cTqX then
            _Kcc7nsqdcmbaE4MqPv6hzW.Visible = false
        end
    end)
    local _58l401Mafc6bGHW7HjuSFe = visible and 0 or 1
    local _Jn8bsmwZSeyhujJemvwOIg = visible and 0 or 1
    local _WnBOsPGsStjIkHoRTZNBRv = {_jVymzWIAXaQnBPRt81eciW, _uildZL1vmEeTCJmgMl8lD1, _adWVLfhn3lVdKmDMUrMS73, _ympEGlqTKafZ6F0uSDMDOK}
    for _, element in ipairs(_WnBOsPGsStjIkHoRTZNBRv) do
        TweenService:Create(
            element,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, visible and Enum.EasingDirection.Out or Enum.EasingDirection.In),
            {TextTransparency = _58l401Mafc6bGHW7HjuSFe}
        ):Play()
    end
    local _rFlr9oSePZmaZh1FiwiL3h = {_LFi0qZdc4oWnTq64V89tZ4, _KoOJhJwixuZLBGlb7s5Q2v, _ntsH4qYQYx5cyFphyVPUKU}
    for _, icon in ipairs(_rFlr9oSePZmaZh1FiwiL3h) do
        TweenService:Create(
            icon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, visible and Enum.EasingDirection.Out or Enum.EasingDirection.In),
            {ImageTransparency = _Jn8bsmwZSeyhujJemvwOIg}
        ):Play()
    end
end
local function _Rcqe9CzNAHINpiU6D214uM(_LovOfbaPAgtCeey8jCuEVQ, valueName)
    local _IVWI7bXdkLl8TsOH3UUxt8 = _LovOfbaPAgtCeey8jCuEVQ and _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("TipJarStats")
    if not _IVWI7bXdkLl8TsOH3UUxt8 then
        return nil
    end
    local _NrNF9WGGmCwQXGRCrmTkCI = _IVWI7bXdkLl8TsOH3UUxt8[valueName] or _IVWI7bXdkLl8TsOH3UUxt8:FindFirstChild(valueName)
    if _NrNF9WGGmCwQXGRCrmTkCI and (_NrNF9WGGmCwQXGRCrmTkCI:IsA("IntValue") or _NrNF9WGGmCwQXGRCrmTkCI:IsA("NumberValue")) then
        return _NrNF9WGGmCwQXGRCrmTkCI.Value
    end
    return nil
end
local function _eBeRL2Rdcd1gPfsS3atYuM(amount)
    if amount == nil then
        return "
    end
    local _pAXGhV6kOr6YQtJwq50aAx = tostring(amount)
    local _qlRy7O5UGZK9MGUVYK3UMO = _pAXGhV6kOr6YQtJwq50aAx
    local _eKTxAJGhWv60Q3NzobjTpg = ""
    local len = #_qlRy7O5UGZK9MGUVYK3UMO
    local _HJmqAxh1Duy5UOG5LOzN1J = 0
    for i = len, 1, -1 do
        _eKTxAJGhWv60Q3NzobjTpg = string.sub(_qlRy7O5UGZK9MGUVYK3UMO, i, i) .. _eKTxAJGhWv60Q3NzobjTpg
        _HJmqAxh1Duy5UOG5LOzN1J += 1
        if _HJmqAxh1Duy5UOG5LOzN1J == 3 and i > 1 then
            _eKTxAJGhWv60Q3NzobjTpg = "," .. _eKTxAJGhWv60Q3NzobjTpg
            _HJmqAxh1Duy5UOG5LOzN1J = 0
        end
    end
    return _eKTxAJGhWv60Q3NzobjTpg
end
local function _LPzLpdkYAaIFIfsio0gCsu(_LovOfbaPAgtCeey8jCuEVQ)
    _dvPTaGQC82d390q5Xnevx6()
    if _LovOfbaPAgtCeey8jCuEVQ and not _dFoL2KYYKZmWE03gv5CfaU.disableHoverInfo then
        if _kZLMzu0qJ5RkScwAjSsSdf ~= _LovOfbaPAgtCeey8jCuEVQ then
            _kZLMzu0qJ5RkScwAjSsSdf = _LovOfbaPAgtCeey8jCuEVQ
            _LFi0qZdc4oWnTq64V89tZ4.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="
                .. _LovOfbaPAgtCeey8jCuEVQ.UserId .. "&width=150&height=150&format=png"
            local _JicNv0VjnCZ1NKP5516Juu = _LovOfbaPAgtCeey8jCuEVQ.DisplayName ~= "" and _LovOfbaPAgtCeey8jCuEVQ.DisplayName or _LovOfbaPAgtCeey8jCuEVQ.Name
            _jVymzWIAXaQnBPRt81eciW.Text = _JicNv0VjnCZ1NKP5516Juu
            _uildZL1vmEeTCJmgMl8lD1.Text = "@" .. _LovOfbaPAgtCeey8jCuEVQ.Name
            local _S6caHhOnW519PlsEXo7nSl = _Rcqe9CzNAHINpiU6D214uM(_LovOfbaPAgtCeey8jCuEVQ, "Donated")
            local _uZJiTMe2jo8BbmhCBiNPny = _Rcqe9CzNAHINpiU6D214uM(_LovOfbaPAgtCeey8jCuEVQ, "Raised")
            _adWVLfhn3lVdKmDMUrMS73.Text = "D: " .. _eBeRL2Rdcd1gPfsS3atYuM(_S6caHhOnW519PlsEXo7nSl)
            _ympEGlqTKafZ6F0uSDMDOK.Text = "R: " .. _eBeRL2Rdcd1gPfsS3atYuM(_uZJiTMe2jo8BbmhCBiNPny)
        end
        _JIPdE5A8BGSXaJgEToCgCf(true)
    else
        _kZLMzu0qJ5RkScwAjSsSdf = nil
        _JIPdE5A8BGSXaJgEToCgCf(false)
    end
end
local function _vVUgrstHNwmEHNOj4SErtE()
    if _8KA16DhcL1jBITUfqrXNSp then
        _8KA16DhcL1jBITUfqrXNSp:Destroy()
        _8KA16DhcL1jBITUfqrXNSp = nil
    end
end
local function _sZOt19lBJPz4C4RcXm1ft3(_NXDf15WGHv4zdyTFuuiM2w)
    if not _NXDf15WGHv4zdyTFuuiM2w or _dFoL2KYYKZmWE03gv5CfaU.disableHoverOutline then
        return
    end
    _vVUgrstHNwmEHNOj4SErtE()
    local _6kK5cF5LRCPYLQNhqQU7Vk = Instance.new("Highlight")
    _6kK5cF5LRCPYLQNhqQU7Vk.Name = "TipStatsHoverOutline"
    _6kK5cF5LRCPYLQNhqQU7Vk.FillTransparency = 1
    _6kK5cF5LRCPYLQNhqQU7Vk.OutlineTransparency = 0
    _6kK5cF5LRCPYLQNhqQU7Vk.OutlineColor = Color3.fromRGB(55, 55, 55)
    _6kK5cF5LRCPYLQNhqQU7Vk.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    _6kK5cF5LRCPYLQNhqQU7Vk.Adornee = _NXDf15WGHv4zdyTFuuiM2w
    _6kK5cF5LRCPYLQNhqQU7Vk.Parent = _NXDf15WGHv4zdyTFuuiM2w
    _6kK5cF5LRCPYLQNhqQU7Vk.Destroying:Connect(function()
        if _8KA16DhcL1jBITUfqrXNSp == _6kK5cF5LRCPYLQNhqQU7Vk then
            _8KA16DhcL1jBITUfqrXNSp = nil
        end
    end)
    _8KA16DhcL1jBITUfqrXNSp = _6kK5cF5LRCPYLQNhqQU7Vk
end
local function _zwRPN1TBVKYtqVoGZssxzz(_LovOfbaPAgtCeey8jCuEVQ)
    if not _LovOfbaPAgtCeey8jCuEVQ then
        return
    end
    _B10Q6DuTvsKysMO7ZXLlkK(_LovOfbaPAgtCeey8jCuEVQ, true)
    if _Lk0TEFnFH56LGx3hLD5SPA == _LovOfbaPAgtCeey8jCuEVQ then
        _Lk0TEFnFH56LGx3hLD5SPA = nil
    end
end
local function _GzXUBXZiCSdAUJ8pFEGVzo(newPlayer)
    if _KyudF1wlqenY1Uo94R3Tmd == newPlayer then
        return
    end
    if _XgVZSxipJ7tAAN0zy3w1K5 then
        task.cancel(_XgVZSxipJ7tAAN0zy3w1K5)
        _XgVZSxipJ7tAAN0zy3w1K5 = nil
    end
    if _VMLNExLRDyJxCopIvZIRnC then
        _VMLNExLRDyJxCopIvZIRnC:Disconnect()
        _VMLNExLRDyJxCopIvZIRnC = nil
    end
    if _KyudF1wlqenY1Uo94R3Tmd then
        _zwRPN1TBVKYtqVoGZssxzz(_KyudF1wlqenY1Uo94R3Tmd)
    end
    _KyudF1wlqenY1Uo94R3Tmd = newPlayer
    _LPzLpdkYAaIFIfsio0gCsu(_KyudF1wlqenY1Uo94R3Tmd)
    _vVUgrstHNwmEHNOj4SErtE()
    if not _KyudF1wlqenY1Uo94R3Tmd then
        return
    end
    local function _zo5drzsDkFYgez6ysediNY()
        if _KyudF1wlqenY1Uo94R3Tmd == newPlayer then
            _sZOt19lBJPz4C4RcXm1ft3(_KyudF1wlqenY1Uo94R3Tmd.Character)
        end
    end
    if _KyudF1wlqenY1Uo94R3Tmd.Character then
        _zo5drzsDkFYgez6ysediNY()
    else
        _VMLNExLRDyJxCopIvZIRnC = _KyudF1wlqenY1Uo94R3Tmd.CharacterAdded:Connect(function()
            _zo5drzsDkFYgez6ysediNY()
        end)
    end
    _XgVZSxipJ7tAAN0zy3w1K5 = task.delay(_fHX9ZQQA5bf17PmEj0Y7hl, function()
        _XgVZSxipJ7tAAN0zy3w1K5 = nil
        if _KyudF1wlqenY1Uo94R3Tmd ~= newPlayer then
            return
        end
    end)
end
local function _0bMkBGfE8s8q5CqY0v6KIE()
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    if not _emQnagvqLpPINr8NKtwuzb then
        return
    end
    local _MuwzwnrcuJw3dI7KL1cWMS = _emQnagvqLpPINr8NKtwuzb.Target
    if not _MuwzwnrcuJw3dI7KL1cWMS then
        _GzXUBXZiCSdAUJ8pFEGVzo(nil)
        return
    end
    local _bnwqb2xyJmweNiyo22vo3w = _Fzz1Ml7Xmv9ATdihb7jl4s(_MuwzwnrcuJw3dI7KL1cWMS)
    if _bnwqb2xyJmweNiyo22vo3w and _bnwqb2xyJmweNiyo22vo3w ~= _0Mo4Au6gjlIcWTR8WhXyix then
        local _7sSuNW9RajWXYNfgdADsOE = _dFoL2KYYKZmWE03gv5CfaU.hoverRange or _LhLCCPupqgkRsRdGijHmSr
        local _yo3mgaAPysPtXOHUsAHRj0 = _tUZ9Tym2vHpshovPSgGjI0(_bnwqb2xyJmweNiyo22vo3w, _7sSuNW9RajWXYNfgdADsOE)
        if _yo3mgaAPysPtXOHUsAHRj0 then
            _GzXUBXZiCSdAUJ8pFEGVzo(_bnwqb2xyJmweNiyo22vo3w)
            return
        end
    end
    _GzXUBXZiCSdAUJ8pFEGVzo(nil)
end
if _emQnagvqLpPINr8NKtwuzb then
    _emQnagvqLpPINr8NKtwuzb.Move:Connect(evaluateHoverTarget)
end
_np2lATLn4q5t0F0tS01g0q(RunService.RenderStepped:Connect(function()
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    _0bMkBGfE8s8q5CqY0v6KIE()
end))
local function _zRt7QCU8MmJkbIxcWFeJhl(_bnwqb2xyJmweNiyo22vo3w, _IYclvxtR8gJWlv6aqwR67x)
end
local function _rnwvh0D3OcsCTuQmIUIhiD()
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return false
    end
    if not _0Mo4Au6gjlIcWTR8WhXyix or not _emQnagvqLpPINr8NKtwuzb then
        return false
    end
    local _oaYFAGjkYpfA39uzWUy0Ii = _emQnagvqLpPINr8NKtwuzb.Target
    if not _oaYFAGjkYpfA39uzWUy0Ii then
        return false
    end
    local _bnwqb2xyJmweNiyo22vo3w = _Fzz1Ml7Xmv9ATdihb7jl4s(_oaYFAGjkYpfA39uzWUy0Ii)
    if not _bnwqb2xyJmweNiyo22vo3w or _bnwqb2xyJmweNiyo22vo3w == _0Mo4Au6gjlIcWTR8WhXyix then
        return false
    end
    local _jO1Hy2pA2jBR1wT7oy8aDw = _0Mo4Au6gjlIcWTR8WhXyix.Character
    local _h9SE505xhMreHmbgzPuJFP = _bnwqb2xyJmweNiyo22vo3w.Character
    if not _jO1Hy2pA2jBR1wT7oy8aDw or not _h9SE505xhMreHmbgzPuJFP then
        return false
    end
    local _lpVrBbjhkyo5gmUAQamLCA = _RJjERYng8mXMJfhQnnCyT2(_jO1Hy2pA2jBR1wT7oy8aDw)
    local _GvKyAr6AdlPTT76gxCatXd = _RJjERYng8mXMJfhQnnCyT2(_h9SE505xhMreHmbgzPuJFP)
    if not _lpVrBbjhkyo5gmUAQamLCA or not _GvKyAr6AdlPTT76gxCatXd then
        return false
    end
    local _DQI0PgZWHCBZi5cfkZjC88 = (_lpVrBbjhkyo5gmUAQamLCA.Position - _GvKyAr6AdlPTT76gxCatXd.Position).Magnitude
    local _sU2ux4hS7YgueB4A1llY7W = _dFoL2KYYKZmWE03gv5CfaU.hoverRange or _LhLCCPupqgkRsRdGijHmSr
    if _DQI0PgZWHCBZi5cfkZjC88 > _sU2ux4hS7YgueB4A1llY7W then
        _wLtE0qjNgk1WbcLcXu7ZQ2(
            "Tip Stats",
            "Move closer to inspect " .. (_bnwqb2xyJmweNiyo22vo3w.DisplayName or _bnwqb2xyJmweNiyo22vo3w.Name) .. ".",
            "warning"
        )
        return true
    end
    createPlayerInfoUI(_bnwqb2xyJmweNiyo22vo3w)
    local _IYclvxtR8gJWlv6aqwR67x = UserInputService:GetMouseLocation()
    return true
end
_np2lATLn4q5t0F0tS01g0q(UserInputService.InputBegan:Connect(function(input, processed)
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    if _VJRJQ2QO7FYqgIdmF26RB1 then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode then
                if input.KeyCode == Enum.KeyCode.Escape then
                    _VJRJQ2QO7FYqgIdmF26RB1 = false
                    if _6LB0HLV47jGLBY8iz9N6JF then
                        local function _Svia7aVA4iIFKek2zwQj6W()
                            if _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode then
                                _6LB0HLV47jGLBY8iz9N6JF.Text = _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode.Name
                            else
                                _6LB0HLV47jGLBY8iz9N6JF.Text = "None"
                            end
                        end
                        _Svia7aVA4iIFKek2zwQj6W()
                        _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    print("TipStatsGUI: Hotkey listening cancelled (Escape)")
                    return
                end
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode = input.KeyCode
                    _VJRJQ2QO7FYqgIdmF26RB1 = false
                    if _6LB0HLV47jGLBY8iz9N6JF then
                        _6LB0HLV47jGLBY8iz9N6JF.Text = input.KeyCode.Name
                        _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end
                    print("TipStatsGUI: Hotkey set to", input.KeyCode.Name)
                    _JfvnLGBwbI7NxDCEXIRtHd()
                    return
                end
            end
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
            _VJRJQ2QO7FYqgIdmF26RB1 = false
            if _6LB0HLV47jGLBY8iz9N6JF then
                local function _Svia7aVA4iIFKek2zwQj6W()
                    if _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode then
                        _6LB0HLV47jGLBY8iz9N6JF.Text = _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode.Name
                    else
                        _6LB0HLV47jGLBY8iz9N6JF.Text = "None"
                    end
                end
                _Svia7aVA4iIFKek2zwQj6W()
                _6LB0HLV47jGLBY8iz9N6JF.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end
            print("TipStatsGUI: Hotkey listening cancelled (mouse click)")
            return
        end
        return
    end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        _haOFiWjH6ZorNv6hLTx2tt = true
    end
    if not processed and input.UserInputType == Enum.UserInputType.Keyboard then
        if _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode and input.KeyCode == _dFoL2KYYKZmWE03gv5CfaU.toggleKeyCode then
            if not UserInputService:GetFocusedTextBox() then
                _Vr62nrXGygZ9sIYancO0Ks()
            end
            return
        end
    end
    if processed then
        return
    end
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        if not _6iVms7cv6rY0XzIYa0yeHJ(input) then
            return
        end
        if tick() - _4VjfcpB4mLgqkyICmx9ewG < _ZBmN5biEt23rELgRNYL1ZQ then
            return
        end
        if _rnwvh0D3OcsCTuQmIUIhiD() then
            _4VjfcpB4mLgqkyICmx9ewG = tick()
        end
    end
end))
_np2lATLn4q5t0F0tS01g0q(UserInputService.InputEnded:Connect(function(input)
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    if input.KeyCode == Enum.KeyCode.LeftAlt or input.KeyCode == Enum.KeyCode.RightAlt then
        _haOFiWjH6ZorNv6hLTx2tt = false
    end
end))
local function _ugArf3HxbMMw0yyUJ4txqh(_LovOfbaPAgtCeey8jCuEVQ)
    _42UwvlhNCVR9J2pMs0oU5M(_LovOfbaPAgtCeey8jCuEVQ)
    local _duhhtyvg5a2PYEzV8RGwEY = Instance.new("Frame")
    _duhhtyvg5a2PYEzV8RGwEY.Name = _LovOfbaPAgtCeey8jCuEVQ.Name
    _duhhtyvg5a2PYEzV8RGwEY.Size = UDim2.new(1, 0, 0, 60)
    _duhhtyvg5a2PYEzV8RGwEY.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _duhhtyvg5a2PYEzV8RGwEY.BorderSizePixel = 0
    _duhhtyvg5a2PYEzV8RGwEY.Parent = _d75So8o8erdtGFSA4AQfW7
    local _6CPV0sbsq77Y10Ve9WPVRs = Instance.new("UICorner")
    _6CPV0sbsq77Y10Ve9WPVRs.CornerRadius = UDim.new(0, 8)
    _6CPV0sbsq77Y10Ve9WPVRs.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _7TZ73K9TvlcDwHnUzH8pZy = Instance.new("UIStroke")
    _7TZ73K9TvlcDwHnUzH8pZy.Color = Color3.fromRGB(60, 60, 60)
    _7TZ73K9TvlcDwHnUzH8pZy.Thickness = 1
    _7TZ73K9TvlcDwHnUzH8pZy.Transparency = 0.4
    _7TZ73K9TvlcDwHnUzH8pZy.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _02nR22gaiFHPUU8hl9HHNk = Instance.new("TextLabel")
    _02nR22gaiFHPUU8hl9HHNk.Name = "NameLabel"
    _02nR22gaiFHPUU8hl9HHNk.Size = UDim2.new(1, -134, 0, 22)
    _02nR22gaiFHPUU8hl9HHNk.Position = UDim2.new(0, 10, 0, 4)
    _02nR22gaiFHPUU8hl9HHNk.BackgroundTransparency = 1
    local _JicNv0VjnCZ1NKP5516Juu = _LovOfbaPAgtCeey8jCuEVQ.DisplayName ~= _LovOfbaPAgtCeey8jCuEVQ.Name and _LovOfbaPAgtCeey8jCuEVQ.DisplayName or _LovOfbaPAgtCeey8jCuEVQ.Name
    _02nR22gaiFHPUU8hl9HHNk.Text = _JicNv0VjnCZ1NKP5516Juu .. " (" .. _LovOfbaPAgtCeey8jCuEVQ.Name .. ")"
    _02nR22gaiFHPUU8hl9HHNk.TextColor3 = Color3.fromRGB(255, 255, 255)
    _02nR22gaiFHPUU8hl9HHNk.TextSize = 15
    _02nR22gaiFHPUU8hl9HHNk.Font = Enum.Font.GothamBold
    _02nR22gaiFHPUU8hl9HHNk.TextXAlignment = Enum.TextXAlignment.Left
    _02nR22gaiFHPUU8hl9HHNk.TextTruncate = Enum.TextTruncate.AtEnd
    _02nR22gaiFHPUU8hl9HHNk.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _EX4RGaAcslGqMMCb5CbCC6 = nil
    if _LovOfbaPAgtCeey8jCuEVQ.MembershipType == Enum.MembershipType.Premium then
        _EX4RGaAcslGqMMCb5CbCC6 = Instance.new("TextLabel")
        _EX4RGaAcslGqMMCb5CbCC6.Name = "PremiumBadge"
        _EX4RGaAcslGqMMCb5CbCC6.Size = UDim2.new(0, 18, 0, 18)
        _EX4RGaAcslGqMMCb5CbCC6.BackgroundTransparency = 1
        _EX4RGaAcslGqMMCb5CbCC6.Text = "⭐"
        _EX4RGaAcslGqMMCb5CbCC6.TextColor3 = Color3.fromRGB(255, 215, 0)
        _EX4RGaAcslGqMMCb5CbCC6.TextSize = 14
        _EX4RGaAcslGqMMCb5CbCC6.Font = Enum.Font.GothamBold
        _EX4RGaAcslGqMMCb5CbCC6.Parent = _duhhtyvg5a2PYEzV8RGwEY
        _EX4RGaAcslGqMMCb5CbCC6.ZIndex = _02nR22gaiFHPUU8hl9HHNk.ZIndex + 1
        local function _irGNn18m1ebF4OLQRWl4T7()
            if not _EX4RGaAcslGqMMCb5CbCC6 or not _EX4RGaAcslGqMMCb5CbCC6.Parent then return end
            spawn(function()
                task.wait(0.1)
                if not _EX4RGaAcslGqMMCb5CbCC6 or not _EX4RGaAcslGqMMCb5CbCC6.Parent or not _02nR22gaiFHPUU8hl9HHNk then return end
                local _fQxu2duvsOBoEcjbUM2KX0 = _02nR22gaiFHPUU8hl9HHNk.TextBounds
                local _KcUdf3xl4fYWuhyMi7aT8h = _02nR22gaiFHPUU8hl9HHNk.Position.X.Offset + _fQxu2duvsOBoEcjbUM2KX0.X + 4
                _EX4RGaAcslGqMMCb5CbCC6.Position = UDim2.new(0, _KcUdf3xl4fYWuhyMi7aT8h, 0, _02nR22gaiFHPUU8hl9HHNk.Position.Y.Offset + 2)
            end)
        end
        _02nR22gaiFHPUU8hl9HHNk:GetPropertyChangedSignal("TextBounds"):Connect(updatePremiumBadgePosition)
        _irGNn18m1ebF4OLQRWl4T7()
    end
    _LovOfbaPAgtCeey8jCuEVQ:GetPropertyChangedSignal("DisplayName"):Connect(function()
        local _HV2mheaVDplZ0Jh05lzwv4 = _LovOfbaPAgtCeey8jCuEVQ.DisplayName ~= _LovOfbaPAgtCeey8jCuEVQ.Name and _LovOfbaPAgtCeey8jCuEVQ.DisplayName or _LovOfbaPAgtCeey8jCuEVQ.Name
        _02nR22gaiFHPUU8hl9HHNk.Text = _HV2mheaVDplZ0Jh05lzwv4 .. " (" .. _LovOfbaPAgtCeey8jCuEVQ.Name .. ")"
        if _EX4RGaAcslGqMMCb5CbCC6 then
            spawn(function()
                task.wait(0.1)
                if not _EX4RGaAcslGqMMCb5CbCC6 or not _EX4RGaAcslGqMMCb5CbCC6.Parent or not _02nR22gaiFHPUU8hl9HHNk then return end
                local _fQxu2duvsOBoEcjbUM2KX0 = _02nR22gaiFHPUU8hl9HHNk.TextBounds
                local _KcUdf3xl4fYWuhyMi7aT8h = _02nR22gaiFHPUU8hl9HHNk.Position.X.Offset + _fQxu2duvsOBoEcjbUM2KX0.X + 4
                _EX4RGaAcslGqMMCb5CbCC6.Position = UDim2.new(0, _KcUdf3xl4fYWuhyMi7aT8h, 0, _02nR22gaiFHPUU8hl9HHNk.Position.Y.Offset + 2)
            end)
        end
    end)
    local _ohIGSBt7imMP4kYCwHl5VN = Instance.new("TextButton")
    _ohIGSBt7imMP4kYCwHl5VN.Name = "HideButton"
    _ohIGSBt7imMP4kYCwHl5VN.Size = UDim2.new(0, 22, 0, 22)
    _ohIGSBt7imMP4kYCwHl5VN.Position = UDim2.new(1, -128, 0, 4)
    _ohIGSBt7imMP4kYCwHl5VN.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _ohIGSBt7imMP4kYCwHl5VN.Text = "H"
    _ohIGSBt7imMP4kYCwHl5VN.TextColor3 = Color3.fromRGB(150, 150, 150)
    _ohIGSBt7imMP4kYCwHl5VN.TextSize = 14
    _ohIGSBt7imMP4kYCwHl5VN.Font = Enum.Font.GothamBold
    _ohIGSBt7imMP4kYCwHl5VN.BorderSizePixel = 0
    _ohIGSBt7imMP4kYCwHl5VN.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _CEUu4dhp7t9bDTcyqlg6kJ = Instance.new("UICorner")
    _CEUu4dhp7t9bDTcyqlg6kJ.CornerRadius = UDim.new(0, 4)
    _CEUu4dhp7t9bDTcyqlg6kJ.Parent = _ohIGSBt7imMP4kYCwHl5VN
    _H8mOWlkdsZzqVD0T9SFm5G(_ohIGSBt7imMP4kYCwHl5VN, "Hide this _LovOfbaPAgtCeey8jCuEVQ")
    local _r0JMgd8FDLqKbxLuZK2uNc = false
    local function _4Z9oaDHGTj7jtKivqShXkN(hidden, hovering)
        local _kpm6giTrUqh18vEkktD7pJ = hidden
        if _kpm6giTrUqh18vEkktD7pJ == nil then
            _kpm6giTrUqh18vEkktD7pJ = _dCLZefCQccupswXDbTCJyf(_LovOfbaPAgtCeey8jCuEVQ)
        end
        local _sFgJjh2KWT6axld7BFqqTN = hovering
        if _sFgJjh2KWT6axld7BFqqTN == nil then
            _sFgJjh2KWT6axld7BFqqTN = _r0JMgd8FDLqKbxLuZK2uNc
        end
        local _Bz2d69ownDwxUZIxYveCRo = _kpm6giTrUqh18vEkktD7pJ and Color3.fromRGB(200, 120, 120) or Color3.fromRGB(150, 150, 150)
        local _53dy7vMXjLusRK7yYuvDFH = _kpm6giTrUqh18vEkktD7pJ and Color3.fromRGB(255, 170, 170) or Color3.fromRGB(230, 230, 230)
        _ohIGSBt7imMP4kYCwHl5VN.TextColor3 = _sFgJjh2KWT6axld7BFqqTN and _53dy7vMXjLusRK7yYuvDFH or _Bz2d69ownDwxUZIxYveCRo
    end
    _4Z9oaDHGTj7jtKivqShXkN()
    _ohIGSBt7imMP4kYCwHl5VN.MouseEnter:Connect(function()
        _r0JMgd8FDLqKbxLuZK2uNc = true
        _ohIGSBt7imMP4kYCwHl5VN.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        _4Z9oaDHGTj7jtKivqShXkN(nil, true)
    end)
    _ohIGSBt7imMP4kYCwHl5VN.MouseLeave:Connect(function()
        _r0JMgd8FDLqKbxLuZK2uNc = false
        _ohIGSBt7imMP4kYCwHl5VN.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _4Z9oaDHGTj7jtKivqShXkN(nil, false)
    end)
    _ohIGSBt7imMP4kYCwHl5VN.MouseButton1Click:Connect(function()
        _AfmX36PRCSE6dNDr45M3Rl(_LovOfbaPAgtCeey8jCuEVQ)
        _4Z9oaDHGTj7jtKivqShXkN()
    end)
    local _I5bnzinln0EPORE6zlXNUW = _3ZY5HZFrVY4yTv85Md1bMZ.Event:Connect(function(changedPlayer, hidden)
        if changedPlayer == _LovOfbaPAgtCeey8jCuEVQ then
            _4Z9oaDHGTj7jtKivqShXkN(hidden)
                    end
                end)
    _duhhtyvg5a2PYEzV8RGwEY.Destroying:Connect(function()
        if _I5bnzinln0EPORE6zlXNUW then
            _I5bnzinln0EPORE6zlXNUW:Disconnect()
            _I5bnzinln0EPORE6zlXNUW = nil
        end
    end)
    local _Hqa0CTqefHAyhhsb3pjIBw = Instance.new("TextButton")
    _Hqa0CTqefHAyhhsb3pjIBw.Name = "BangButton"
    _Hqa0CTqefHAyhhsb3pjIBw.Size = UDim2.new(0, 22, 0, 22)
    _Hqa0CTqefHAyhhsb3pjIBw.Position = UDim2.new(1, -104, 0, 4)
    _Hqa0CTqefHAyhhsb3pjIBw.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _Hqa0CTqefHAyhhsb3pjIBw.Text = "💥"
    _Hqa0CTqefHAyhhsb3pjIBw.TextColor3 = Color3.fromRGB(220, 220, 220)
    _Hqa0CTqefHAyhhsb3pjIBw.TextSize = 14
    _Hqa0CTqefHAyhhsb3pjIBw.Font = Enum.Font.GothamBold
    _Hqa0CTqefHAyhhsb3pjIBw.BorderSizePixel = 0
    _Hqa0CTqefHAyhhsb3pjIBw.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _PbRgyK33kbNmr0xPuRmIsp = Instance.new("UICorner")
    _PbRgyK33kbNmr0xPuRmIsp.CornerRadius = UDim.new(0, 4)
    _PbRgyK33kbNmr0xPuRmIsp.Parent = _Hqa0CTqefHAyhhsb3pjIBw
    _Hqa0CTqefHAyhhsb3pjIBw.MouseEnter:Connect(function()
        _Hqa0CTqefHAyhhsb3pjIBw.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _Hqa0CTqefHAyhhsb3pjIBw.MouseLeave:Connect(function()
        _Hqa0CTqefHAyhhsb3pjIBw.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _H8mOWlkdsZzqVD0T9SFm5G(_Hqa0CTqefHAyhhsb3pjIBw, "bangs this _LovOfbaPAgtCeey8jCuEVQ")
    _Hqa0CTqefHAyhhsb3pjIBw.MouseButton1Click:Connect(function()
        _OO24suFpUOJOzJZphVtPaD(_LovOfbaPAgtCeey8jCuEVQ)
    end)
    local _ZFJcC2avcTIxf4voWxAAR1 = Instance.new("TextButton")
    _ZFJcC2avcTIxf4voWxAAR1.Name = "SpyButton"
    _ZFJcC2avcTIxf4voWxAAR1.Size = UDim2.new(0, 22, 0, 22)
    _ZFJcC2avcTIxf4voWxAAR1.Position = UDim2.new(1, -80, 0, 4)
    _ZFJcC2avcTIxf4voWxAAR1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _ZFJcC2avcTIxf4voWxAAR1.Text = "👁"
    _ZFJcC2avcTIxf4voWxAAR1.TextColor3 = Color3.fromRGB(220, 220, 220)
    _ZFJcC2avcTIxf4voWxAAR1.TextSize = 14
    _ZFJcC2avcTIxf4voWxAAR1.Font = Enum.Font.GothamBold
    _ZFJcC2avcTIxf4voWxAAR1.BorderSizePixel = 0
    _ZFJcC2avcTIxf4voWxAAR1.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _qB9pe2N9n2AZtpar9USxZ8 = Instance.new("UICorner")
    _qB9pe2N9n2AZtpar9USxZ8.CornerRadius = UDim.new(0, 4)
    _qB9pe2N9n2AZtpar9USxZ8.Parent = _ZFJcC2avcTIxf4voWxAAR1
    _ZFJcC2avcTIxf4voWxAAR1.MouseEnter:Connect(function()
        _ZFJcC2avcTIxf4voWxAAR1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _ZFJcC2avcTIxf4voWxAAR1.MouseLeave:Connect(function()
        _ZFJcC2avcTIxf4voWxAAR1.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _H8mOWlkdsZzqVD0T9SFm5G(_ZFJcC2avcTIxf4voWxAAR1, "View from this _LovOfbaPAgtCeey8jCuEVQ's perspective")
    _ZFJcC2avcTIxf4voWxAAR1.MouseButton1Click:Connect(function()
        _eGxgzKkp40UbLcsdyoLlmE(_LovOfbaPAgtCeey8jCuEVQ)
    end)
    local _apRlQrmheeSYAwU6r36moV = Instance.new("TextButton")
    _apRlQrmheeSYAwU6r36moV.Name = "TeleportButton"
    _apRlQrmheeSYAwU6r36moV.Size = UDim2.new(0, 22, 0, 22)
    _apRlQrmheeSYAwU6r36moV.Position = UDim2.new(1, -56, 0, 4)
    _apRlQrmheeSYAwU6r36moV.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _apRlQrmheeSYAwU6r36moV.Text = "→"
    _apRlQrmheeSYAwU6r36moV.TextColor3 = Color3.fromRGB(220, 220, 220)
    _apRlQrmheeSYAwU6r36moV.TextSize = 14
    _apRlQrmheeSYAwU6r36moV.Font = Enum.Font.GothamBold
    _apRlQrmheeSYAwU6r36moV.BorderSizePixel = 0
    _apRlQrmheeSYAwU6r36moV.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _lEw60oVuKkj217w2zMYPOT = Instance.new("UICorner")
    _lEw60oVuKkj217w2zMYPOT.CornerRadius = UDim.new(0, 4)
    _lEw60oVuKkj217w2zMYPOT.Parent = _apRlQrmheeSYAwU6r36moV
    _apRlQrmheeSYAwU6r36moV.MouseEnter:Connect(function()
        _apRlQrmheeSYAwU6r36moV.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _apRlQrmheeSYAwU6r36moV.MouseLeave:Connect(function()
        _apRlQrmheeSYAwU6r36moV.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _H8mOWlkdsZzqVD0T9SFm5G(_apRlQrmheeSYAwU6r36moV, "Teleport to this _LovOfbaPAgtCeey8jCuEVQ")
    _apRlQrmheeSYAwU6r36moV.MouseButton1Click:Connect(function()
        local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
        if _KCbu2Au1vAJIFqOuBflYpF and _KCbu2Au1vAJIFqOuBflYpF.Character and _KCbu2Au1vAJIFqOuBflYpF.Character:FindFirstChild("HumanoidRootPart") then
            local _h9SE505xhMreHmbgzPuJFP = _LovOfbaPAgtCeey8jCuEVQ.Character
            if _h9SE505xhMreHmbgzPuJFP and _h9SE505xhMreHmbgzPuJFP:FindFirstChild("HumanoidRootPart") then
                _KCbu2Au1vAJIFqOuBflYpF.Character.HumanoidRootPart.CFrame = _h9SE505xhMreHmbgzPuJFP.HumanoidRootPart.CFrame
            end
        end
    end)
    local _FbisKa8QfmuFTtIoTWSp4O = Instance.new("ImageButton")
    _FbisKa8QfmuFTtIoTWSp4O.Name = "InfoButton"
    _FbisKa8QfmuFTtIoTWSp4O.Size = UDim2.new(0, 22, 0, 22)
    _FbisKa8QfmuFTtIoTWSp4O.Position = UDim2.new(1, -32, 0, 4)
    _FbisKa8QfmuFTtIoTWSp4O.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    _FbisKa8QfmuFTtIoTWSp4O.BorderSizePixel = 0
    _FbisKa8QfmuFTtIoTWSp4O.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. _LovOfbaPAgtCeey8jCuEVQ.UserId .. "&width=150&height=150&format=png"
    _FbisKa8QfmuFTtIoTWSp4O.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _l3QnKPwZkIZ74wUCc1FtBW = Instance.new("UICorner")
    _l3QnKPwZkIZ74wUCc1FtBW.CornerRadius = UDim.new(0, 4)
    _l3QnKPwZkIZ74wUCc1FtBW.Parent = _FbisKa8QfmuFTtIoTWSp4O
    _FbisKa8QfmuFTtIoTWSp4O.MouseEnter:Connect(function()
        _FbisKa8QfmuFTtIoTWSp4O.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _FbisKa8QfmuFTtIoTWSp4O.MouseLeave:Connect(function()
        _FbisKa8QfmuFTtIoTWSp4O.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end)
    _FbisKa8QfmuFTtIoTWSp4O.MouseButton1Click:Connect(function()
        createPlayerInfoUI(_LovOfbaPAgtCeey8jCuEVQ)
    end)
    local _MLM6FlthVVlxBY4tYfh6KW = Instance.new("Frame")
    _MLM6FlthVVlxBY4tYfh6KW.Name = "StatsContainer"
    _MLM6FlthVVlxBY4tYfh6KW.Size = UDim2.new(1, -20, 0, 30)
    _MLM6FlthVVlxBY4tYfh6KW.Position = UDim2.new(0, 10, 0, 28)
    _MLM6FlthVVlxBY4tYfh6KW.BackgroundTransparency = 1
    _MLM6FlthVVlxBY4tYfh6KW.Parent = _duhhtyvg5a2PYEzV8RGwEY
    local _bKlmespgr5Y8SqooRsxf8E = Instance.new("Frame")
    _bKlmespgr5Y8SqooRsxf8E.Name = "ReceivedContainer"
    _bKlmespgr5Y8SqooRsxf8E.Size = UDim2.new(0.33, 0, 1, 0)
    _bKlmespgr5Y8SqooRsxf8E.Position = UDim2.new(0, 0, 0, 0)
    _bKlmespgr5Y8SqooRsxf8E.BackgroundTransparency = 1
    _bKlmespgr5Y8SqooRsxf8E.Parent = _MLM6FlthVVlxBY4tYfh6KW
    local _11hsJfk739nVIXRlqxTsxo = Instance.new("TextLabel")
    _11hsJfk739nVIXRlqxTsxo.Name = "ReceivedLabel"
    _11hsJfk739nVIXRlqxTsxo.Size = UDim2.new(0, 55, 1, 0)
    _11hsJfk739nVIXRlqxTsxo.Position = UDim2.new(0, 0, 0, 0)
    _11hsJfk739nVIXRlqxTsxo.BackgroundTransparency = 1
    _11hsJfk739nVIXRlqxTsxo.Text = "Received:"
    _11hsJfk739nVIXRlqxTsxo.TextColor3 = Color3.fromRGB(180, 180, 180)
    _11hsJfk739nVIXRlqxTsxo.TextSize = 12
    _11hsJfk739nVIXRlqxTsxo.Font = Enum.Font.Gotham
    _11hsJfk739nVIXRlqxTsxo.TextXAlignment = Enum.TextXAlignment.Left
    _11hsJfk739nVIXRlqxTsxo.Parent = _bKlmespgr5Y8SqooRsxf8E
    local _uZJiTMe2jo8BbmhCBiNPny = Instance.new("TextLabel")
    _uZJiTMe2jo8BbmhCBiNPny.Name = "ReceivedValue"
    _uZJiTMe2jo8BbmhCBiNPny.Size = UDim2.new(1, -60, 1, 0)
    _uZJiTMe2jo8BbmhCBiNPny.Position = UDim2.new(0, 60, 0, 0)
    _uZJiTMe2jo8BbmhCBiNPny.BackgroundTransparency = 1
    _uZJiTMe2jo8BbmhCBiNPny.Text = "0"
    _uZJiTMe2jo8BbmhCBiNPny.TextColor3 = Color3.fromRGB(230, 230, 230)
    _uZJiTMe2jo8BbmhCBiNPny.TextSize = 12
    _uZJiTMe2jo8BbmhCBiNPny.Font = Enum.Font.GothamBold
    _uZJiTMe2jo8BbmhCBiNPny.TextXAlignment = Enum.TextXAlignment.Left
    _uZJiTMe2jo8BbmhCBiNPny.Parent = _bKlmespgr5Y8SqooRsxf8E
    local _ZiFT3D972p6sxXijWH3YAd = Instance.new("Frame")
    _ZiFT3D972p6sxXijWH3YAd.Name = "DonatedContainer"
    _ZiFT3D972p6sxXijWH3YAd.Size = UDim2.new(0.33, 0, 1, 0)
    _ZiFT3D972p6sxXijWH3YAd.Position = UDim2.new(0.33, -2, 0, 0)
    _ZiFT3D972p6sxXijWH3YAd.BackgroundTransparency = 1
    _ZiFT3D972p6sxXijWH3YAd.Parent = _MLM6FlthVVlxBY4tYfh6KW
    local _ypPP9wh9Z6Y7SSZdL000Lb = Instance.new("Frame")
    _ypPP9wh9Z6Y7SSZdL000Lb.Name = "TimeContainer"
    _ypPP9wh9Z6Y7SSZdL000Lb.Size = UDim2.new(0.34, 0, 1, 0)
    _ypPP9wh9Z6Y7SSZdL000Lb.Position = UDim2.new(0.66, 0, 0, 0)
    _ypPP9wh9Z6Y7SSZdL000Lb.BackgroundTransparency = 1
    _ypPP9wh9Z6Y7SSZdL000Lb.Parent = _MLM6FlthVVlxBY4tYfh6KW
    local _3a8TdqNJvxTbMz2LOq5baT = Instance.new("TextLabel")
    _3a8TdqNJvxTbMz2LOq5baT.Name = "TimeLabel"
    _3a8TdqNJvxTbMz2LOq5baT.Size = UDim2.new(0, 50, 1, 0)
    _3a8TdqNJvxTbMz2LOq5baT.Position = UDim2.new(0, 0, 0, 0)
    _3a8TdqNJvxTbMz2LOq5baT.BackgroundTransparency = 1
    _3a8TdqNJvxTbMz2LOq5baT.Text = "Time:"
    _3a8TdqNJvxTbMz2LOq5baT.TextColor3 = Color3.fromRGB(180, 180, 180)
    _3a8TdqNJvxTbMz2LOq5baT.TextSize = 12
    _3a8TdqNJvxTbMz2LOq5baT.Font = Enum.Font.Gotham
    _3a8TdqNJvxTbMz2LOq5baT.TextXAlignment = Enum.TextXAlignment.Left
    _3a8TdqNJvxTbMz2LOq5baT.Parent = _ypPP9wh9Z6Y7SSZdL000Lb
    local _sqZoplptkmeVf3Coy2a2Uz = Instance.new("TextLabel")
    _sqZoplptkmeVf3Coy2a2Uz.Name = "TimeValue"
    _sqZoplptkmeVf3Coy2a2Uz.Size = UDim2.new(1, -55, 1, 0)
    _sqZoplptkmeVf3Coy2a2Uz.Position = UDim2.new(0, 55, 0, 0)
    _sqZoplptkmeVf3Coy2a2Uz.BackgroundTransparency = 1
    _sqZoplptkmeVf3Coy2a2Uz.Text = "0m"
    _sqZoplptkmeVf3Coy2a2Uz.TextColor3 = Color3.fromRGB(230, 230, 230)
    _sqZoplptkmeVf3Coy2a2Uz.TextSize = 12
    _sqZoplptkmeVf3Coy2a2Uz.Font = Enum.Font.GothamBold
    _sqZoplptkmeVf3Coy2a2Uz.TextXAlignment = Enum.TextXAlignment.Left
    _sqZoplptkmeVf3Coy2a2Uz.Parent = _ypPP9wh9Z6Y7SSZdL000Lb
    local _Aze4wrWRQ8xKaqsIHK7EIn = Instance.new("TextLabel")
    _Aze4wrWRQ8xKaqsIHK7EIn.Name = "DonatedLabel"
    _Aze4wrWRQ8xKaqsIHK7EIn.Size = UDim2.new(0, 55, 1, 0)
    _Aze4wrWRQ8xKaqsIHK7EIn.Position = UDim2.new(0, 0, 0, 0)
    _Aze4wrWRQ8xKaqsIHK7EIn.BackgroundTransparency = 1
    _Aze4wrWRQ8xKaqsIHK7EIn.Text = "Donated:"
    _Aze4wrWRQ8xKaqsIHK7EIn.TextColor3 = Color3.fromRGB(180, 180, 180)
    _Aze4wrWRQ8xKaqsIHK7EIn.TextSize = 12
    _Aze4wrWRQ8xKaqsIHK7EIn.Font = Enum.Font.Gotham
    _Aze4wrWRQ8xKaqsIHK7EIn.TextXAlignment = Enum.TextXAlignment.Left
    _Aze4wrWRQ8xKaqsIHK7EIn.Parent = _ZiFT3D972p6sxXijWH3YAd
    local _S6caHhOnW519PlsEXo7nSl = Instance.new("TextLabel")
    _S6caHhOnW519PlsEXo7nSl.Name = "DonatedValue"
    _S6caHhOnW519PlsEXo7nSl.Size = UDim2.new(1, -60, 1, 0)
    _S6caHhOnW519PlsEXo7nSl.Position = UDim2.new(0, 60, 0, 0)
    _S6caHhOnW519PlsEXo7nSl.BackgroundTransparency = 1
    _S6caHhOnW519PlsEXo7nSl.Text = "0"
    _S6caHhOnW519PlsEXo7nSl.TextColor3 = Color3.fromRGB(230, 230, 230)
    _S6caHhOnW519PlsEXo7nSl.TextSize = 12
    _S6caHhOnW519PlsEXo7nSl.Font = Enum.Font.GothamBold
    _S6caHhOnW519PlsEXo7nSl.TextXAlignment = Enum.TextXAlignment.Left
    _S6caHhOnW519PlsEXo7nSl.Parent = _ZiFT3D972p6sxXijWH3YAd
    local function _UT4UghuXB0uVve3p1spZb2()
        if not _3VUJ8SiQbUz6exE1M0KCLV(_LovOfbaPAgtCeey8jCuEVQ) then
            _11hsJfk739nVIXRlqxTsxo.Text = "Doesn't own Tip Jar"
            _uZJiTMe2jo8BbmhCBiNPny.Text = ""
            _uZJiTMe2jo8BbmhCBiNPny.TextColor3 = Color3.fromRGB(150, 150, 150)
            return
        end
        _11hsJfk739nVIXRlqxTsxo.Text = "Received:"
        local _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("TipJarStats")
        if not _Ae7vISWaNHvb31mAIQfuJr then
            _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:WaitForChild("TipJarStats", 1)
        end
        if _Ae7vISWaNHvb31mAIQfuJr then
            local _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr.Raised
            if not _dxbusk3cmLdj8aqj5RJbAD then
                _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Raised")
            end
            local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
            if not _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
            end
            if _dxbusk3cmLdj8aqj5RJbAD then
                if _dxbusk3cmLdj8aqj5RJbAD:IsA("IntValue") or _dxbusk3cmLdj8aqj5RJbAD:IsA("NumberValue") then
                    local _VfPDz5GJznUmh17oHwfVUK = _dxbusk3cmLdj8aqj5RJbAD.Value
                    local _gyPmTcHBSOeX5g1zbjY3jz = tostring(_VfPDz5GJznUmh17oHwfVUK)
                    local _GGCVFMRapXYdnLaIr32qPl = math.floor(_VfPDz5GJznUmh17oHwfVUK * 0.6)
                    _gyPmTcHBSOeX5g1zbjY3jz = _gyPmTcHBSOeX5g1zbjY3jz .. " (" .. tostring(_GGCVFMRapXYdnLaIr32qPl) .. ")"
                    _uZJiTMe2jo8BbmhCBiNPny.Text = _gyPmTcHBSOeX5g1zbjY3jz
                    _uZJiTMe2jo8BbmhCBiNPny.TextColor3 = Color3.fromRGB(230, 230, 230)
                    return
                end
            end
        end
        _uZJiTMe2jo8BbmhCBiNPny.Text = "0"
        _uZJiTMe2jo8BbmhCBiNPny.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
    local function _bbnJIuAnWy59UVUBaTyVmR()
        local _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("TipJarStats")
        if not _Ae7vISWaNHvb31mAIQfuJr then
            _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:WaitForChild("TipJarStats", 1)
        end
        if _Ae7vISWaNHvb31mAIQfuJr then
            local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
            if not _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
            end
            if _ZKi3dfVVGlvV4TM9u0f6bf then
                if _ZKi3dfVVGlvV4TM9u0f6bf:IsA("IntValue") or _ZKi3dfVVGlvV4TM9u0f6bf:IsA("NumberValue") then
                    _S6caHhOnW519PlsEXo7nSl.Text = tostring(_ZKi3dfVVGlvV4TM9u0f6bf.Value)
                    _S6caHhOnW519PlsEXo7nSl.TextColor3 = Color3.fromRGB(230, 230, 230)
                    return
                end
            end
        end
        _S6caHhOnW519PlsEXo7nSl.Text = "0"
        _S6caHhOnW519PlsEXo7nSl.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
    local function _a3UcL3ZWmSt3RhKe2HAgV0()
        local _CRhs1xmXzXmdFn625mLemE = nil
        local _3z4wkr9prc8ygzJ49T0Iy9 = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("Minutes")
        if _3z4wkr9prc8ygzJ49T0Iy9 then
            _CRhs1xmXzXmdFn625mLemE = _3z4wkr9prc8ygzJ49T0Iy9
        else
            local _enjHRmbSlKjPkCFZNCpxE8 = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("_enjHRmbSlKjPkCFZNCpxE8")
            if _enjHRmbSlKjPkCFZNCpxE8 then
                _CRhs1xmXzXmdFn625mLemE = _enjHRmbSlKjPkCFZNCpxE8:FindFirstChild("Minutes")
            end
        end
        if _CRhs1xmXzXmdFn625mLemE then
            local _fmfHPt1JO3vhGn6muT6JNS = _CRhs1xmXzXmdFn625mLemE.Value
            if _fmfHPt1JO3vhGn6muT6JNS >= 60 then
                local _pqkLMiOVKqDAySJCleSQNm = math.floor(_fmfHPt1JO3vhGn6muT6JNS / 60)
                local _C5px8HiW0KsiiHABEgfm5A = _fmfHPt1JO3vhGn6muT6JNS % 60
                _sqZoplptkmeVf3Coy2a2Uz.Text = _pqkLMiOVKqDAySJCleSQNm .. "h " .. _C5px8HiW0KsiiHABEgfm5A .. "m (" .. _fmfHPt1JO3vhGn6muT6JNS .. ")"
            else
                _sqZoplptkmeVf3Coy2a2Uz.Text = _fmfHPt1JO3vhGn6muT6JNS .. "m (" .. _fmfHPt1JO3vhGn6muT6JNS .. ")"
            end
            _sqZoplptkmeVf3Coy2a2Uz.TextColor3 = Color3.fromRGB(230, 230, 230)
        else
            _sqZoplptkmeVf3Coy2a2Uz.Text = "0m (0)"
            _sqZoplptkmeVf3Coy2a2Uz.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end
    _UT4UghuXB0uVve3p1spZb2()
    _bbnJIuAnWy59UVUBaTyVmR()
    _a3UcL3ZWmSt3RhKe2HAgV0()
    _2L7NkdEYutvmUFgtv7mjdx[_LovOfbaPAgtCeey8jCuEVQ.Name] = {
        updateReceived = updateReceived,
        updateDonated = updateDonated,
        updateTime = updateTime
    }
    spawn(function()
        local _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("TipJarStats")
        if not _Ae7vISWaNHvb31mAIQfuJr then
            _Ae7vISWaNHvb31mAIQfuJr = _LovOfbaPAgtCeey8jCuEVQ:WaitForChild("TipJarStats", 10)
        end
        if _Ae7vISWaNHvb31mAIQfuJr then
            local _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr.Raised
            if _dxbusk3cmLdj8aqj5RJbAD then
                _UT4UghuXB0uVve3p1spZb2()
                _dxbusk3cmLdj8aqj5RJbAD:GetPropertyChangedSignal("Value"):Connect(updateReceived)
            else
                _dxbusk3cmLdj8aqj5RJbAD = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Raised")
                if _dxbusk3cmLdj8aqj5RJbAD then
                    _UT4UghuXB0uVve3p1spZb2()
                    _dxbusk3cmLdj8aqj5RJbAD:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                else
                    local success, _eKTxAJGhWv60Q3NzobjTpg = pcall(function()
                        return _Ae7vISWaNHvb31mAIQfuJr:WaitForChild("Raised", 5)
                    end)
                    if success and _eKTxAJGhWv60Q3NzobjTpg then
                        _dxbusk3cmLdj8aqj5RJbAD = _eKTxAJGhWv60Q3NzobjTpg
                        _UT4UghuXB0uVve3p1spZb2()
                        _dxbusk3cmLdj8aqj5RJbAD:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                    else
                        _Ae7vISWaNHvb31mAIQfuJr.ChildAdded:Connect(function(child)
                            if child.Name == "Raised" then
                                _UT4UghuXB0uVve3p1spZb2()
                                child:GetPropertyChangedSignal("Value"):Connect(updateReceived)
                            end
                        end)
                        _UT4UghuXB0uVve3p1spZb2()
                    end
                end
            end
            _bbnJIuAnWy59UVUBaTyVmR()
            local _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr.Donated
            if not _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf = _Ae7vISWaNHvb31mAIQfuJr:FindFirstChild("Donated")
            end
            if _ZKi3dfVVGlvV4TM9u0f6bf then
                _ZKi3dfVVGlvV4TM9u0f6bf:GetPropertyChangedSignal("Value"):Connect(updateDonated)
            else
                local success, _eKTxAJGhWv60Q3NzobjTpg = pcall(function()
                    return _Ae7vISWaNHvb31mAIQfuJr:WaitForChild("Donated", 5)
                end)
                if success and _eKTxAJGhWv60Q3NzobjTpg then
                    _ZKi3dfVVGlvV4TM9u0f6bf = _eKTxAJGhWv60Q3NzobjTpg
                    _bbnJIuAnWy59UVUBaTyVmR()
                    _ZKi3dfVVGlvV4TM9u0f6bf:GetPropertyChangedSignal("Value"):Connect(updateDonated)
                end
            end
        end
        local _CRhs1xmXzXmdFn625mLemE = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("Minutes")
        if not _CRhs1xmXzXmdFn625mLemE then
            local _enjHRmbSlKjPkCFZNCpxE8 = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("_enjHRmbSlKjPkCFZNCpxE8")
            if not _enjHRmbSlKjPkCFZNCpxE8 then
                _enjHRmbSlKjPkCFZNCpxE8 = _LovOfbaPAgtCeey8jCuEVQ:WaitForChild("_enjHRmbSlKjPkCFZNCpxE8", 10)
            end
            if _enjHRmbSlKjPkCFZNCpxE8 then
                _CRhs1xmXzXmdFn625mLemE = _enjHRmbSlKjPkCFZNCpxE8:FindFirstChild("Minutes")
            end
        end
        if _CRhs1xmXzXmdFn625mLemE then
            _a3UcL3ZWmSt3RhKe2HAgV0()
            _CRhs1xmXzXmdFn625mLemE:GetPropertyChangedSignal("Value"):Connect(updateTime)
        end
        local _eFeI6z5h3sgZdZDgySG4fN = _LovOfbaPAgtCeey8jCuEVQ:FindFirstChild("Backpack")
        if not _eFeI6z5h3sgZdZDgySG4fN then
            _eFeI6z5h3sgZdZDgySG4fN = _LovOfbaPAgtCeey8jCuEVQ:WaitForChild("Backpack", 10)
        end
        if _eFeI6z5h3sgZdZDgySG4fN then
            _eFeI6z5h3sgZdZDgySG4fN.ChildAdded:Connect(function(child)
                if child.Name == "TipJar" then
                    _wZfqLs3LjJppkdDdMw1wsB(_LovOfbaPAgtCeey8jCuEVQ)
                    _UT4UghuXB0uVve3p1spZb2()
                end
            end)
            _eFeI6z5h3sgZdZDgySG4fN.ChildRemoved:Connect(function(child)
                if child.Name == "TipJar" then
                    _wZfqLs3LjJppkdDdMw1wsB(_LovOfbaPAgtCeey8jCuEVQ)
                    _UT4UghuXB0uVve3p1spZb2()
                end
            end)
        end
    end)
    return _duhhtyvg5a2PYEzV8RGwEY
end
local function _93s5gZjmUQg52mBiqNfiPs()
    for _wl1OX72rRU771TA0U2nWek, updateFuncs in pairs(_2L7NkdEYutvmUFgtv7mjdx) do
        if updateFuncs.updateReceived then
            updateFuncs._UT4UghuXB0uVve3p1spZb2()
        end
        if updateFuncs.updateDonated then
            updateFuncs._bbnJIuAnWy59UVUBaTyVmR()
        end
        if updateFuncs.updateTime then
            updateFuncs._a3UcL3ZWmSt3RhKe2HAgV0()
        end
    end
end
local _dbS1WaR8sbtxdLKGmbj7I6 = ""
local _ySumpCBTV49AGluflTVWm3 = nil
local _ksLFBdwalaCrc1QZRs67xB = nil
local _PLCV5hlw2eqdVnC8ul8tPd = nil
local _fAs4ou8wOen1AghOaAI9zm = nil
local function _OCrjlfeTlEE3bOfBVrAw4q(_ZUJqIJBKsK862gJS9EShI7)
    _ZUJqIJBKsK862gJS9EShI7 = _ZUJqIJBKsK862gJS9EShI7 or ""
    _ZUJqIJBKsK862gJS9EShI7 = string.lower(_ZUJqIJBKsK862gJS9EShI7)
    for _, child in pairs(_d75So8o8erdtGFSA4AQfW7:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "UIListLayout" and child.Name ~= "UIPadding" then
            _2L7NkdEYutvmUFgtv7mjdx[child.Name] = nil
            child:Destroy()
        end
    end
    for _, _LovOfbaPAgtCeey8jCuEVQ in pairs(Players:GetPlayers()) do
        local _wl1OX72rRU771TA0U2nWek = string.lower(_LovOfbaPAgtCeey8jCuEVQ.Name)
        local _JicNv0VjnCZ1NKP5516Juu = string.lower(_LovOfbaPAgtCeey8jCuEVQ.DisplayName)
        if _ZUJqIJBKsK862gJS9EShI7 == "" or string.find(_wl1OX72rRU771TA0U2nWek, _ZUJqIJBKsK862gJS9EShI7, 1, true) or string.find(_JicNv0VjnCZ1NKP5516Juu, _ZUJqIJBKsK862gJS9EShI7, 1, true) then
            _ugArf3HxbMMw0yyUJ4txqh(_LovOfbaPAgtCeey8jCuEVQ)
        end
    end
    task.wait()
    local _TsvDvT7RrfM9UEsk7Xq1XT = _QCTFbMebAo92ycQ4E7TDJ4.AbsoluteContentSize
    _d75So8o8erdtGFSA4AQfW7.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 16)
end
local _anC3rNxjS7cuRQyNc4FnWq = nil
local _kRTH5Lo16lqrxZRekUBUP1 = nil
local _trf9WxTVolwVnFHi2kQlXW = nil
_IXyykbQnn8nQE0PddYhrTs = function(skipAnimation)
    local _OlzKqZfbS8vacowf53OABs = _ksLFBdwalaCrc1QZRs67xB
    if not _OlzKqZfbS8vacowf53OABs then
        _OlzKqZfbS8vacowf53OABs = _xmVJGdBcbIclOrYzVq8q5t:FindFirstChild("SearchFrame")
        if _OlzKqZfbS8vacowf53OABs then
            _ksLFBdwalaCrc1QZRs67xB = _OlzKqZfbS8vacowf53OABs
        end
    end
    if not _OlzKqZfbS8vacowf53OABs or not _OlzKqZfbS8vacowf53OABs.Visible then
        return
    end
    if _kRTH5Lo16lqrxZRekUBUP1 then
        _kRTH5Lo16lqrxZRekUBUP1:Cancel()
        _kRTH5Lo16lqrxZRekUBUP1 = nil
    end
    if _anC3rNxjS7cuRQyNc4FnWq then
        _anC3rNxjS7cuRQyNc4FnWq:Cancel()
        _anC3rNxjS7cuRQyNc4FnWq = nil
    end
    if _trf9WxTVolwVnFHi2kQlXW then
        _trf9WxTVolwVnFHi2kQlXW:Cancel()
        _trf9WxTVolwVnFHi2kQlXW = nil
    end
    if skipAnimation or not _OlzKqZfbS8vacowf53OABs.Visible then
        _OlzKqZfbS8vacowf53OABs.Visible = false
        _OlzKqZfbS8vacowf53OABs.Size = UDim2.new(1, -20, 0, 35)
        _OlzKqZfbS8vacowf53OABs.BackgroundTransparency = 0
    end
    if _d75So8o8erdtGFSA4AQfW7 then
        _d75So8o8erdtGFSA4AQfW7.Position = UDim2.new(0, 10, 0, 50)
        _d75So8o8erdtGFSA4AQfW7.Size = UDim2.new(1, -20, 1, -65)
    end
    _dbS1WaR8sbtxdLKGmbj7I6 = ""
    if _ySumpCBTV49AGluflTVWm3 then
        _ySumpCBTV49AGluflTVWm3.Text = ""
        _ySumpCBTV49AGluflTVWm3:ReleaseFocus()
    end
    if _fAs4ou8wOen1AghOaAI9zm then
        _fAs4ou8wOen1AghOaAI9zm.Visible = false
    end
    _OCrjlfeTlEE3bOfBVrAw4q("")
end
local function _vOyk7Lao5rfpawUEuWV3Ma()
    if _sg3OAQ4e8v2XYKYhGZ6XjV then
        return
    end
    if _ksLFBdwalaCrc1QZRs67xB and _ksLFBdwalaCrc1QZRs67xB.Visible then
        if _kRTH5Lo16lqrxZRekUBUP1 then
            _kRTH5Lo16lqrxZRekUBUP1:Cancel()
            _kRTH5Lo16lqrxZRekUBUP1 = nil
        end
        _anC3rNxjS7cuRQyNc4FnWq = TweenService:Create(
            _ksLFBdwalaCrc1QZRs67xB,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
            {
                Size = UDim2.new(1, -20, 0, 0),
                BackgroundTransparency = 1
            }
        )
        _anC3rNxjS7cuRQyNc4FnWq:Play()
        _anC3rNxjS7cuRQyNc4FnWq.Completed:Connect(function()
            _ksLFBdwalaCrc1QZRs67xB.Visible = false
            _ksLFBdwalaCrc1QZRs67xB.Size = UDim2.new(1, -20, 0, 35)
            _ksLFBdwalaCrc1QZRs67xB.BackgroundTransparency = 0
            _anC3rNxjS7cuRQyNc4FnWq = nil
        end)
        _dbS1WaR8sbtxdLKGmbj7I6 = ""
        if _ySumpCBTV49AGluflTVWm3 then
            _ySumpCBTV49AGluflTVWm3.Text = ""
        end
        if _fAs4ou8wOen1AghOaAI9zm then
            _fAs4ou8wOen1AghOaAI9zm.Visible = false
        end
        _trf9WxTVolwVnFHi2kQlXW = TweenService:Create(
            _d75So8o8erdtGFSA4AQfW7,
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(0, 10, 0, 50),
                Size = UDim2.new(1, -20, 1, -65)
            }
        )
        _trf9WxTVolwVnFHi2kQlXW:Play()
        _trf9WxTVolwVnFHi2kQlXW.Completed:Connect(function()
            _trf9WxTVolwVnFHi2kQlXW = nil
        end)
        _OCrjlfeTlEE3bOfBVrAw4q("")
    else
        if not _ksLFBdwalaCrc1QZRs67xB then
            _ksLFBdwalaCrc1QZRs67xB = Instance.new("Frame")
            _ksLFBdwalaCrc1QZRs67xB.Name = "SearchFrame"
            _ksLFBdwalaCrc1QZRs67xB.Size = UDim2.new(1, -20, 0, 0)
            _ksLFBdwalaCrc1QZRs67xB.Position = UDim2.new(0, 10, 0, 50)
            _ksLFBdwalaCrc1QZRs67xB.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            _ksLFBdwalaCrc1QZRs67xB.BackgroundTransparency = 1
            _ksLFBdwalaCrc1QZRs67xB.BorderSizePixel = 0
            _ksLFBdwalaCrc1QZRs67xB.Visible = true
            _ksLFBdwalaCrc1QZRs67xB.Parent = _xmVJGdBcbIclOrYzVq8q5t
            _ksLFBdwalaCrc1QZRs67xB.ZIndex = 5
            local _deV8JLkDPXY4mG8lKIrpuO = Instance.new("UICorner")
            _deV8JLkDPXY4mG8lKIrpuO.CornerRadius = UDim.new(0, 6)
            _deV8JLkDPXY4mG8lKIrpuO.Parent = _ksLFBdwalaCrc1QZRs67xB
            local _xHsk9ikfn4T9icBCMzJBLa = Instance.new("UIStroke")
            _xHsk9ikfn4T9icBCMzJBLa.Color = Color3.fromRGB(50, 50, 50)
            _xHsk9ikfn4T9icBCMzJBLa.Thickness = 1
            _xHsk9ikfn4T9icBCMzJBLa.Transparency = 0.3
            _xHsk9ikfn4T9icBCMzJBLa.Parent = _ksLFBdwalaCrc1QZRs67xB
            _ySumpCBTV49AGluflTVWm3 = Instance.new("TextBox")
            _ySumpCBTV49AGluflTVWm3.Name = "SearchTextBox"
            _ySumpCBTV49AGluflTVWm3.Size = UDim2.new(1, -40, 1, -10)
            _ySumpCBTV49AGluflTVWm3.Position = UDim2.new(0, 5, 0, 5)
            _ySumpCBTV49AGluflTVWm3.BackgroundTransparency = 1
            _ySumpCBTV49AGluflTVWm3.Text = ""
            _ySumpCBTV49AGluflTVWm3.PlaceholderText = "Search players..."
            _ySumpCBTV49AGluflTVWm3.TextColor3 = Color3.fromRGB(240, 240, 240)
            _ySumpCBTV49AGluflTVWm3.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            _ySumpCBTV49AGluflTVWm3.TextSize = 14
            _ySumpCBTV49AGluflTVWm3.Font = Enum.Font.Gotham
            _ySumpCBTV49AGluflTVWm3.TextXAlignment = Enum.TextXAlignment.Left
            _ySumpCBTV49AGluflTVWm3.ClearTextOnFocus = false
            _ySumpCBTV49AGluflTVWm3.Parent = _ksLFBdwalaCrc1QZRs67xB
            _fAs4ou8wOen1AghOaAI9zm = Instance.new("TextButton")
            _fAs4ou8wOen1AghOaAI9zm.Name = "ClearButton"
            _fAs4ou8wOen1AghOaAI9zm.Size = UDim2.new(0, 25, 0, 25)
            _fAs4ou8wOen1AghOaAI9zm.AnchorPoint = Vector2.new(1, 0.5)
            _fAs4ou8wOen1AghOaAI9zm.Position = UDim2.new(1, -5, 0.5, 0)
            _fAs4ou8wOen1AghOaAI9zm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            _fAs4ou8wOen1AghOaAI9zm.Text = "×"
            _fAs4ou8wOen1AghOaAI9zm.TextColor3 = Color3.fromRGB(200, 200, 200)
            _fAs4ou8wOen1AghOaAI9zm.TextSize = 18
            _fAs4ou8wOen1AghOaAI9zm.Font = Enum.Font.GothamBold
            _fAs4ou8wOen1AghOaAI9zm.BorderSizePixel = 0
            _fAs4ou8wOen1AghOaAI9zm.Visible = false
            _fAs4ou8wOen1AghOaAI9zm.Parent = _ksLFBdwalaCrc1QZRs67xB
            _fAs4ou8wOen1AghOaAI9zm.ZIndex = _ksLFBdwalaCrc1QZRs67xB.ZIndex + 1
            local _QnrayTl5K91spW9QudsDSo = Instance.new("UICorner")
            _QnrayTl5K91spW9QudsDSo.CornerRadius = UDim.new(0, 4)
            _QnrayTl5K91spW9QudsDSo.Parent = _fAs4ou8wOen1AghOaAI9zm
            _fAs4ou8wOen1AghOaAI9zm.MouseEnter:Connect(function()
                _fAs4ou8wOen1AghOaAI9zm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
            _fAs4ou8wOen1AghOaAI9zm.MouseLeave:Connect(function()
                _fAs4ou8wOen1AghOaAI9zm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
            _fAs4ou8wOen1AghOaAI9zm.MouseButton1Click:Connect(function()
                _ySumpCBTV49AGluflTVWm3.Text = ""
                _dbS1WaR8sbtxdLKGmbj7I6 = ""
                _OCrjlfeTlEE3bOfBVrAw4q("")
            end)
            local function _jnp8zOi6OTA6rp0ui7SQe3()
                if _fAs4ou8wOen1AghOaAI9zm then
                    _fAs4ou8wOen1AghOaAI9zm.Visible = _ySumpCBTV49AGluflTVWm3.Text ~= ""
                end
            end
            _ySumpCBTV49AGluflTVWm3:GetPropertyChangedSignal("Text"):Connect(function()
                _dbS1WaR8sbtxdLKGmbj7I6 = _ySumpCBTV49AGluflTVWm3.Text
                _jnp8zOi6OTA6rp0ui7SQe3()
                if _PLCV5hlw2eqdVnC8ul8tPd then
                    task.cancel(_PLCV5hlw2eqdVnC8ul8tPd)
                end
                _PLCV5hlw2eqdVnC8ul8tPd = task.delay(0.3, function()
                    _OCrjlfeTlEE3bOfBVrAw4q(_dbS1WaR8sbtxdLKGmbj7I6)
                    _PLCV5hlw2eqdVnC8ul8tPd = nil
                end)
            end)
        end
        if _anC3rNxjS7cuRQyNc4FnWq then
            _anC3rNxjS7cuRQyNc4FnWq:Cancel()
            _anC3rNxjS7cuRQyNc4FnWq = nil
        end
        _ksLFBdwalaCrc1QZRs67xB.Visible = true
        _kRTH5Lo16lqrxZRekUBUP1 = TweenService:Create(
            _ksLFBdwalaCrc1QZRs67xB,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Size = UDim2.new(1, -20, 0, 35),
                BackgroundTransparency = 0
            }
        )
        _kRTH5Lo16lqrxZRekUBUP1:Play()
        _trf9WxTVolwVnFHi2kQlXW = TweenService:Create(
            _d75So8o8erdtGFSA4AQfW7,
            TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {
                Position = UDim2.new(0, 10, 0, 90),
                Size = UDim2.new(1, -20, 1, -105)
            }
        )
        _trf9WxTVolwVnFHi2kQlXW:Play()
        _trf9WxTVolwVnFHi2kQlXW.Completed:Connect(function()
            _trf9WxTVolwVnFHi2kQlXW = nil
        end)
        _kRTH5Lo16lqrxZRekUBUP1.Completed:Connect(function()
            if _ySumpCBTV49AGluflTVWm3 then
                _ySumpCBTV49AGluflTVWm3:CaptureFocus()
            end
            _kRTH5Lo16lqrxZRekUBUP1 = nil
        end)
    end
end
_2O0nArsovay1CWxl6uAfTJ.MouseButton1Click:Connect(toggleSearch)
_QCTFbMebAo92ycQ4E7TDJ4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    local _TsvDvT7RrfM9UEsk7Xq1XT = _QCTFbMebAo92ycQ4E7TDJ4.AbsoluteContentSize
    _d75So8o8erdtGFSA4AQfW7.CanvasSize = UDim2.new(0, 0, 0, _TsvDvT7RrfM9UEsk7Xq1XT.Y + 16)
end)
Players.PlayerAdded:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
    if _dbS1WaR8sbtxdLKGmbj7I6 == "" then
        _ugArf3HxbMMw0yyUJ4txqh(_LovOfbaPAgtCeey8jCuEVQ)
    else
        local _wl1OX72rRU771TA0U2nWek = string.lower(_LovOfbaPAgtCeey8jCuEVQ.Name)
        local _JicNv0VjnCZ1NKP5516Juu = string.lower(_LovOfbaPAgtCeey8jCuEVQ.DisplayName)
        local _ZUJqIJBKsK862gJS9EShI7 = string.lower(_dbS1WaR8sbtxdLKGmbj7I6)
        if string.find(_wl1OX72rRU771TA0U2nWek, _ZUJqIJBKsK862gJS9EShI7, 1, true) or string.find(_JicNv0VjnCZ1NKP5516Juu, _ZUJqIJBKsK862gJS9EShI7, 1, true) then
            _ugArf3HxbMMw0yyUJ4txqh(_LovOfbaPAgtCeey8jCuEVQ)
        end
    end
end)
Players.PlayerRemoving:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
    if _eQ1LgYgAj9WUcCOhzqsiHH == _LovOfbaPAgtCeey8jCuEVQ then
        _LJMsyyY9wjwFjMRGpDg6Z5()
    end
    if _KyudF1wlqenY1Uo94R3Tmd == _LovOfbaPAgtCeey8jCuEVQ then
        _GzXUBXZiCSdAUJ8pFEGVzo(nil)
    end
    _zwRPN1TBVKYtqVoGZssxzz(_LovOfbaPAgtCeey8jCuEVQ)
    _r2kZoFKq2558xNdCs6TLxN(_LovOfbaPAgtCeey8jCuEVQ, false)
    _4BCSgFFhJWBhTSV5VX04Bp[_LovOfbaPAgtCeey8jCuEVQ] = nil
    if _JD0uC72q64U8mpRIsEg2iz[_LovOfbaPAgtCeey8jCuEVQ] then
        for _, conn in ipairs(_JD0uC72q64U8mpRIsEg2iz[_LovOfbaPAgtCeey8jCuEVQ]) do
            conn:Disconnect()
        end
        _JD0uC72q64U8mpRIsEg2iz[_LovOfbaPAgtCeey8jCuEVQ] = nil
    end
    local _8wONErhhR10gBUqJoqecwq = _d75So8o8erdtGFSA4AQfW7:FindFirstChild(_LovOfbaPAgtCeey8jCuEVQ.Name)
    if _8wONErhhR10gBUqJoqecwq then
        _2L7NkdEYutvmUFgtv7mjdx[_LovOfbaPAgtCeey8jCuEVQ.Name] = nil
        _8wONErhhR10gBUqJoqecwq:Destroy()
    end
end)
_dx0PljZptJJQVhhAhCzzBe.MouseButton1Click:Connect(function()
    local _gJrgRkRcidM5fLaPBzrp1B = Players.LocalPlayer
    if _gJrgRkRcidM5fLaPBzrp1B then
        createPlayerInfoUI(_gJrgRkRcidM5fLaPBzrp1B)
    end
end)
local _Yp0aBqUjDoZogQEBR5k0qE = Instance.new("ScreenGui")
_Yp0aBqUjDoZogQEBR5k0qE.Name = "DonationNotificationGui"
_Yp0aBqUjDoZogQEBR5k0qE.ResetOnSpawn = false
_Yp0aBqUjDoZogQEBR5k0qE.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function()
    _Yp0aBqUjDoZogQEBR5k0qE.Parent = game:GetService("CoreGui")
end)
local function _k0bfh0VWn8H2kdL27vVjtX(donatorName, amount, receiverName)
    local _fEzGrnAYBEk55rYjRcYSy7 = nil
    for _, _LovOfbaPAgtCeey8jCuEVQ in ipairs(Players:GetPlayers()) do
        if _LovOfbaPAgtCeey8jCuEVQ.Name == donatorName or _LovOfbaPAgtCeey8jCuEVQ.DisplayName == donatorName then
            _fEzGrnAYBEk55rYjRcYSy7 = _LovOfbaPAgtCeey8jCuEVQ
            break
        end
    end
    local _K9WEWbqrFvZa4u3VZGQJbV = Instance.new("Frame")
    _K9WEWbqrFvZa4u3VZGQJbV.Name = "DonationNotification_" .. tick()
    _K9WEWbqrFvZa4u3VZGQJbV.Size = UDim2.new(0, 400, 0, 50)
    _K9WEWbqrFvZa4u3VZGQJbV.Position = UDim2.new(0.5, 0, 0, 15)
    _K9WEWbqrFvZa4u3VZGQJbV.AnchorPoint = Vector2.new(0.5, 0)
    _K9WEWbqrFvZa4u3VZGQJbV.BackgroundColor3 = Color3.fromRGB(40, 60, 40)
    _K9WEWbqrFvZa4u3VZGQJbV.BorderSizePixel = 0
    _K9WEWbqrFvZa4u3VZGQJbV.Parent = _Yp0aBqUjDoZogQEBR5k0qE
    _K9WEWbqrFvZa4u3VZGQJbV.ZIndex = 20
    local _xMTXpbeTMlXoxUsCDccRY5 = Instance.new("UICorner")
    _xMTXpbeTMlXoxUsCDccRY5.CornerRadius = UDim.new(0, 8)
    _xMTXpbeTMlXoxUsCDccRY5.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _4HeKKfYunLBZuH1bLgJ3mN = Instance.new("UIStroke")
    _4HeKKfYunLBZuH1bLgJ3mN.Color = Color3.fromRGB(100, 200, 100)
    _4HeKKfYunLBZuH1bLgJ3mN.Thickness = 3
    _4HeKKfYunLBZuH1bLgJ3mN.Transparency = 0
    _4HeKKfYunLBZuH1bLgJ3mN.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _04nHaSRrVKKJIYIicVJX3v = Instance.new("TextLabel")
    _04nHaSRrVKKJIYIicVJX3v.Name = "IconLabel"
    _04nHaSRrVKKJIYIicVJX3v.Size = UDim2.new(0, 30, 0, 30)
    _04nHaSRrVKKJIYIicVJX3v.Position = UDim2.new(0, 10, 0.5, -15)
    _04nHaSRrVKKJIYIicVJX3v.AnchorPoint = Vector2.new(0, 0.5)
    _04nHaSRrVKKJIYIicVJX3v.BackgroundTransparency = 1
    _04nHaSRrVKKJIYIicVJX3v.Text = "💰"
    _04nHaSRrVKKJIYIicVJX3v.TextColor3 = Color3.fromRGB(255, 215, 0)
    _04nHaSRrVKKJIYIicVJX3v.TextSize = 24
    _04nHaSRrVKKJIYIicVJX3v.Font = Enum.Font.GothamBold
    _04nHaSRrVKKJIYIicVJX3v.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    local _bWqKH4z0RRjENdGkYSOARB = Instance.new("TextLabel")
    _bWqKH4z0RRjENdGkYSOARB.Name = "TextLabel"
    _bWqKH4z0RRjENdGkYSOARB.Size = UDim2.new(1, -90, 1, -10)
    _bWqKH4z0RRjENdGkYSOARB.Position = UDim2.new(0, 45, 0, 5)
    _bWqKH4z0RRjENdGkYSOARB.BackgroundTransparency = 1
    _bWqKH4z0RRjENdGkYSOARB.Text = donatorName .. " _ZKi3dfVVGlvV4TM9u0f6bf " .. amount .. " Robux to " .. receiverName .. "!"
    _bWqKH4z0RRjENdGkYSOARB.TextColor3 = Color3.fromRGB(255, 255, 255)
    _bWqKH4z0RRjENdGkYSOARB.TextSize = 14
    _bWqKH4z0RRjENdGkYSOARB.Font = Enum.Font.GothamBold
    _bWqKH4z0RRjENdGkYSOARB.TextXAlignment = Enum.TextXAlignment.Left
    _bWqKH4z0RRjENdGkYSOARB.TextWrapped = true
    _bWqKH4z0RRjENdGkYSOARB.Parent = _K9WEWbqrFvZa4u3VZGQJbV
    if _fEzGrnAYBEk55rYjRcYSy7 then
        local _sS6OwQNLvQ2bUaKn76Gxwq = Instance.new("TextButton")
        _sS6OwQNLvQ2bUaKn76Gxwq.Name = "GotoButton"
        _sS6OwQNLvQ2bUaKn76Gxwq.Size = UDim2.new(0, 30, 0, 30)
        _sS6OwQNLvQ2bUaKn76Gxwq.Position = UDim2.new(1, -10, 0.5, -15)
        _sS6OwQNLvQ2bUaKn76Gxwq.AnchorPoint = Vector2.new(1, 0.5)
        _sS6OwQNLvQ2bUaKn76Gxwq.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        _sS6OwQNLvQ2bUaKn76Gxwq.Text = "→"
        _sS6OwQNLvQ2bUaKn76Gxwq.TextColor3 = Color3.fromRGB(220, 220, 220)
        _sS6OwQNLvQ2bUaKn76Gxwq.TextSize = 16
        _sS6OwQNLvQ2bUaKn76Gxwq.Font = Enum.Font.GothamBold
        _sS6OwQNLvQ2bUaKn76Gxwq.BorderSizePixel = 0
        _sS6OwQNLvQ2bUaKn76Gxwq.Parent = _K9WEWbqrFvZa4u3VZGQJbV
        local _au0p5sxgSWLxC2haEtS9G3 = Instance.new("UICorner")
        _au0p5sxgSWLxC2haEtS9G3.CornerRadius = UDim.new(0, 4)
        _au0p5sxgSWLxC2haEtS9G3.Parent = _sS6OwQNLvQ2bUaKn76Gxwq
        _sS6OwQNLvQ2bUaKn76Gxwq.MouseEnter:Connect(function()
            _sS6OwQNLvQ2bUaKn76Gxwq.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
        _sS6OwQNLvQ2bUaKn76Gxwq.MouseLeave:Connect(function()
            _sS6OwQNLvQ2bUaKn76Gxwq.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)
        _sS6OwQNLvQ2bUaKn76Gxwq.MouseButton1Click:Connect(function()
            _3JjyOPEoPFQCtpNbjitZzb(_fEzGrnAYBEk55rYjRcYSy7)
        end)
    end
    _K9WEWbqrFvZa4u3VZGQJbV.Size = UDim2.new(0, 0, 0, 50)
    _K9WEWbqrFvZa4u3VZGQJbV.BackgroundTransparency = 1
    local _gtamrxV1brx7OaCB7UGWEa = TweenService:Create(
        _K9WEWbqrFvZa4u3VZGQJbV,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 400, 0, 50), BackgroundTransparency = 0}
    )
    _gtamrxV1brx7OaCB7UGWEa:Play()
    task.delay(6, function()
        if _K9WEWbqrFvZa4u3VZGQJbV and _K9WEWbqrFvZa4u3VZGQJbV.Parent then
            local _9z246Pu9SjhDOKWYKLJmA3 = TweenService:Create(
                _K9WEWbqrFvZa4u3VZGQJbV,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 50), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0, 15)}
            )
            _9z246Pu9SjhDOKWYKLJmA3:Play()
            _9z246Pu9SjhDOKWYKLJmA3.Completed:Connect(function()
                if _K9WEWbqrFvZa4u3VZGQJbV then
                    _K9WEWbqrFvZa4u3VZGQJbV:Destroy()
                end
            end)
        end
    end)
end
local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
if _KCbu2Au1vAJIFqOuBflYpF then
    local function _gfYw5UEOxXF02QmagHhwwM(_NXDf15WGHv4zdyTFuuiM2w)
        spawn(function()
            task.wait(0.5)
            if not _NXDf15WGHv4zdyTFuuiM2w or not _NXDf15WGHv4zdyTFuuiM2w.Parent then
                return
            end
            local _nKrEOvVfSDdgYSpSeX9Vhb = _RJjERYng8mXMJfhQnnCyT2(_NXDf15WGHv4zdyTFuuiM2w)
            local _GGjPRafTbILOWDTPjEC7z0 = 0
            while not _nKrEOvVfSDdgYSpSeX9Vhb and _GGjPRafTbILOWDTPjEC7z0 < 20 do
                task.wait(0.1)
                _nKrEOvVfSDdgYSpSeX9Vhb = _RJjERYng8mXMJfhQnnCyT2(_NXDf15WGHv4zdyTFuuiM2w)
                _GGjPRafTbILOWDTPjEC7z0 = _GGjPRafTbILOWDTPjEC7z0 + 1
            end
            if _nKrEOvVfSDdgYSpSeX9Vhb and _cwlGmo6We58YLZ3ZJnlilP then
                _nKrEOvVfSDdgYSpSeX9Vhb.CFrame = _cwlGmo6We58YLZ3ZJnlilP
                task.wait(0.1)
                _cwlGmo6We58YLZ3ZJnlilP = nil
            end
        end)
    end
    if _KCbu2Au1vAJIFqOuBflYpF.Character then
        _gfYw5UEOxXF02QmagHhwwM(_KCbu2Au1vAJIFqOuBflYpF.Character)
    end
    _KCbu2Au1vAJIFqOuBflYpF.CharacterAdded:Connect(onCharacterAdded)
end
local function _6Ofzi2ikZlxO68okdQjWov()
    pcall(function()
        local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
        if not _KCbu2Au1vAJIFqOuBflYpF or not _KCbu2Au1vAJIFqOuBflYpF.Character then
            warn("TipStatsGUI: Cannot reset - no _NXDf15WGHv4zdyTFuuiM2w found")
            return
        end
        local _NXDf15WGHv4zdyTFuuiM2w = _KCbu2Au1vAJIFqOuBflYpF.Character
        local _nKrEOvVfSDdgYSpSeX9Vhb = _RJjERYng8mXMJfhQnnCyT2(_NXDf15WGHv4zdyTFuuiM2w)
        if _nKrEOvVfSDdgYSpSeX9Vhb then
            _cwlGmo6We58YLZ3ZJnlilP = _nKrEOvVfSDdgYSpSeX9Vhb.CFrame
        end
        print("TipStatsGUI: Resetting _NXDf15WGHv4zdyTFuuiM2w...")
        local _MbuECcuuyZtiyKNdKhF8hg = _NXDf15WGHv4zdyTFuuiM2w:FindFirstChildOfClass("Humanoid")
        if _MbuECcuuyZtiyKNdKhF8hg then
            _MbuECcuuyZtiyKNdKhF8hg.Health = 0
        else
            _NXDf15WGHv4zdyTFuuiM2w:BreakJoints()
        end
    end)
end
local function _73NdHdjFFsDAdJaTsZo5Qm()
    pcall(function()
        local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
        if not _KCbu2Au1vAJIFqOuBflYpF then
            warn("TipStatsGUI: Cannot rejoin - no local _LovOfbaPAgtCeey8jCuEVQ found")
            return
        end
        local _ta6BMurXOu5w18fJ2v3pZa = game.PlaceId
        local _nAmkVt9By6eNbR44e4OTsG = game.JobId
        if not _ta6BMurXOu5w18fJ2v3pZa or not _nAmkVt9By6eNbR44e4OTsG then
            warn("TipStatsGUI: Cannot rejoin - invalid PlaceId or JobId")
            return
        end
        print("TipStatsGUI: Rejoining server - PlaceId:", _ta6BMurXOu5w18fJ2v3pZa, "JobId:", _nAmkVt9By6eNbR44e4OTsG)
        TeleportService:TeleportToPlaceInstance(_ta6BMurXOu5w18fJ2v3pZa, _nAmkVt9By6eNbR44e4OTsG, _KCbu2Au1vAJIFqOuBflYpF)
    end)
end
local function _snEZar7l6dGGjHsm28xi5t()
    pcall(function()
        local _KCbu2Au1vAJIFqOuBflYpF = Players.LocalPlayer
        if not _KCbu2Au1vAJIFqOuBflYpF then
            warn("TipStatsGUI: Cannot server hop - no local _LovOfbaPAgtCeey8jCuEVQ found")
            return
        end
        local _ta6BMurXOu5w18fJ2v3pZa = game.PlaceId
        if not _ta6BMurXOu5w18fJ2v3pZa then
            warn("TipStatsGUI: Cannot server hop - invalid PlaceId")
            return
        end
        print("TipStatsGUI: Server hopping - PlaceId:", _ta6BMurXOu5w18fJ2v3pZa)
        TeleportService:Teleport(_ta6BMurXOu5w18fJ2v3pZa, _KCbu2Au1vAJIFqOuBflYpF)
    end)
end
spawn(function()
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    local _HuxwpFNm2BU8NHHKFZG75I = Players.LocalPlayer
    if not _HuxwpFNm2BU8NHHKFZG75I then
        _HuxwpFNm2BU8NHHKFZG75I = Players.PlayerAdded:Wait()
    end
    local function _flvwM5N6NhEtFbLO6MNUXD(_NHGwOzP5NbtsjJqw2FiRhD)
        if not _NHGwOzP5NbtsjJqw2FiRhD then 
            return false 
        end
        local _PWVp73WXTG1bAxNRqk300r = tostring(_NHGwOzP5NbtsjJqw2FiRhD)
        local _EjPr9rutKP4vGufVmhfdxS = _PWVp73WXTG1bAxNRqk300r:gsub("^%s+", ""):gsub("%s+$", "")
        local _eiVZkBaAdncx0LcTxX1S0Q = _EjPr9rutKP4vGufVmhfdxS:lower()
        print("TipStatsGUI: Received chat message:", _eiVZkBaAdncx0LcTxX1S0Q)
        local _rjaD2eP06SSjW0NRCNshAp = _eiVZkBaAdncx0LcTxX1S0Q:match("^%s*(%%?%w+)%s*$")
        if _rjaD2eP06SSjW0NRCNshAp then
            _rjaD2eP06SSjW0NRCNshAp = _rjaD2eP06SSjW0NRCNshAp:lower()
            if _rjaD2eP06SSjW0NRCNshAp == "%re" or _rjaD2eP06SSjW0NRCNshAp == "re" or _rjaD2eP06SSjW0NRCNshAp == "%reset" or _rjaD2eP06SSjW0NRCNshAp == "reset" then
                print("TipStatsGUI: Detected reset _rjaD2eP06SSjW0NRCNshAp - resetting _NXDf15WGHv4zdyTFuuiM2w")
                _6Ofzi2ikZlxO68okdQjWov()
                return true
            elseif _rjaD2eP06SSjW0NRCNshAp == "%rejoin" or _rjaD2eP06SSjW0NRCNshAp == "rejoin" then
                print("TipStatsGUI: Detected rejoin _rjaD2eP06SSjW0NRCNshAp - rejoining server")
                _73NdHdjFFsDAdJaTsZo5Qm()
                return true
            elseif _rjaD2eP06SSjW0NRCNshAp == "%serverhop" or _rjaD2eP06SSjW0NRCNshAp == "serverhop" then
                print("TipStatsGUI: Detected serverhop _rjaD2eP06SSjW0NRCNshAp - hopping to different server")
                _snEZar7l6dGGjHsm28xi5t()
                return true
            end
        end
        if _eiVZkBaAdncx0LcTxX1S0Q == "%re" or _eiVZkBaAdncx0LcTxX1S0Q == "re" or _eiVZkBaAdncx0LcTxX1S0Q == "%reset" or _eiVZkBaAdncx0LcTxX1S0Q == "reset" then
            print("TipStatsGUI: Detected reset _rjaD2eP06SSjW0NRCNshAp (direct) - resetting _NXDf15WGHv4zdyTFuuiM2w")
            _6Ofzi2ikZlxO68okdQjWov()
            return true
        elseif _eiVZkBaAdncx0LcTxX1S0Q == "%rejoin" or _eiVZkBaAdncx0LcTxX1S0Q == "rejoin" then
            print("TipStatsGUI: Detected rejoin _rjaD2eP06SSjW0NRCNshAp (direct) - rejoining server")
            _73NdHdjFFsDAdJaTsZo5Qm()
            return true
        elseif _eiVZkBaAdncx0LcTxX1S0Q == "%serverhop" or _eiVZkBaAdncx0LcTxX1S0Q == "serverhop" then
            print("TipStatsGUI: Detected serverhop _rjaD2eP06SSjW0NRCNshAp (direct) - hopping to different server")
            _snEZar7l6dGGjHsm28xi5t()
            return true
        end
        return false
    end
    local function _5k9s8WvrVzSl0LItxb0nt7(_LovOfbaPAgtCeey8jCuEVQ)
        if not _LovOfbaPAgtCeey8jCuEVQ or _LovOfbaPAgtCeey8jCuEVQ:IsDescendantOf(game) == false then
            return
        end
        local _WU87BkEmPu7K64NkJ8cEzd = _LovOfbaPAgtCeey8jCuEVQ.Chatted:Connect(function(message)
            if _IwkVsc23fgHnJGQ9AHaXHj then
                print("TipStatsGUI: Legacy chat _Y96vYR5taFZldy3s5TlM2U:", message)
                _flvwM5N6NhEtFbLO6MNUXD(message)
            end
        end)
        print("TipStatsGUI: Hooked legacy chat for _LovOfbaPAgtCeey8jCuEVQ:", _LovOfbaPAgtCeey8jCuEVQ.Name)
        return _WU87BkEmPu7K64NkJ8cEzd
    end
    local function _5LMhsJiwEZtZoTe3fT6LdT()
        if not TextChatService then
            return
        end
        local success, err = pcall(function()
            TextChatService.MessageReceived:Connect(function(message)
                if not _IwkVsc23fgHnJGQ9AHaXHj then
                    return
                end
                local _NHGwOzP5NbtsjJqw2FiRhD = nil
                local _GfLJKdpw7WIqho6mLbVKFl = nil
                if message.Text then
                    _NHGwOzP5NbtsjJqw2FiRhD = message.Text
                end
                if message.TextSource then
                    _GfLJKdpw7WIqho6mLbVKFl = Players:GetPlayerByUserId(message.TextSource.UserId)
                end
                if not _NHGwOzP5NbtsjJqw2FiRhD and message.Message then
                    _NHGwOzP5NbtsjJqw2FiRhD = message.Message
                end
                if not _GfLJKdpw7WIqho6mLbVKFl and message.UserId then
                    _GfLJKdpw7WIqho6mLbVKFl = Players:GetPlayerByUserId(message.UserId)
                end
                if not _GfLJKdpw7WIqho6mLbVKFl and message.TextSource then
                    local _jU6eWhVOTNZs0je2oNuEEi = message.TextSource
                    if _jU6eWhVOTNZs0je2oNuEEi.UserId then
                        _GfLJKdpw7WIqho6mLbVKFl = Players:GetPlayerByUserId(_jU6eWhVOTNZs0je2oNuEEi.UserId)
                    end
                end
                if _GfLJKdpw7WIqho6mLbVKFl and _GfLJKdpw7WIqho6mLbVKFl == Players.LocalPlayer and _NHGwOzP5NbtsjJqw2FiRhD then
                    print("TipStatsGUI: New chat _Y96vYR5taFZldy3s5TlM2U:", _NHGwOzP5NbtsjJqw2FiRhD)
                    _flvwM5N6NhEtFbLO6MNUXD(_NHGwOzP5NbtsjJqw2FiRhD)
                end
            end)
            print("TipStatsGUI: New chat hook connected successfully")
        end)
        if not success then
            warn("TipStatsGUI: Failed to hook new chat:", err)
        else
            print("TipStatsGUI: New chat system hooked")
        end
        pcall(function()
            local _LveNnjZJ53YAbItAchwIsf = TextChatService:FindFirstChild("ChatInputBarConfiguration")
            if _LveNnjZJ53YAbItAchwIsf then
                print("TipStatsGUI: ChatInputBarConfiguration found")
            end
        end)
    end
    local function _Pu7cw0VBL3NE7HDkVS7BNa()
        if TextChatService then
            local success, chatVersion = pcall(function()
                return TextChatService.ChatVersion
            end)
            if success and chatVersion == Enum.ChatVersion.TextChatService then
                _5LMhsJiwEZtZoTe3fT6LdT()
            end
        end
    end
    local _N5Z7w6x37pXMsVzByShOae = false
    local _idV5g5PUwHcYl6KWbRcdmq = false
    local function _NCawnVHqL6S5iV9mq71zHX()
        if _N5Z7w6x37pXMsVzByShOae then
            return
        end
        _N5Z7w6x37pXMsVzByShOae = true
        local success, err = pcall(function()
            _5k9s8WvrVzSl0LItxb0nt7(_HuxwpFNm2BU8NHHKFZG75I)
            Players.PlayerAdded:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
                if _IwkVsc23fgHnJGQ9AHaXHj then
                    _5k9s8WvrVzSl0LItxb0nt7(_LovOfbaPAgtCeey8jCuEVQ)
                end
            end)
        end)
        if success then
            print("TipStatsGUI: Legacy chat detection initialized")
        else
            warn("TipStatsGUI: Failed to initialize legacy chat:", err)
        end
    end
    local function _RmiQzEsGlfdlvGUbbNtScf()
        if _idV5g5PUwHcYl6KWbRcdmq then
            return
        end
        _idV5g5PUwHcYl6KWbRcdmq = true
        _5LMhsJiwEZtZoTe3fT6LdT()
        print("TipStatsGUI: New chat detection initialized")
    end
    _NCawnVHqL6S5iV9mq71zHX()
    _RmiQzEsGlfdlvGUbbNtScf()
    _Pu7cw0VBL3NE7HDkVS7BNa()
    local function _H0XRaR25KNjkdKszuvPWxa(_LovOfbaPAgtCeey8jCuEVQ)
        if not _LovOfbaPAgtCeey8jCuEVQ then
            return
        end
        pcall(function()
            _LovOfbaPAgtCeey8jCuEVQ.Chatted:Connect(function(message)
                if _IwkVsc23fgHnJGQ9AHaXHj then
                    print("TipStatsGUI: Direct Chatted event _Y96vYR5taFZldy3s5TlM2U:", message)
                    local _VvBDtsrZgBzdZZudYQq8wm = _flvwM5N6NhEtFbLO6MNUXD(message)
                    if _VvBDtsrZgBzdZZudYQq8wm then
                        print("TipStatsGUI: Command _VvBDtsrZgBzdZZudYQq8wm successfully")
                    end
                end
            end)
            print("TipStatsGUI: Direct Chatted event hooked for:", _LovOfbaPAgtCeey8jCuEVQ.Name)
        end)
    end
    if _HuxwpFNm2BU8NHHKFZG75I then
        _H0XRaR25KNjkdKszuvPWxa(_HuxwpFNm2BU8NHHKFZG75I)
    end
    Players.PlayerAdded:Connect(function(_LovOfbaPAgtCeey8jCuEVQ)
        if _LovOfbaPAgtCeey8jCuEVQ == Players.LocalPlayer then
            _H0XRaR25KNjkdKszuvPWxa(_LovOfbaPAgtCeey8jCuEVQ)
        end
    end)
    task.spawn(function()
        local _LovOfbaPAgtCeey8jCuEVQ = Players.LocalPlayer
        if not _LovOfbaPAgtCeey8jCuEVQ then
            _LovOfbaPAgtCeey8jCuEVQ = Players.PlayerAdded:Wait()
        end
        if _LovOfbaPAgtCeey8jCuEVQ == Players.LocalPlayer then
            _H0XRaR25KNjkdKszuvPWxa(_LovOfbaPAgtCeey8jCuEVQ)
        end
    end)
    print("TipStatsGUI: Chat detection system fully initialized")
end)
spawn(function()
    if not _IwkVsc23fgHnJGQ9AHaXHj then
        return
    end
    local _zIdtw4riW5wn2n0SBRUjOM = 32
    local _xgMyBDFlgifI20jP1Ct4R4 = 0.1
    local _AuF3q6sIjEYDb03uYHq7mO = {}
    local function _eVva8wgdqBTonQoBXTylfh()
        local _0TBgnTIS7U3eIJJYUYvScq = {}
        local _HPhis5tRICcmpGaV2bCTJb = Workspace:FindFirstChild("Map")
        if _HPhis5tRICcmpGaV2bCTJb then
            _HPhis5tRICcmpGaV2bCTJb = _HPhis5tRICcmpGaV2bCTJb:FindFirstChild("Decoration")
            if _HPhis5tRICcmpGaV2bCTJb then
                _HPhis5tRICcmpGaV2bCTJb = _HPhis5tRICcmpGaV2bCTJb:FindFirstChild("TableGames")
                if _HPhis5tRICcmpGaV2bCTJb then
                    for _, child in ipairs(_HPhis5tRICcmpGaV2bCTJb:GetChildren()) do
                        local _Fh4WzEXTJwT6XtHLEK6rns = child:FindFirstChild("Buzzer")
                        if _Fh4WzEXTJwT6XtHLEK6rns then
                            local _H9V7L2AU6K7u3gM7xXYqS4 = _Fh4WzEXTJwT6XtHLEK6rns:FindFirstChild("ClickDetector")
                            if _H9V7L2AU6K7u3gM7xXYqS4 then
                                table.insert(_0TBgnTIS7U3eIJJYUYvScq, {
                                    _Fh4WzEXTJwT6XtHLEK6rns = _Fh4WzEXTJwT6XtHLEK6rns,
                                    _H9V7L2AU6K7u3gM7xXYqS4 = _H9V7L2AU6K7u3gM7xXYqS4,
                                    table = child
                                })
                            end
                        end
                    end
                end
            end
        end
        return _0TBgnTIS7U3eIJJYUYvScq
    end
    local function _9nrLAHX8JiH4t2N2QdqQOd(buzzerData)
        if buzzerData._Fh4WzEXTJwT6XtHLEK6rns and buzzerData._Fh4WzEXTJwT6XtHLEK6rns:IsA("BasePart") then
            return buzzerData.buzzer.Position
        elseif buzzerData._Fh4WzEXTJwT6XtHLEK6rns then
            local _tLjfOu8plXl0tOeBQ2Jzaj = buzzerData._Fh4WzEXTJwT6XtHLEK6rns:FindFirstChildOfClass("BasePart")
            if _tLjfOu8plXl0tOeBQ2Jzaj then
                return _tLjfOu8plXl0tOeBQ2Jzaj.Position
            end
        end
        return nil
    end
    while _IwkVsc23fgHnJGQ9AHaXHj do
        task.wait(_xgMyBDFlgifI20jP1Ct4R4)
        if not _IwkVsc23fgHnJGQ9AHaXHj then
            return
        end
        if not _0Mo4Au6gjlIcWTR8WhXyix or not _0Mo4Au6gjlIcWTR8WhXyix.Character then
            continue
        end
        local _lpVrBbjhkyo5gmUAQamLCA = _RJjERYng8mXMJfhQnnCyT2(_0Mo4Au6gjlIcWTR8WhXyix.Character)
        if not _lpVrBbjhkyo5gmUAQamLCA then
            continue
        end
        local _0TBgnTIS7U3eIJJYUYvScq = _eVva8wgdqBTonQoBXTylfh()
        for _, buzzerData in ipairs(_0TBgnTIS7U3eIJJYUYvScq) do
            if not buzzerData._H9V7L2AU6K7u3gM7xXYqS4 or not buzzerData.clickDetector.Parent then
                continue
            end
            local _nPG6z4A0iBVEpOsIQ6oRL2 = _9nrLAHX8JiH4t2N2QdqQOd(buzzerData)
            if not _nPG6z4A0iBVEpOsIQ6oRL2 then
                continue
            end
            local _DQI0PgZWHCBZi5cfkZjC88 = (_lpVrBbjhkyo5gmUAQamLCA.Position - _nPG6z4A0iBVEpOsIQ6oRL2).Magnitude
            if _DQI0PgZWHCBZi5cfkZjC88 <= _zIdtw4riW5wn2n0SBRUjOM then
                local _JNXenfYpXL5475MMMrLSpj = tostring(buzzerData._H9V7L2AU6K7u3gM7xXYqS4)
                local _HrFT7X5bdP0vMqMaCr4PXS = _AuF3q6sIjEYDb03uYHq7mO[_JNXenfYpXL5475MMMrLSpj] or 0
                local _jWwUqeo1nWQJxHppuK2dj2 = tick()
                if _jWwUqeo1nWQJxHppuK2dj2 - _HrFT7X5bdP0vMqMaCr4PXS >= 0.5 then
                    pcall(function()
                        buzzerData._H9V7L2AU6K7u3gM7xXYqS4:Click()
                        _AuF3q6sIjEYDb03uYHq7mO[_JNXenfYpXL5475MMMrLSpj] = _jWwUqeo1nWQJxHppuK2dj2
                    end)
                end
            end
        end
    end
end)
print("Tip Stats GUI loaded successfully!")
task.wait(1)
if Workspace:FindFirstChild("PlayerCharacters") then
    Workspace.PlayerCharacters.ChildAdded:Connect(function(child)
        task.wait(0.5)
        if child:IsA("Model") or child:IsA("Folder") then
            _vKC1R9F3rjjPuJxlNFkK1n(child.Name)
        end
    end)
end
task.wait(2)
spawn(function()
    if _S0syiCt3DB2qEki81fRzIy and _S0syiCt3DB2qEki81fRzIy.Parent then
        _wLtE0qjNgk1WbcLcXu7ZQ2(
            "Tip Stats GUI",
            "AFK tags have been disabled for all players to prevent AFK detection issues. This will break the AFK text display.",
            "warning"
        )
    end
end)