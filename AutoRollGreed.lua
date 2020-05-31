local addonName, addon = ...

SLASH_AUTOROLLGREED1 = "/autorollgreed"
SLASH_AUTOROLLGREED2 = "/arg"

SlashCmdList["AUTOROLLGREED"] = function(msg, editBox)
  if msg == 'enable' then
    autoRollGreedEnabled = true
    print("AutoRollGreed is enabled")
  elseif msg == 'disable' then
    autoRollGreedEnabled = false
    print("AutoRollGreed is disabled")
  elseif msg == 'status' then
    if autoRollGreedEnabled then
        print("AutoRollGreed is enabled")
    else
        print("AutoRollGreed is disabled")
    end
  else
    print("AutoRollGreed can be enabled/disabled by doing /arg or /autorollgreed")
    print("/arg enable -- enables AutoRollGreed")
    print("/arg disable -- disables AutoRollGreed")
    print("/arg status -- prints if it is currently enabled/disabled")
  end
end


local function onEvent(self, event, arg1, ...)
    if(event == "ADDON_LOADED") then
        -- This event is fired off for all addons. Ignore everything else
        if  arg1 ~= "AutoRollGreed" then
          return
        end
        if autoRollGreedEnabled == nil then
            autoRollGreedEnabled = true
        end
    else
       if not autoRollGreedEnabled then
          return
       end
       
        -- for START_LOOT_ROLL, arg1 is the roll ID
        texture, name, count, quality, bindOnPickUp, canNeed, canGreed = GetLootRollItemInfo(arg1)
        if(quality <= 2 and canGreed) then
            RollOnLoot(arg1, 2)
        end
    end
end

addon.core = {};
addon.core.frame = CreateFrame("Frame");
addon.core.frame:SetScript("OnEvent", onEvent);
addon.core.frame:RegisterEvent("START_LOOT_ROLL")
addon.core.frame:RegisterEvent("ADDON_LOADED");
