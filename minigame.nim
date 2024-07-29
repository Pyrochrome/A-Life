import natu/[graphics, video, maxmod, math, input]
import variables



proc startMinigame*()=
    #om = 0

    var cursor = initObj(
    pos = vec2i(104, 48),
    tileId = allocObjTiles(gfxCursor),  # Allocate tiles for a single frame of animation.
    palId = acquireObjPal(gfxCursor),   # Obtain palette.
    size = gfxCursor.size,              # Set to correct size.
    )
    graphic = gfxCursor
    objMem[1] = cursor

    #initSprite(bal1)
    #initSprite(bal2)
    #initSprite(bal3)  
    dispcnt.bg0 = false
    maxmod.start(modOct, mmPlayLoop)

proc playMinigame*()=
    if keyIsDown(kiUp) and cursorpos.y != 0:
        cursorpos.y -= 1
    if keyIsDown(kiDown) and cursorpos.y != 128:
        cursorpos.y += 1
    if keyIsDown(kiLeft) and cursorpos.x != 0:
        cursorpos.x -= 1
    if keyIsDown(kiRight) and cursorpos.x != 208:
        cursorpos.x += 1

    objmem[1].pos = cursorpos
