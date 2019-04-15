# Virtual-Worlds
This resource provides a unique world/dimensions that can be assigned to players, peds, objects or vehicles in FiveM.

# How to Use

**Features:**  
Allows you to assign any entity to a virtual world between *0* and *2,147,483,647*.  
Entities assigned to world 0 will be visible normally to all players. 
Entities cannot physically interact with each other aside from explosions which can move vehicles(but not damage them).   
NPC and NPC vehicle spawning is disabled in **> 0** worlds. 

**Functions:**
```
SetEntityVirtualWorld(entity, worldid) --Assigns a virtual world to an entity, be it a ped, vehicle, object or player.

GetEntityVirtualWorld(entity) --Returns an entity's virtual world as an integer.
```
