import natu/[video, math, bios, input, utils, maxmod]
import natu/[graphics, backgrounds]
import data/[variables, anim_index]
import camera, minigame, oamdraw, behavior

proc startMode*()=

    Snapcam(vec2i(-10, -96))
    camInit()
    initActor(pet)
    initActor(cursor)
    objMem[1].hide()
    initActor(balloon1)
    initActor(balloon2)
    initActor(balloon3)

    objMem[5] = initObj( #load berry
    pos = vec2i(32, 16),
    tileId = allocObjTiles(gfxBerry),  
    palId = acquireObjPal(gfxBerry),   
    size = gfxBerry.size,
    )

    objMem[6] = initObj( #load soap
    pos = vec2i(104, 16),
    tileId = allocObjTiles(gfxSoap),  
    palId = acquireObjPal(gfxSoap),   
    size = gfxSoap.size,
    )

    objMem[7] = initObj( #load balloon
    pos = vec2i(176, 16),
    tileId = allocObjTiles(gfxBall),  
    palId = acquireObjPal(gfxBall),   
    size = gfxBall.size,
    )

    objMem[8] = initObj( #load selection cursor
    pos = vec2i(16, 0),
    tileId = allocObjTiles(gfxSelect),  
    palId = acquireObjPal(gfxSelect),   
    size = gfxSelect.size,
    )

    copyFrame(addr objTileMem[objMem[5].tileId], gfxBerry, frame = 0)
    copyFrame(addr objTileMem[objMem[6].tileId], gfxSoap, frame = 0)
    copyFrame(addr objTileMem[objMem[7].tileId], gfxBall, frame = 0)
    copyFrame(addr objTileMem[objMem[8].tileId], gfxSelect, frame = 0)
    for i in 5..8:
        objMem[i].hide()
    bgcnt[1].load(bgHill)
    dispcnt.bg0 = false
    hunger = 0
    dirt = 0
    fun = 50
    timer = 500
    seed(seedtimer)

proc SelectIcon*()=
    case menuup:
        of false:
            for i in 5..8:
                objMem[i].unhide()
            menuup = true
        of true:
            for i in 5..8:
                objMem[i].hide()
            menuup = false

proc MenuHandler*()=
    if keyHit(kiA):
        case selector:
            of left:
                SelectIcon()
                petstate = eat
                SetAnim(pet, petChew)
                maxmod.effect(sfxChew)
            of middle:
                SelectIcon()
                petstate = bath
                SetAnim(pet, petBath)
                maxmod.effect(sfxWash)
                dirt = 0
            of right:
                SelectIcon()
                camTarget.y = 0
                minigameFlag = true
                petstate = idle
                SetAnim(pet, petIdle)
                startMinigame()



    if keyHit(kiLeft):
        case selector:
        of left:
            discard
        of middle:
            selector = left
            objMem[8].pos = selectleft
        of right:
            selector = middle
            objMem[8].pos = selectmiddle
    if keyHit(kiRight):
        case selector:
        of left:
            selector = middle
            objMem[8].pos = selectmiddle
        of middle:
            selector = right
            objMem[8].pos = selectright
        of right:
            discard

proc CheckStats()=
    case hunger
    of 46..100:
        if joy == true:
            joy = false
            IsHappy()
    of 0..45:
        if dirt > 30 or fun < 20:
            if joy == true:
                joy = false
                IsHappy()
        elif joy == false:
            joy = true
            IsHappy()
    else:
        discard

proc GetBrown()=
    case dirt
    of 0..24:
        dirtlevel = clean
        objPalBuf[15][2].r = 31
    of 25..49:
        dirtlevel = dusty
        objPalBuf[15][2].r = 28
    of 50..74:
        dirtlevel = dirty
        objPalBuf[15][2].r = 26
    of 75..100:
        dirtlevel = pigsty
        objPalBuf[15][2].r = 24
    else:
        discard

proc CheckDirt()=
    case dirtlevel
    of clean:
        if dirt < 25:
            discard
        else:
            GetBrown()
    of dusty:
        if dirt >= 25 and dirt < 50:
            discard
        else:
            GetBrown()         
    of dirty:
        if dirt >= 50 and dirt < 75:
            discard
        else:
            GetBrown()
    of pigsty:
        if dirt >= 75:
            discard
        else:
            GetBrown()

proc MainGame*()=
    timer = timer - 1
    if timer == 0:
        if hunger < 100:
            hunger = hunger + 3
        if dirt < 100:
            dirt += 2
        if fun >= 1:
            fun -= 1
        timer = 500
    CheckStats()
    CheckDirt()


    if keyHit(kiStart):
        case petstate
        of eat:
            discard
        of bath:
            discard
        of laugh:
            discard
        else:
            SelectIcon()
    elif menuup == true:
        MenuHandler()





