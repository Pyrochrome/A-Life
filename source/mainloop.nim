import natu/[video, utils, mgba, input, math, maxmod]
import natu/[graphics, backgrounds]
import data/[variables, anim_index]
import debug, oamdraw, save

proc begin*()=
    bgcnt[0].load(bgHouse)
    initActor(click)
    initActor(pet)

proc RandomState*()=
    random = rand(1, 100)
    seed(uint32(random + pet.cf * 4 ))
    printf(logDebug, "Seed: %d", random)
    if random >= 50:
        case petstate
        of walking:
            petstate = idle
            setAnim(pet, petIdle)
        else:
            petstate = walking
            case curdirection
            of up:
                setAnim(pet, petWalk2)
                objMem[1].hflip = false
            of down:
                setAnim(pet, petWalk1)
                objMem[1].hflip = false
            of left:
                setAnim(pet, petWalk1)
                objMem[1].hflip = true
            of right:
                setAnim(pet, petWalk2)
                objMem[1].hflip = true
    gametick = 0

proc CheckClick()=
    if (not(click.hitbox.set1.x > pet.hitbox.set2.x or click.hitbox.set2.x < pet.hitbox.set1.x or click.hitbox.set1.y > pet.hitbox.set2.y or click.hitbox.set2.y < pet.hitbox.set1.y)):
        maxmod.effect(sfxPop)
    else:
        for i in 2..4:
            if (not(click.hitbox.set1.x > offsets[i].set2.x or click.hitbox.set2.x < offsets[i].set1.x or click.hitbox.set1.y > offsets[i].set2.y or click.hitbox.set2.y < offsets[i].set1.y)):
                maxmod.effect(sfxPop)
                break
        discard
        

proc MovePet*()=
    gametick = gametick + 1
    if gametick >= 360:
        RandomState()
    keyPoll()
    if keyIsDown(kiUp):
        click.coor.y = click.coor.y - fp(1)
    if keyIsDown(kiDown):
        click.coor.y = click.coor.y + fp(1)
    if keyIsDown(kiLeft):
        click.coor.x = click.coor.x - fp(1)
    if keyIsDown(kiRight):
        click.coor.x = click.coor.x + fp(1)
    if keyHit(kiA):
        CheckClick()
    if keyHit(kiStart): 
        writeSave()
        printf(logDebug, "Wrote save.")
    if keyHit(kiSelect): 
        readSave()
        printf(logDebug, "Read save.")

    if petstate == walking: 
        if (pet.cf == 1 or pet.cf == 3):
            case curdirection
                of up:
                    pet.coor.y = pet.coor.y - fp(0.1)
                    pet.coor.x = pet.coor.x - fp(0.2)
                    if pet.coor.x <= fp(128):
                        curdirection = left
                        setAnim(pet, petWalk1)
                        objMem[1].hflip = true
                of down:
                    pet.coor.y = pet.coor.y + fp(0.1)
                    pet.coor.x = pet.coor.x + fp(0.2)
                    if pet.coor.x >= fp(164):
                        curdirection = right
                        setAnim(pet, petWalk2)
                        objMem[1].hflip = true
                of left:
                    pet.coor.y = pet.coor.y + fp(0.1)
                    pet.coor.x = pet.coor.x - fp(0.2)
                    if pet.coor.x <= fp(74):
                        curdirection = down
                        setAnim(pet, petWalk1)
                        objMem[1].hflip = false
                of right:
                    pet.coor.y = pet.coor.y - fp(0.1)
                    pet.coor.x = pet.coor.x + fp(0.2)
                    if pet.coor.x >= fp(218):
                        curdirection = up
                        setAnim(pet, petWalk2)
                        objMem[1].hflip = false
    
    for a in actors:
        posInt = vec2i(a.coor)
        objMem[a.oam].pos = posInt
        a.hitbox.set1 = a.coor + offsets[a.oam].set1
        a.hitbox.set2 = a.coor + offsets[a.oam].set2


proc RunGame*()=
    MovePet()
    inc(petattr.hunger)
    inc(petattr.fatigue)
