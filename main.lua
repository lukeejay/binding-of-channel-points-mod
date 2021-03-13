local mod = RegisterMod("Binding of Channel Points", 1) -- Register the mod in the API (dont change anything here, except the name)

local enemiesFromQueue = 4
local debugText

function mod:onNewRoom()
    mod.destroyAllRoomEntites()
    mod.spawnEnemiesFromQueue()
end

function mod:spawnEnemiesFromQueue()
    for i=1, enemiesFromQueue do 
        Isaac.Spawn(EntityType.ENTITY_FLY, 0, 0, Vector(320,280), Vector(0,0), nil)
    end

end

 -- remove all room enemies that aren't bosses
function mod:destroyAllRoomEntites()
    local entities = Isaac.GetRoomEntities()
    
    for i=1, #entities do
        if entities[i]:IsVulnerableEnemy() then 
            entities[i]:Remove()
        end
    end

end

function mod:fart()
    local player = Isaac.GetPlayer(0);
    local playerPosition = Vector(player.Position.X, player.Position.Y)
    
    Game().Fart( Game(), playerPosition, 1, player, 1, 0)

    fartIterator = fartIterator + 1
end
function mod:render()
    Isaac.RenderText(debugText, 100, 100, 255, 0, 0, 255)
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.onNewRoom)
--mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.render)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.fart)
