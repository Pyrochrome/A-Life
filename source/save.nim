import natu/[memory, math]
import data/variables

const saveHeader:cstring = "test_sram"

# Note: Code that reads save data needs to be put in Work RAM.
# To do this, we can use the codegenDecl pragma to annotate the generated C function.

proc validateSave*(): bool {.codegenDecl:EWRAM_CODE.} =
  for i,c in saveHeader:
    if sramMem[i].char != c:
      return false
  return true

proc newSave*() =
  # Copy the header
  for i,c in saveHeader:
    sramMem[i] = c.uint8
  
  # Set the starting position for the sprite
  sramMem[0x10] = petattr.hunger
  sramMem[0x11] = petattr.fatigue
  sramMem[0x12] = petattr.hygiene
  sramMem[0x13] = petattr.mood
  sramMem[0x14] = petcolor.uint8

proc readSave*() {.codegenDecl:EWRAM_CODE.} =
  petattr.hunger = sramMem[0x10].uint8
  petattr.fatigue = sramMem[0x11].uint8
  petattr.hygiene = sramMem[0x12].uint8
  petattr.mood = sramMem[0x13].uint8
  petcolor = sramMem[0x14].Color

proc writeSave*() =
  sramMem[0x10] = petattr.hunger.uint8
  sramMem[0x11] = petattr.fatigue.uint8
  sramMem[0x12] = petattr.hygiene.uint8
  sramMem[0x13] = petattr.mood.uint8
  sramMem[0x14] = petcolor.uint8
