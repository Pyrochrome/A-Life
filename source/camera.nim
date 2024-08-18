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
        #cameraOffset = camTarget
        camOffset.y += 1
        #bgofs[s].x = (-camOffset.x).int16
        #bgofs[1].y = (-camOffset.y).int16
        for a in actors:
            inc(a.coor.y, fp(1.0))
    elif camTarget.y < camOffset.y:
        camOffset.y -= 1
        #bgofs[s].x = (-camOffset.x).int16
        #bgofs[1].y = (-camOffset.y).int16
        for a in actors:
            dec(a.coor.y, fp(1.0))
    
    if gameMode != title:
        for l in loons:
            case l.dirRight
            of false:
                if actors[l.act].ca == balMove:
                    actors[l.act].coor.x = actors[l.act].coor.x + fp(0.2)
                if actors[l.act].coor.x >= 236: # -29
                    actors[l.act].coor.x = fp(-29)
                # elif actors[l.act].ca == balPop and l.iter >= 3:
                #     actors[l.act].coor.x = fp(-29)
                    if gameMode == minigame:
                        random = rand(4, 115)
                        actors[l.act].coor.y = fp(random)
                        SetAnim(actors[l.act], balMove)
                        objMem[l.act].unhide()
                    
            of true:
                if actors[l.act].ca == balMove:
                    actors[l.act].coor.x = actors[l.act].coor.x - fp(0.2)
                if actors[l.act].coor.x <= -29: # -29
                    actors[l.act].coor.x = fp(236)
                # elif actors[l.act].ca == balPop and l.iter >= 3:
                #     actors[l.act].coor.x = fp(236)
                    if gameMode == minigame:
                        random = rand(4, 115)
                        actors[l.act].coor.y = fp(random)
                        SetAnim(actors[l.act], balMove)
                        objMem[l.act].unhide()

        # if a.coor.x >= 236: # -29
        #     a.coor.x = fp(-29)

    reticle.set1.x = cursor.coor.x + 9
    reticle.set1.y = cursor.coor.y + 9
    reticle.set2.x = reticle.set1.x + 13
    reticle.set2.y = reticle.set1.y + 13

    for a in actors[2..4]:
        loons[a.oam - 2].col.set1.x = a.coor.x + 4
        loons[a.oam - 2].col.set1.y = a.coor.y
        loons[a.oam - 2].col.set2.x = loons[a.oam - 2].col.set1.x + 23
        loons[a.oam - 2].col.set2.y = loons[a.oam - 2].col.set1.y + 23

    
    for a in actors:
        posInt= vec2i(a.coor)
        objMem[a.oam].pos = posInt
    



   


