import natu/[video, math]
import natu/[graphics]
import variables, camera

proc startMode*()=
    
    var pet = initObj(
    pos = vec2i(104, 83),
    tileId = allocObjTiles(gfxPet),  # Allocate tiles for a single frame of animation.
    palId = acquireObjPal(gfxPet),   # Obtain palette.
    size = gfxPet.size,              # Set to correct size.
    )
    #graphic = gfxPet
    objMem[0] = pet
    copyFrame(addr objTileMem[pet.tileId], gfxPet, frame = 0)

    camInit()
    dispcnt.bg0 = false
    hunger = 0
    dirt = 0
    fun = 50
    timer = 500


proc MainGame*()=
    timer = timer - 1
    if timer == 0 and hunger <= 99:
        hunger = hunger + 1
        timer = 500
    if timer == 250 and fun >= 1:
        fun = fun - 1
    #if hunger >= 45 or fun <= 20:
    #    s.currFrame = 2
    #else:
    #    s.currFrame = 0