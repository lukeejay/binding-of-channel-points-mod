local mod = RegisterMod("Binding of Channel Points", 1) -- Register the mod in the API (dont change anything here, except the name)

local enemiesFromQueue = 4
local nextInt = 10;
local debugText
local entity

--function mod:onNewRoom()
  --  mod.destroyAllRoomEntites()
  --  mod.spawnEnemiesFromQueue()
-- end

function mod:spawnEnemiesFromQueue()
    entity = Isaac.Spawn(nextInt, 0, 0, Vector(320,280), Vector(0,0), nil)
    nextInt = nextInt + 1

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

 -- remove all room enemies that aren't bosses
 function mod:destroyAllRoomEntitesAndNotChecked()
    local entities = Isaac.GetRoomEntities()

    for i=1, #entities do
        if entities[i]:IsVulnerableEnemy() and not entities[i].Type == nextInt then 
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
    
    local player = Isaac.GetPlayer(0)
    local screenpos = Isaac.WorldToScreen(player.Position)  
    Isaac.RenderText("test", screenpos.X, screenpos.Y, 1 ,1 ,1 ,1 )

    if entity ~= nil then 
        local position = Vector(entity.Position.X - entity.PositionOffset.X, entity.Position.Y - entity.PositionOffset.Y )
        screenEntityPosition = Isaac.WorldToRenderPosition(position)
        Isaac.RenderText("Enemy", screenEntityPosition.X , screenEntityPosition.Y , 255, 0, 0, 255)
    end
end

function mod:checkNext()
    --destroyAllRoomEntites()
    mod.spawnEnemiesFromQueue()
end

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.checkNext)
mod:AddCallback(ModCallbacks.MC_POST_RENDER, mod.render)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.destroyAllRoomEntites)
