import natu/[video, bios, irq, input, math, mgba, maxmod]
import natu/[graphics, backgrounds]
import camera, behavior, minigame, pet, variables
#from pragma import ThumbCodeInEwram

var gameMode = title
 
proc update()=
    case gameMode:
    of title:
        if keyHit(kiSelect):
            startMinigame()
            gameMode = minigame
        elif keyHit(kiStart):
            startMode()
            gameMode = raisepet
    of raisepet:
        MainGame()
        UpdatePet()
    of minigame:
        playMinigame()

proc DrawScreen()=
  camScroll()
  bgofs[1].x = (-camOffset.x).int16
  bgofs[1].y = (-camOffset.y).int16
  for obj in mitems(objMem):
    copyFrame(addr objTileMem[objMem.tileId], graphic, frame = 0)
  flushPals()

proc OnVBlank()=
    maxmod.vblank()
    DrawScreen()

proc debug()=
    if keyIsDown(kiUp):
        camTarget.y += 1
    if keyIsDown(kiDown):
        camTarget.y -= 1
    if keyIsDown(kiLeft) and petpos.x != 0:
        petpos.x = petpos.x - fp(0.4)
    if keyIsDown(kiRight) and petpos.x != 110:
        petpos.x = petpos.x + fp(0.4)


proc main =
    irq.put(iiVBlank, OnVBlank)
    bgcnt[0].init(cbb = 3, sbb = 12)
    bgcnt[1].init(cbb = 0, sbb = 8)
    bgcnt[0].load(bgTitle)
    bgcnt[1].load(bgHill)
    camInit()
    #om = 0
    dispcnt.init(layers = {lBg0, lBg1, lObj }, obj1d = true)
    for obj in mitems(objMem):
        obj.hide()
 
    maxmod.init(soundbankBin, 8)
    gameMode = title
    
    #obj.pos = vec2i(104, 83)
    #objMem[1] = obj
    #initCurrentSprite(gfxCloud)
    #obj.pos = vec2i(30, 20)
    #setVolume(sfxChirp, vol)
    #setVolume(sfxGiggle, vol)

    while true:
        keyPoll()
        update()
        #debug()
        maxmod.frame()
        #anim.update
        VBlankIntrWait()

main()