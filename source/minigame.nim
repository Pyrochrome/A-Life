import natu/[graphics, video, maxmod, math, input, mgba]
import data/[variables, anim_index]
import oamdraw



proc startMinigame*()=
    dispcnt.bg0 = false
    maxmod.start(modOct, mmPlayLoop)
    musicstate = fadeup
    
proc waitforCam*()=
    case gameMode
    of raisepet:
        if camOffset.y == 0:
            gameMode = minigame
            gametime = 2500
            # for i in 1..4:
            objMem[1].unhide()
            minigameFlag = false
    of minigame:
        if camOffset.y == -96:
            gameMode = raisepet
            petstate = laugh
            minigameFlag = false
            # printf(logDebug, "laugh")
    else:
        discard

proc fire*()=
    for l in loons:
        if (reticle.set1.x > l.col.set2.x or reticle.set2.x < l.col.set1.x or reticle.set1.y > l.col.set2.y or reticle.set2.y < l.col.set1.y):
            discard
        elif actors[l.act].ca == balMove:
            maxmod.effect(sfxPop)
            SetAnim(actors[l.act], balPop)
            if fun <= 99:
                fun += 1


proc endMinigame()=
    objMem[1].hide()
    for a in actors[2..4]:
        SetAnim(a, balPop)
        objMem[a.oam].hide()
    musicstate = fadedown
    camTarget.y = -96
    minigameFlag = true


proc playMinigame*()=
    gametime -= 1
    if gametime == 0:
        endMinigame()

    if keyIsDown(kiUp) and cursor.coor.y != 0:
        cursor.coor.y = cursor.coor.y - 2
    if keyIsDown(kiDown) and cursor.coor.y != 128:
        cursor.coor.y = cursor.coor.y + 2
    if keyIsDown(kiLeft) and cursor.coor.x != 0:
        cursor.coor.x = cursor.coor.x - 2
    if keyIsDown(kiRight) and cursor.coor.x != 208:
        cursor.coor.x = cursor.coor.x + 2
    if keyHit(kiA):
        fire()

    
    for a in actors:
        if a.ca == balPop and loons[(a.oam) - 2].iter != 0:
            SetAnim(a, balMove)
            objMem[a.oam].hide()


    # if keyHit(kiL) and volume >= fp(0.1):
    #     volume -= fp(0.1)
    #     maxmod.setModuleVolume(volume.toFixed(10))
    # elif keyHit(kiR) and volume <= fp(0.9):
    #     volume += fp(0.1)
    #     maxmod.setModuleVolume(volume.toFixed(10))

    




# 14 px left
# 14 px right
# 18 px up
# 10 px down



