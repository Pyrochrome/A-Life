import natu/[math, mgba, video]
import natu/[graphics]


type
  SprData* = object
    sprite*: Graphic
    coor*: Vec2i 
    tiles*, color*: int
    oam*: int16


type Sprite* = object
  exists*: bool
  currFrame*: int
  data*: SprData

type Actor* = enum
  pet = 0
  cursor
  bal1
  bal2
  bal3
  cloud1

const SpriteTable*: array[Actor, SprData] = [
  pet: SprData(sprite: gfxPet, coor: vec2i(104, 83),tiles: 1, color: 1, oam: 0),
  cursor: SprData(sprite: gfxCursor, coor: vec2i(104, 48),tiles: 1, color: 1, oam: 1),
  bal1: SprData(sprite: gfxBalloon, coor: vec2i(48, 33),tiles: 7, color: 2, oam: 2),
  bal2: SprData(sprite: gfxBalloon, coor: vec2i(138, 72),tiles: 7, color: 2, oam: 3),
  bal3: SprData(sprite: gfxBalloon, coor: vec2i(189, 15),tiles: 7, color: 2, oam: 4),
  cloud1: SprData(sprite: gfxCloud, coor: vec2i(104, 83),tiles: 9, color: 3, oam: 5),
]
#const sprPetData* = SprData(sprite: gfxBaby, coor: vec2i(104, 83),tiles: 1, color: 1)
#const sprCursorData* = SprData(sprite: gfxCursor, coor: vec2i(104, 48),tiles: 1, color: 1)
#const sprBal1Data* = SprData(sprite: gfxBalloon, coor: vec2i(48, 33),tiles: 7, color: 2)
#const sprBal2Data* = SprData(sprite: gfxBalloon, coor: vec2i(138, 72),tiles: 7, color: 2)
#const sprBal3Data* = SprData(sprite: gfxBalloon, coor: vec2i(189, 15),tiles: 7, color: 2)
#const sprCloud1Data* = SprData(sprite: gfxCloud, coor: vec2i(104, 83),tiles: 9, color: 3)

#var sprPet* = Sprite(exists: false, currFrame: 0, oam: 0, data: sprPetData)
#var sprCursor* = Sprite(exists: false, currFrame: 0, oam: 0, data: sprCursorData)
#var sprBal1* = Sprite(exists: false, currFrame: 0, oam: 0, data: sprBal1Data)
#var sprBal2* = Sprite(exists: false, currFrame: 0, oam: 0, data: sprBal2Data)
#var sprBal3* = Sprite(exists: false, currFrame: 0, oam: 0, data: sprBal3Data)
#var sprCloud1* = Sprite(exists: false, currFrame: 0, oam: 0, data: sprCloud1Data)




##########################################


var graphic*: Graphic
var spr*: SprData
var om*: int16
#var st* = 0

proc initSprite*(a: Actor) =
  #s.exists = true
  #s.currFrame = 0
  om = a.int16
  spr = SpriteTable[a]
  
  objMem[om].init(
    pos = spr.coor, #- vec2i(g.width, g.height) / 2,
    size = spr.sprite.size,
    tileId = spr.tiles,
    palId = spr.color,
    tid = allocObjTiles(spr.sprite),  # Reserve enough tiles in VRAM for 1 frame of animation.
    pal = acquireObjPal(spr.sprite),  # Load the palette into a slot in the PAL RAM buffer
  )
  printf(logDebug, "New object loaded.")

proc destroySprite*(a: Actor) =
  om = a.int16
  spr = SpriteTable[a]
  freeObjTiles(objMem[om].tid)    # Free the tiles.
  releaseObjPal(spr.sprite)   # Palette will also be freed only if nobody else is using it.




