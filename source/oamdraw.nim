import natu/[video, bios, graphics, math]
import data/[variables, anim_index]



proc initActor*(a: var Actor)=

    posInt = vec2i(a.coor)

    objMem[a.oam] = initObj(
    pos = posInt, 
    tileId = allocObjTiles(a.graphic), 
    palId = acquireObjPal(a.graphic), 
    size = a.graphic.size,
    )

    copyFrame(addr objTileMem[objMem[a.oam].tileId], a.graphic, 0)


proc runAnim*()=
    for a in actors:
        currframe = anis[a.ca].frames[a.cf].int
        copyFrame(addr objTileMem[objMem[a.oam].tileId], a.graphic, currframe)
        a.anitimer += 1
        if a.anitimer == anis[a.ca].speed:
            if a.cf == anis[a.ca].frames.high:
                a.cf = 0
                if a == pet:
                    iterations += 1
                elif a != cursor:
                    loons[a.oam - 2].iter += 1
            else:
                a.cf += 1

            a.anitimer = 0


proc SetAnim*(a: Actor, i: ID)=
    a.ca = i
    a.cf = 0
    a.anitimer = 0
    if a == pet:
        iterations = 0
    elif a != cursor:
        loons[a.oam - 2].iter = 0

