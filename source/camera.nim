import natu/[math, video, bios, utils]
import data/[variables, anim_index]
import oamdraw

proc camInit*()=
    VBlankIntrWait()
    bgofs[1].x = (-camOffset.x).int16
    bgofs[1].y = (-camOffset.y).int16


proc Snapcam*(p: Vec2i)=
    camOffset = p
    camTarget = camOffset

                    

proc camScroll*()=
    if camTarget.y > camOffset.y:
        camOffset.y += 1
        if gameMode != credits:
            for a in actors:
                inc(a.coor.y, fp(1.0))
    elif camTarget.y < camOffset.y:
        camOffset.y -= 1
        if gameMode != credits:
            for a in actors:
                dec(a.coor.y, fp(1.0))


    if gameMode != title:
        for l in loons:
            case l.dirRight
            of false:
                if actors[l.act].ca == balMove:
                    actors[l.act].coor.x = actors[l.act].coor.x + fp(0.2)
                if actors[l.act].coor.x >= 236:
                    actors[l.act].coor.x = fp(-29)
                elif actors[l.act].ca == balPop and l.iter >= 2: 
                    actors[l.act].coor.x = fp(-29)                           
            of true:
                if actors[l.act].ca == balMove:
                    actors[l.act].coor.x = actors[l.act].coor.x - fp(0.2)
                if actors[l.act].coor.x <= -29:
                    actors[l.act].coor.x = fp(236)
                elif actors[l.act].ca == balPop and l.iter >= 2:
                    actors[l.act].coor.x = fp(236)

    for l in loons:
        if actors[l.act].coor.x < fp(236) and actors[l.act].coor.x > fp(-29):
            discard
        elif gameMode == minigame and minigameFlag == false:
            random = rand(4, 115)
            actors[l.act].coor.y = fp(random)
            SetAnim(actors[l.act], balMove)
            objMem[l.act].unhide()


    reticle.set1.x = cursor.coor.x + 9
    reticle.set1.y = cursor.coor.y + 9
    reticle.set2.x = reticle.set1.x + 13
    reticle.set2.y = reticle.set1.y + 13

    for a in actors[2..4]:
        loons[a.oam - 2].col.set1.x = a.coor.x + 4
        loons[a.oam - 2].col.set1.y = a.coor.y
        loons[a.oam - 2].col.set2.x = loons[a.oam - 2].col.set1.x + 23
        loons[a.oam - 2].col.set2.y = loons[a.oam - 2].col.set1.y + 23
        if a.ca == balPop and loons[(a.oam) - 2].iter != 0:
            objMem[a.oam].hide()

    
    for a in actors:
        posInt= vec2i(a.coor)
        objMem[a.oam].pos = posInt
    




   


