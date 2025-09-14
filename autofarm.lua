local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function hopserv()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

    if workspace:WaitForChild("Folder").map.Shop.Safe1:WaitForChild("Door"):WaitForChild("ProximityPrompt").Enabled == true then then
        teleport(CFrame.new(35774.2656, 17.6827965, -268.366211, 0.998930573, 2.08330864e-08, -0.0462350808, -1.8876916e-08, 1, 4.27458318e-08, 0.0462350808, -4.18273416e-08, 0.998930573))
        fireproximityprompt(workspace.Folder.map.Shop.Safe1.Door.ProximityPrompt)
        task.wait(1)
        queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/genxnb/chiraq.wtf/refs/heads/main/autofarm.lua"))()')
        hopserv()
    else
        task.wait(1)
        queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/genxnb/chiraq.wtf/refs/heads/main/autofarm.lua"))()')
        hopserv()
    end
