---------------------------------------------------------------------------------------------------

--> sort-item.lua <--

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- Contenedor de este MOD
local ThisMOD = { }

-- Cargar información de este MOD
if true then

    -- Identifica el mod que se está usando
    local NameMOD = GPrefix.getFile( debug.getinfo( 1 ).short_src )

    -- Crear la vareble si no existe
    GPrefix.MODs[ NameMOD ] = GPrefix.MODs[ NameMOD ] or { }

    -- Guardar en el acceso rapido
    ThisMOD = GPrefix.MODs[ NameMOD ]
end

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- Configuración del MOD
function ThisMOD.Settings( )
    if not GPrefix.getKey( { "settings" }, GPrefix.File ) then return end

    local SettingOption =  { }
    SettingOption.name  = ThisMOD.Prefix_MOD
    SettingOption.type  = "bool-setting"
    SettingOption.order = ThisMOD.Index
    SettingOption.setting_type   = "startup"
    SettingOption.default_value  = true
    SettingOption.allowed_values = { "true", "false" }
    SettingOption.localised_description = { ThisMOD.Local .. "setting-description" }

    local List = { }
    table.insert( List, "" )
    table.insert( List, "[font=default-bold][ " .. ThisMOD.Char .. " ][/font] " )
    table.insert( List, { ThisMOD.Local .. "setting-name" } )
    SettingOption.localised_name = List

    data:extend( { SettingOption } )
end

-- Cargar la configuración
ThisMOD.Settings( )

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

function ThisMOD.InventorySort( Event )

    -- Inventarios a ordenar
    local EntitysToSort = {
        [ "car" ] = defines.inventory.car_trunk,
        [ "container" ] = defines.inventory.chest,
        [ "cargo-wagon" ] = defines.inventory.cargo_wagon,
        [ "spider-vehicle" ] = defines.inventory.spider_trunk,
        [ "logistic-container" ] = defines.inventory.chest,
        [ "roboport" ] = {
            defines.inventory.roboport_robot,
            defines.inventory.roboport_material
        }
    }

    -- Renombrar la variable
    local Entity = Event.entity

    -- Valinación básica
    if not Entity then return end

    -- Identificar el inventario
    local Inventory = EntitysToSort[ Entity.type ]

    -- Inventario no encontrado
    if not Inventory then return end

    -- Validación de los datos
    local Inventorys = GPrefix.isTable( Inventory ) and Inventory or { Inventory }

    -- Ordenar inventario
    for _, inventory in ipairs( Inventorys ) do
        Entity.get_inventory( inventory ).sort_and_merge( )
    end
end

function ThisMOD.Control( )
    if not GPrefix.getKey( { "control" }, GPrefix.File ) then return end
    if not ThisMOD.Active then return end

    GPrefix.addEvent( {
        [ { "on_event", defines.events.on_gui_opened } ] = ThisMOD.InventorySort,
    } )
end

-- Cargar los eventos
ThisMOD.Control( )

---------------------------------------------------------------------------------------------------



































-- --------------------------------------

-- -- sort-stock.lua

-- --------------------------------------
-- --------------------------------------

-- -- Identifica el mod que se está usando
-- local MOD = GPrefix.getFile( debug.getinfo( 1 ).short_src )

-- -- Crear la vareble si no existe
-- GPrefix.MODs[ MOD ] = GPrefix.MODs[ MOD ] or { }

-- -- Guardar en el acceso rapido
-- GPrefix.MOD = GPrefix.MODs[ MOD ]

-- --------------------------------------
-- --------------------------------------

-- local Files = { }
-- table.insert( Files, "settings" )

-- -- Cargar la configuración
-- if GPrefix.getKey( Files, GPrefix.File ) then

--     -- Preparar la configuración de este mod
--     local SettingOption =  {
--         type           = "bool-setting",
--         setting_type   = "startup",
--         allowed_values = {"true", "false"},
--         default_value  = true
--     }

--     -- Construir valores
--     SettingOption.name  = GPrefix.MOD.Prefix_MOD
--     SettingOption.order = GPrefix.SettingOrder[ SettingOption.type ]
-- 	SettingOption.order = SettingOption.order .. "-" .. SettingOption.name
--     SettingOption.localised_name  = { GPrefix.MOD.Local .. "setting-name"}
--     SettingOption.localised_description  = { GPrefix.MOD.Local .. "setting-description"}

--     -- Cargar configuración del mod al juego
--     data:extend( { SettingOption } )
--     return
-- end

-- --------------------------------------
-- --------------------------------------

-- Files = { }
-- table.insert( Files, "control" )

-- -- Es necesario ejecutar este codigo??
-- if not GPrefix.getKey( Files, GPrefix.File ) then return end

-- -- MOD Inactivo
-- if not GPrefix.MOD.Active then return end

-- --------------------------------------
-- --------------------------------------

-- -- Renombrar la variable
-- local OpenInventory = defines.events.on_gui_opened

-- -- Inventarios a ordenar
-- local EntitysToSort = {
-- 	[ "car" ] = defines.inventory.car_trunk,
-- 	[ "container" ] = defines.inventory.chest,
-- 	[ "cargo-wagon" ] = defines.inventory.cargo_wagon,
-- 	[ "spider-vehicle" ] = defines.inventory.spider_trunk,
-- 	[ "logistic-container" ] = defines.inventory.chest,
-- 	[ "roboport" ] = {
--         defines.inventory.roboport_robot,
--         defines.inventory.roboport_material
--     }
-- }

-- local function InventorySort( Event )

--     -- Renombrar la variable
--     local Entity = Event.entity

--     -- Valinación básica
--     if not Entity then return end

--     -- Identificar el inventario
--     local Inventory = EntitysToSort[ Entity.type ]

--     -- Inventario no encontrado
--     if not Inventory then return end

--     -- Validación de los datos
--     local Inventorys = GPrefix.isTable( Inventory ) and Inventory or { Inventory }

--     -- Ordenar inventario
--     for _, inventory in ipairs( Inventorys ) do
--         Entity.get_inventory( inventory ).sort_and_merge( )
--     end
-- end

-- -- Aplicar el efecto en el evento
-- GPrefix.addEvent( {
--     [ { "on_event", OpenInventory } ] = InventorySort,
-- } )

-- --------------------------------------