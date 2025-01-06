import natu/[math]

type
    ID* = enum
        petIdle
        petWalk1
        petWalk2


    AnimData* = object
        frames*: seq[uint8]
        speed*: int

const anis*: array[ID, AnimData] = [
  petIdle: AnimData(frames: @[0], speed: 1), 
  petWalk1: AnimData(frames: @[0,1,0,2], speed: 15), 
  petWalk2: AnimData(frames: @[3,4,3,5], speed: 15), 
]



