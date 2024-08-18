import natu/[video, bios, irq, input, math, maxmod]
import natu/[graphics, backgrounds]
import data/variables
import camera, behavior, minigame, maingame, oamdraw
#from pragma import ThumbCodeInEwram
 
proc fadeMusicUp*()=
    musictimer += 1
    if volume <= fp(0.6) and musictimer == 7:
        volume += fp(0.1)
        musictimer = 0
        maxmod.setModuleVolume(volume.toFixed(10))
        if volume == fp(0.7):
            musicstate = play
        
proc fadeMusicDown*()=
    musictimer += 1
    if volume >= fp(0.1) and musictimer == 10:
        volume -= fp(0.1)
        maxmod.setModuleVolume(volume.toFixed(10))
        musictimer = 0
        if volume <= fp(0.1):
            maxmod.stop()
            musicstate = silent


proc update()=
    case gameMode:
    of title:
        inc seedtimer
        # if keyHit(kiSelect):
        #     startMinigame()
        #     Snapcam(vec2i(0, 0))
        #     gameMode = minigame
        if keyHit(kiStart):
            musicstate = fadedown
            startMode()
            gameMode = raisepet
    of raisepet:
        # if volume > fp(0.0):
        #     volume = volume - fp(0.1)
        # elif volume == fp(0.0) and maxmod.active() == true:
        if minigameFlag == true:
            waitforCam()
        else:
            MainGame()
            UpdatePet()
    of minigame:
        if minigameFlag == true:
            waitforCam()
        else:
            playMinigame()

    case musicstate
    of play:
        discard
    of fadeup:
        fadeMusicUp()
    of fadedown:
        fadeMusicDown()
    of silent:
        discard


proc DrawScreen()=
  camScroll()
  bgofs[1].x = (-camOffset.x).int16
  bgofs[1].y = (-camOffset.y).int16
  runAnim()
  flushPals()

proc OnVBlank()=
    maxmod.vblank()
    DrawScreen()

# proc debug()=
#     # if keyIsDown(kiUp):
#     #     camTarget.y += 1
#     # if keyIsDown(kiDown):
#     #     camTarget.y -= 1
#     # if keyIsDown(kiLeft) and petpos.x != 0:
#     #     petpos.x = petpos.x - fp(0.4)
#     # if keyIsDown(kiRight) and petpos.x != 110:
#     #     petpos.x = petpos.x + fp(0.4)
#     if keyHit(kiA):
#         maxmod.effect(sound)
#     if keyHit(kiB):
#         maxmod.cancelAllEffects()
#         case sound:
#         of sfxChew:
#             sound = sfxYawn
#         of sfxYawn:
#             sound = sfxChirp
#         of sfxChirp:
#             sound = sfxGiggle
#         of sfxGiggle:
#             sound = sfxPop
#         of sfxPop:
#             sound = sfxTummy
#         of sfxTummy:
#             sound = sfxChew
#     if keyIsDown(kiL) and volume > fp(0.0):
#         volume = volume - fp(0.1)
#         maxmod.setEffectsVolume(volume)
#     if keyIsDown(kiR) and volume < fp(1.0):
#         volume = volume + fp(0.1)
#         maxmod.setEffectsVolume(volume)


proc main =
    irq.put(iiVBlank, OnVBlank)
    seedtimer = 0
    bgcnt[0].init(prio = 0, cbb = 0, sbb = 8)
    bgcnt[0].is8bpp = true
    bgofs[0].x = (8).int16
    bgcnt[0].load(bgTitlenew)
    camInit()
    dispcnt.init(layers = {lBg0, lBg1, lBg2, lObj }, obj1d = true)
    for obj in mitems(objMem):
        obj.hide()
 
    maxmod.init(soundbankBin, 8)
    maxmod.setModuleVolume(volume.toFixed(10))
    sound = sfxChew
    gameMode = title
    maxmod.start(modFlower)
    

    while true:
        keyPoll()
        if keyIsDown(kiStart) and keyIsDown(kiSelect):
            SoftReset()
        update()
        #debug()
        maxmod.frame()
        VBlankIntrWait()

main()