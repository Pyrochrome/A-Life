import natu/[graphics, math]

type
    ID* = enum
        petIdle
        petSad
        petBlink
        petBlinkSad
        petChew
        petWalk
        petIck
        petHappy
        petBath
        balMove
        balPop

    AnimData* = object
        frames*: seq[uint8]
        speed*: int

const anis*: array[ID, AnimData] = [
  petIdle: AnimData(frames: @[0], speed: 1), 
  petSad: AnimData(frames: @[2], speed: 1),
  petBlink: AnimData(frames: @[1, 0, 1], speed: 45), 
  petBlinkSad: AnimData(frames: @[3, 2, 3], speed: 45),
  petChew: AnimData(frames: @[4, 5, 6], speed: 15),
  petWalk: AnimData(frames: @[7, 8], speed: 20),
  petIck: AnimData(frames: @[9, 10, 9, 10], speed: 45),
  petHappy: AnimData(frames: @[12, 11], speed: 45),
  petBath: AnimData(frames: @[13, 14], speed: 45),
  balMove: AnimData(frames: @[0, 1], speed: 45),
  balPop: AnimData(frames: @[2, 3, 4], speed: 5)
  
]



