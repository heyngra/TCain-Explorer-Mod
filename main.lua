local ModName = "Tainted Cain Explorer"
local TCAIN = RegisterMod(ModName, 1)

function TCAIN:open_url(url)
    if package.config:sub(1,1) == "/" then
        os.execute("open " .. url)
    else
        os.execute("start " .. url)
    end
end

function TCAIN:OpenF()
    if (Input.IsButtonTriggered(Keyboard.KEY_F5, 0) and debug) then
        coop = 0
        if Game():GetPlayer(0) == Game():GetPlayer(1) then coop = 1 end
        local ok = pcall(TCAIN:open_url("http://tcain.heyn.live?data=" .. Seeds.Seed2String(Game():GetSeeds():GetStartSeed()):gsub("%s+", "") .. coop))
        if not ok then
            Isaac.ConsoleOutput("Relaunch the game with --luadebug to make it work.")
        end    
    end
end

function TCAIN:OpenWeb(command)
    Isaac.ConsoleOutput(command)
    if command == "open" then
        coop = 0
        if Game():GetPlayer(0) == Game():GetPlayer(1) then coop = 1 end
        local ok = pcall(TCAIN:open_url("http://tcain.heyn.live?data=" .. Seeds.Seed2String(Game():GetSeeds():GetStartSeed()):gsub("%s+", "") .. coop))
        if not ok then
            Isaac.ConsoleOutput("Relaunch the game with --luadebug to make it work.")
        end
    end
end

TCAIN:AddCallback(ModCallbacks.MC_EXECUTE_CMD, TCAIN.OpenWeb);
TCAIN:AddCallback(ModCallbacks.MC_POST_UPDATE, TCAIN.OpenF);
