local p = require("cc.pretty").pretty_print

local Module = peripheral.wrap("left")
local Equipment = Module.getEquipment()
local Inventory = Module.getInventory()
local TotemBarrel = peripheral.wrap("back")
local ClearBarrel = peripheral.wrap("top")

function GiveTotemTask()
    while true do
        local EquipmentList = Equipment.list()
        local NeedsTotem = EquipmentList[2] == nil
        if NeedsTotem then
            local TotemSlot
            for Slot, SlotData in pairs(TotemBarrel.list()) do
                if SlotData then
                    TotemSlot = Slot
                    break
                end
            end
            Equipment.pullItems("back", TotemSlot, 1, 2)
        end
        sleep(0.01)
    end
end

function ClearTotemsTask()
    while true do
        for Slot, SlotData in pairs(Inventory.list()) do
            if SlotData.name == "minecraft:totem_of_undying" then
                local OpenSlot
                for Slot, _ in pairs(ClearBarrel.list()) do
                    OpenSlot = Slot + 1
                end
                if OpenSlot == 28 then return end
                Inventory.pushItems("top", Slot, 1, OpenSlot)
            end
        end
        sleep(0.05)
    end
end

parallel.waitForAll(
    GiveTotemTask,
    ClearTotemsTask
)