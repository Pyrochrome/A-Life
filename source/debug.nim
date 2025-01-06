import natu/[video, input, math, maxmod]
import data/[variables, anim_index]
import oamdraw

type Direction = enum
    up = 0
    down
    left
    right

var curdirection = down

proc CheckClick()=
    if (click.hitbox.set1.x > pet.hitbox.set2.x or click.hitbox.set2.x < pet.hitbox.set1.x or click.hitbox.set1.y > pet.hitbox.set2.y or click.hitbox.set2.y < pet.hitbox.set1.y):
        discard
    else:
        maxmod.effect(sfxPop)

proc MovePet*()=
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

    if petstate == walking: 
        if (pet.cf == 1 or pet.cf == 3):
            case curdirection
                of up:
                    pet.coor.y = pet.coor.y - fp(0.1)
                    pet.coor.x = pet.coor.x - fp(0.2)
                    if pet.coor.x <= fp(128):
                        curdirection = left
                        setAnim(pet, petWalk1)
                        objMem[0].hflip = true
                of down:
                    pet.coor.y = pet.coor.y + fp(0.1)
                    pet.coor.x = pet.coor.x + fp(0.2)
                    if pet.coor.x >= fp(164):
                        curdirection = right
                        setAnim(pet, petWalk2)
                        objMem[0].hflip = true
                of left:
                    pet.coor.y = pet.coor.y + fp(0.1)
                    pet.coor.x = pet.coor.x - fp(0.2)
                    if pet.coor.x <= fp(74):
                        curdirection = down
                        setAnim(pet, petWalk1)
                        objMem[0].hflip = false
                of right:
                    pet.coor.y = pet.coor.y - fp(0.1)
                    pet.coor.x = pet.coor.x + fp(0.2)
                    if pet.coor.x >= fp(218):
                        curdirection = up
                        setAnim(pet, petWalk2)
                        objMem[0].hflip = false
    
    for a in actors:
        posInt = vec2i(a.coor)
        objMem[a.oam].pos = posInt
        a.hitbox.set1 = a.coor + offsets[a.oam].set1
        a.hitbox.set2 = a.coor + offsets[a.oam].set2