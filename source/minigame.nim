import natu/[graphics, video, maxmod, math, input, utils]
import data/[variables, anim_index]
import oamdraw



proc startMinigame*()=
    dispcnt.bg0 = false
    maxmod.start(modJump, mmPlayLoop)
    musicstate = fadeup



proc waitforCam*()=
    case gameMode
    of raisepet:
        if camOffset.y == 0:
            gameMode = minigame
            gametime = 2702
            objMem[1].unhide()
            minigameFlag = false
    of minigame:
        if camOffset.y == -96:
            gameMode = raisepet
            SetAnim(pet, petHappy)
            petstate = laugh
            maxmod.effect(sfxGiggle)
            minigameFlag = false

    else:
        discard

proc fire*()=
    for l in loons:
        if (reticle.set1.x > l.col.set2.x or reticle.set2.x < l.col.set1.x or reticle.set1.y > l.col.set2.y or reticle.set2.y < l.col.set1.y):
            discard
        elif actors[l.act].ca == balMove:
            maxmod.effect(sfxPop)
            SetAnim(actors[l.act], balPop)
            random = rand(1, 10)
            if random < 6:
                loons[l.act - 2].dirRight = true
            else:
                loons[l.act - 2].dirRight = false
            if fun <= 99:
                fun += 3


proc endMinigame()=
    objMem[1].hide()
    for a in actors[2..4]:
        SetAnim(a, balPop)
    musicstate = fadedown
    camTarget.y = -96
    minigameFlag = true



proc playMinigame*()=
    gametime -= 1
    if gametime == 0:
        endMinigame()

    if gametime > 2:
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

    







