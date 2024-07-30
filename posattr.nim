import natu/[math, mgba, video]
import natu/[graphics]


# type
#   SprData* = object
#     sprite*: Graphic
#     coor*: Vec2i 
#     tiles*, color*: int
#     oam*: int16


# type Sprite* = object
#   exists*: bool
#   currFrame*: int
#   data*: SprData

# type Actor* = enum
#   pet = 0
#   cursor
#   bal1
#   bal2
#   bal3
#   cloud1

# const SpriteTable*: array[Actor, SprData] = [
#   pet: SprData(sprite: gfxPet, coor: vec2i(104, 83),tiles: 1, color: 1, oam: 0),
#   cursor: SprData(sprite: gfxCursor, coor: vec2i(104, 48),tiles: 1, color: 1, oam: 1),
#   bal1: SprData(sprite: gfxBalloon, coor: vec2i(48, 33),tiles: 7, color: 2, oam: 2),
#   bal2: SprData(sprite: gfxBalloon, coor: vec2i(138, 72),tiles: 7, color: 2, oam: 3),
#   bal3: SprData(sprite: gfxBalloon, coor: vec2i(189, 15),tiles: 7, color: 2, oam: 4),
#   cloud1: SprData(sprite: gfxCloud, coor: vec2i(104, 83),tiles: 9, color: 3, oam: 5),
# ]
var om*: int16
var st* = 0

var SpriteTable*: seq[ObjAttr] = [
  var pet: initObj(pos = vec2i(104, 83), tileId = allocObjTiles(gfxPet), palId = acquireObjPal(gfxPet), size = gfxPet.size),
  var cursor: initObj(pos = vec2i(104, 48), tileId = allocObjTiles(gfxCursor), palId = acquireObjPal(gfxCursor), size = gfxCursor.size)
]

proc initObjects*()=
  om = 0
  for ObjAttr in SpriteTable:
    objMem[om] = SpriteTable[st]
    om = om + 1.int16
    st += 1




##########################################


# var graphic*: Graphic
# var spr*: SprData

#var st* = 0

# proc initSprite*(o: ObjAttr) =
#   #s.exists = true
#   #s.currFrame = 0
#   om = a.int16
  
  # objMem[om].init(
  #   pos = spr.coor, #- vec2i(g.width, g.height) / 2,
  #   size = spr.sprite.size,
  #   tileId = spr.tiles,
  #   palId = spr.color,
  #   tid = allocObjTiles(spr.sprite),  # Reserve enough tiles in VRAM for 1 frame of animation.
  #   pal = acquireObjPal(spr.sprite),  # Load the palette into a slot in the PAL RAM buffer
  # )
  # printf(logDebug, "New object loaded.")

proc destroySprite*(a: Actor) =
  om = a.int16
  spr = SpriteTable[a]
  freeObjTiles(objMem[om].tid)    # Free the tiles.
  releaseObjPal(spr.sprite)   # Palette will also be freed only if nobody else is using it.




