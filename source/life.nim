import natu/[video, bios, irq, mgba, math, maxmod, utils, input]
import natu/[graphics, backgrounds]
import data/variables
import mainloop, oamdraw, save

asm """
.balign 4
.string "SRAM_V111"
"""
proc update()=
    case gameMode
    of title:
        keyPoll()
        if keyHit(kiStart):
            begin()
            gameMode = raisepet
    of raisepet:
        RunGame()
    else:
        discard

proc DrawScreen()=
#   camScroll()
#   bgofs[1].x = (-camOffset.x).int16
#   bgofs[1].y = (-camOffset.y).int16
    runAnim()
    flushPals()

proc OnVBlank()=
    maxmod.vblank()
    DrawScreen()


proc main =

    if validateSave() == false:
        printf(logDebug, "No valid save.")
        newSave()
    readSave()
    printf(logDebug, "Read save.")
    irq.put(iiVBlank, OnVBlank)
 
    maxmod.init(soundbankBin, 8)
    maxmod.setModuleVolume(volume.toFixed(10))
    gameMode = title
    maxmod.start(modMoon)
    
    objMem[2] = initObj(
        pos = vec2i(0,0), 
        tileId = allocObjTiles(gfxGrey), 
        palId = acquireObjPal(gfxGrey), 
        size = gfxGrey.size,
        )
    bgcnt[0].init(cbb = 2, sbb = 9)
    bgcnt[0].is8bpp = true
    bgcnt[0].load(bgTitlenew)
    dispcnt.init(layers = {lBg0, lObj}, obj1d = true)
    for obj in mitems(objMem):
        obj.hide()
    
    
    seed(10)
    gametick = 0

    while true:
        update()
        maxmod.frame()
        VBlankIntrWait()


main()